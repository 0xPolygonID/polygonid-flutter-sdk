import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../proof_generation/domain/exceptions/proof_generation_exceptions.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../libs/iden3core/iden3core.dart';
import '../../libs/rhs/state_contract.dart';
import '../mappers/rhs_node_type_mapper.dart';

class RemoteIdentityDataSource {
  final Client client;
  final Web3Client web3Client;
  final Iden3CoreLib iden3CoreLib;

  RemoteIdentityDataSource(this.client, this.web3Client, this.iden3CoreLib);

  Future<String> fetchIdentityState({required String id}) async {
    try {
      return StateContract(web3Client, iden3CoreLib).getState(id);
    } catch (error) {
      logger().e('identity state error: $error');
      throw FetchIdentityStateException(error);
    }
  }

  Future<RhsNodeDTO> fetchStateRoots({required String url}) async {
    try {
      //fetch rhs state and save it
      String rhsId = url;
      String rhsUrl = rhsId;
      if (rhsId.toLowerCase().startsWith("ipfs://")) {
        String fileHash = rhsId.toLowerCase().replaceFirst("ipfs://", "");
        rhsUrl = "https://ipfs.io/ipfs/$fileHash";
      }
      var rhsUri = Uri.parse(rhsUrl);
      var rhsResponse = await get(rhsUri);
      if (rhsResponse.statusCode == 200) {
        Map<String, dynamic>? rhsNode = json.decode(rhsResponse.body);
        RhsNodeDTO rhsNodeResponse = RhsNodeDTO.fromJson(rhsNode!);
        logger().d('rhs node: ${rhsNodeResponse.toString()}');
        return rhsNodeResponse;
      } else {
        throw NetworkException(rhsResponse);
      }
    } catch (error) {
      logger().e('state roots error: $error');
      throw FetchStateRootsException(error);
    }
  }

  Future<Map<String, dynamic>> nonRevProof(
      int revNonce, String id, String rhsBaseUrl) async {
    try {
      // 1. Fetch identity latest state from the smart contract
      String idStateHash = await fetchIdentityState(id: id);

      if (idStateHash == "") {
        throw GenerateNonRevProofException(idStateHash);
      }

      // 1. Fetch state roots from RHS
      RhsNodeDTO rhsNode = await fetchStateRoots(url: rhsBaseUrl + idStateHash);
      RhsNodeType rhsNodeType = RhsNodeTypeMapper().mapFrom(rhsNode.node);

      Map<String, dynamic>? issuer;
      String revTreeRootHash =
          "0000000000000000000000000000000000000000000000000000000000000000";
      if (rhsNodeType == RhsNodeType.state) {
        revTreeRootHash = rhsNode.node.children[1];
        issuer = {
          "state": rhsNode.node.hash,
          "root_of_roots": rhsNode.node.children[2],
          "claims_tree_root": rhsNode.node.children[0],
          "revocation_tree_root": rhsNode.node.children[1],
        };
      }

      //2. walk rhs
      bool exists = false;
      List<String> siblings = <String>[];
      String nextKey = revTreeRootHash;
      int depth = 0;
      Uint8List key = Uint8ArrayUtils.bigIntToBytes(BigInt.from(revNonce));

      for (int depth = 0; depth < (key.length * 8); depth++) {
        if (nextKey !=
            "0000000000000000000000000000000000000000000000000000000000000000") {
          // rev root is not empty
          RhsNodeDTO revNode = await fetchStateRoots(url: rhsBaseUrl + nextKey);
          RhsNodeType nodeType = RhsNodeTypeMapper().mapFrom(revNode.node);

          if (nodeType == RhsNodeType.middle) {
            if (_testBit(key, depth)) {
              nextKey = revNode.node.children[1];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[0]))
                  .toString());
            } else {
              nextKey = revNode.node.children[0];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[1]))
                  .toString());
            }
          } else if (nodeType == RhsNodeType.leaf) {
            if (Uint8ArrayUtils.leBuff2int(key) ==
                Uint8ArrayUtils.leBuff2int(
                    hexToBytes(revNode.node.children[0]))) {
              exists = true;
              return _mkProof(issuer, exists, siblings, null);
            }
            // We found a leaf whose entry didn't match hIndex
            Map<String, String> nodeAux = {
              "key": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[0]))
                  .toString(),
              "value": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node.children[1]))
                  .toString(),
            };
            return _mkProof(issuer, exists, siblings, nodeAux);
          }
        } else {
          return _mkProof(issuer, exists, siblings, null);
        }
      }
      return _mkProof(issuer, false, <String>[], null);
    } catch (error) {
      logger().e("[NonRevProof] Error: $error");
      rethrow;
    }
  }

  // TestBit tests whether the bit n in bitmap is 1.
  bool _testBit(Uint8List byte, int n) {
    return byte[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  Map<String, dynamic> _mkProof(Map<String, dynamic>? issuer, bool exists,
      List<String> siblings, Map<String, String>? nodeAux) {
    Map<String, dynamic> result = {};

    if (issuer != null) {
      result["issuer"] = issuer;
    }

    Map<String, dynamic> mtp = {
      "existence": exists,
      "siblings": siblings,
    };
    if (nodeAux != null) {
      mtp["nodeAux"] = nodeAux;
    }
    result["mtp"] = mtp;

    return result;
  }
}
