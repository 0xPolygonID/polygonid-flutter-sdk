import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/rhs_node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';
import '../mappers/node_type_dto_mapper.dart';
import '../mappers/rhs_node_type_mapper.dart';

/// FIXME: inject http client (for source and UT mocking)
class RemoteIdentityDataSource {
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
        Map<String, dynamic> rhsNode = json.decode(rhsResponse.body);
        rhsNode['node']['children'] =
            (rhsNode['node']['children'] as List<dynamic>)
                .map((e) => HashDTO.fromHex(e as String).toJson())
                .toList();
        rhsNode['node']['hash'] =
            HashDTO.fromHex((rhsNode['node']['hash'] as String)).toJson();
        rhsNode['node']['type'] = "unknown";
        rhsNode['node']['type'] =
            NodeTypeDTOMapper().mapFrom(NodeDTO.fromJson(rhsNode['node'])).name;
        RhsNodeDTO rhsNodeResponse = RhsNodeDTO.fromJson(rhsNode);
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

  Future<Map<String, dynamic>> getNonRevocationProof(
      String identityState, BigInt revNonce, String rhsBaseUrl) async {
    try {
      /// FIXME: this 2 lines should go to a DS and be called in a repo
      // 1. Fetch state roots from RHS
      RhsNodeDTO rhsNode =
          await fetchStateRoots(url: rhsBaseUrl + "/" + identityState);
      RhsNodeType rhsNodeType = RhsNodeTypeMapper().mapFrom(rhsNode.node);
      StateIdentifierMapper identifierMapper = StateIdentifierMapper();

      Map<String, dynamic>? issuer;
      String revTreeRootHash =
          "0000000000000000000000000000000000000000000000000000000000000000";
      if (rhsNodeType == RhsNodeType.state) {
        revTreeRootHash = rhsNode.node.children[1].toString();
        issuer = {
          "state": identifierMapper.mapTo(rhsNode.node.hash.toString()),
          "rootOfRoots":
              identifierMapper.mapTo(rhsNode.node.children[2].toString()),
          "claimsTreeRoot":
              identifierMapper.mapTo(rhsNode.node.children[0].toString()),
          "revocationTreeRoot":
              identifierMapper.mapTo(rhsNode.node.children[1].toString()),
        };
      }

      //2. walk rhs
      bool exists = false;
      List<String> siblings = <String>[];
      String nextKey = revTreeRootHash;
      int depth = 0;
      Uint8List key = Uint8ArrayUtils.bigIntToBytes(revNonce);

      for (int depth = 0; depth < (key.length * 8); depth++) {
        if (BigInt.parse(nextKey) != BigInt.zero) {
          // rev root is not empty
          RhsNodeDTO revNode = await fetchStateRoots(
              url: rhsBaseUrl + "/" + identifierMapper.mapTo(nextKey));
          RhsNodeType nodeType = RhsNodeTypeMapper().mapFrom(revNode.node);

          if (nodeType == RhsNodeType.middle) {
            if (_testBit(key, depth)) {
              nextKey = revNode.node.children[1].toString();
              siblings.add(revNode.node.children[0].toString());
            } else {
              nextKey = revNode.node.children[0].toString();
              siblings.add(revNode.node.children[1].toString());
            }
          } else if (nodeType == RhsNodeType.leaf) {
            if (Uint8ArrayUtils.leBuff2int(key).toString() ==
                revNode.node.children[0].toString()) {
              exists = true;
              return _mkProof(issuer, exists, siblings, null);
            }
            // We found a leaf whose entry didn't match hIndex
            Map<String, String> nodeAux = {
              "key": revNode.node.children[0].toString(),
              "value": revNode.node.children[1].toString(),
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
