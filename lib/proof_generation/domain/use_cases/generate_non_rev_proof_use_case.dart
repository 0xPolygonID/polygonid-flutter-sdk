import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_state_roots_use_case.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/domain/use_case.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../identity/domain/use_cases/fetch_identity_state_use_case.dart';
import '../exceptions/proof_generation_exceptions.dart';
import '../repositories/proof_repository.dart';

class GenerateNonRevProofParam {
  final String id;
  final String rhsBaseUrl;
  final int revNonce;

  GenerateNonRevProofParam(this.id, this.rhsBaseUrl, this.revNonce);
}

class GenerateNonRevProofUseCase
    extends FutureUseCase<GenerateNonRevProofParam, Map<String, dynamic>> {
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;
  final FetchStateRootsUseCase _fetchStateRootsUseCase;
  final ProofRepository _proofRepository;

  GenerateNonRevProofUseCase(this._fetchIdentityStateUseCase,
      this._fetchStateRootsUseCase, this._proofRepository);

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

  @override
  Future<Map<String, dynamic>> execute(
      {required GenerateNonRevProofParam param}) async {
    try {
      // 1. Fetch identity latest state from the smart contract.
      String idStateHash = await _fetchIdentityStateUseCase.execute(
          param: FetchIdentityStateParam(id: param.id));

      if (idStateHash == "") {
        throw GenerateNonRevProofException(idStateHash);
      }
      // 2. Fetch state roots from RHS
      RhsNodeEntity rhsNode = await _fetchStateRootsUseCase.execute(
          param: FetchStateRootsParam(
              rhsBaseUrl: param.rhsBaseUrl, idStateHash: idStateHash));

      String revTreeRootHash =
          "0000000000000000000000000000000000000000000000000000000000000000";
      if (rhsNode.nodeType == RhsNodeType.state) {
        revTreeRootHash = rhsNode.node["children"][1];
      }

      //3. walk rhs
      bool exists = false;
      List<String> siblings = <String>[];
      String nextKey = revTreeRootHash;
      int depth = 0;
      Uint8List key =
          Uint8ArrayUtils.bigIntToBytes(BigInt.from(param.revNonce));

      for (int depth = 0; depth < (key.length * 8); depth++) {
        if (nextKey !=
            "0000000000000000000000000000000000000000000000000000000000000000") {
          // rev root is not empty
          RhsNodeEntity revNode = await _fetchStateRootsUseCase.execute(
              param: FetchStateRootsParam(
                  rhsBaseUrl: param.rhsBaseUrl, idStateHash: nextKey));

          if (revNode.nodeType == RhsNodeType.middle) {
            if (_testBit(key, depth)) {
              nextKey = revNode.node["children"][1];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node["children"][0]))
                  .toString());
            } else {
              nextKey = revNode.node["children"][0];
              siblings.add(Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node["children"][1]))
                  .toString());
            }
          } else if (revNode.nodeType == RhsNodeType.leaf) {
            if (Uint8ArrayUtils.leBuff2int(key) ==
                Uint8ArrayUtils.leBuff2int(
                    hexToBytes(revNode.node["children"][0]))) {
              exists = true;
              return _mkProof(exists, siblings, null);
            }
            // We found a leaf whose entry didn't match hIndex
            Map<String, String> nodeAux = {
              "key": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node["children"][0]))
                  .toString(),
              "value": Uint8ArrayUtils.leBuff2int(
                      hexToBytes(revNode.node["children"][1]))
                  .toString(),
            };
            return _mkProof(exists, siblings, nodeAux);
          }
        } else {
          return _mkProof(exists, siblings, null);
        }
      }
    } catch (error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");
      throw error;
    }
  }
}
