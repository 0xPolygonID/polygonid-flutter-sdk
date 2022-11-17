import 'package:polygonid_flutter_sdk/proof_generation/domain/exceptions/proof_generation_exceptions.dart';

import '../../libs/iden3core/iden3core.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';

class LibIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;

  LibIdentityDataSource(
    this._iden3coreLib,
  );

  Future<String> getId(String id) {
    return Future.value(_iden3coreLib.getIdFromString(id)).then((libId) {
      if (libId.isEmpty) {
        throw GenerateNonRevProofException(id);
      }

      return libId;
    });
  }

  ///
  Future<String> getClaimsTreeRoot(
      {required String pubX, required String pubY}) {
    try {
      String claimsTreeRoot = _iden3coreLib.generateClaimsTreeRoot(pubX, pubY);
      return Future.value(claimsTreeRoot);
      /*Uint8List hex = HexUtils.hexToBytes(claimsTreeRoot);


      return Future.value(Base58Encode(hex));*/
    } catch (e) {
      return Future.error(e);
    }
  }

  ///
  Future<String> getAuthClaim({required String pubX, required String pubY}) {
    try {
      String authClaim = _iden3coreLib.getAuthClaim(pubX, pubY);

      return Future.value(authClaim);
    } catch (e) {
      return Future.error(e);
    }
  }

  HashDTO getNodeHash(NodeDTO node) {
    switch (node.type) {
      case NodeTypeDTO.leaf:
        return _iden3coreLib.poseidonHashHashes([
          node.children[0],
          node.children[1],
          HashDTO.fromBigInt(BigInt.one)
        ]);
      case NodeTypeDTO.middle:
        return _iden3coreLib
            .poseidonHashHashes(node.children /*[node.childL, node.childR]*/);
      default:
        return HashDTO.zero();
    }
  }

  /// FIXME: no passing repo and lib as params
  // Future<String> createSMT(SMTStorageRepository smtStorageRepository) {
  //   try {
  //     return Future.value((MerkleTree(_iden3coreLib, smtStorageRepository, 32)
  //             .storage as SMTMemoryStorageRepositoryImpl)
  //         .toJson()
  //         .toString());
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}
