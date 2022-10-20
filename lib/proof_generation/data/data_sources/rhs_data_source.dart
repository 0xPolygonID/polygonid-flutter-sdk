import 'package:flutter/services.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../identity/data/data_sources/remote_identity_data_source.dart';
import '../../../identity/data/dtos/rhs_node_dto.dart';
import '../../../identity/data/mappers/rhs_node_type_mapper.dart';
import '../../../identity/domain/entities/rhs_node_entity.dart';

class RhsDataSource {
  final RemoteIdentityDataSource _remoteIdentityDataSource;

  RhsDataSource(this._remoteIdentityDataSource);

  Future<Map<String, dynamic>> nonRevProof(
      int revNonce, String idStateHash, String rhsBaseUrl) async {
    try {
      // 1. Fetch state roots from RHS
      RhsNodeDTO rhsNode = await _remoteIdentityDataSource.fetchStateRoots(
          url: rhsBaseUrl + idStateHash);
      RhsNodeType rhsNodeType = RhsNodeTypeMapper().mapFrom(rhsNode.node);

      String revTreeRootHash =
          "0000000000000000000000000000000000000000000000000000000000000000";
      if (rhsNodeType == RhsNodeType.state) {
        revTreeRootHash = rhsNode.node.children[1];
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
          RhsNodeDTO revNode = await _remoteIdentityDataSource.fetchStateRoots(
              url: rhsBaseUrl + nextKey);
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
              return _mkProof(exists, siblings, null);
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
            return _mkProof(exists, siblings, nodeAux);
          }
        } else {
          return _mkProof(exists, siblings, null);
        }
      }
      return _mkProof(false, <String>[], null);
    } catch (error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");
      rethrow;
    }
  }

  // TestBit tests whether the bit n in bitmap is 1.
  bool _testBit(Uint8List byte, int n) {
    return byte[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  Map<String, dynamic> _mkProof(
      bool exists, List<String> siblings, Map<String, String>? nodeAux) {
    Map<String, dynamic> result = {
      "existence": exists,
      "siblings": siblings,
    };
    if (nodeAux != null) {
      result["nodeAux"] = nodeAux;
    }
    return result;
  }
}
