import 'dart:convert';
import 'dart:typed_data';

import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/identity/libs/smt/merkletree.dart';

import '../../../common/utils/hex_utils.dart';
import '../../domain/repositories/smt_storage_repository.dart';
import '../../libs/iden3core/iden3core.dart';

class LibIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;
  final SMTStorageRepository _smtStorageRepository;

  LibIdentityDataSource(this._iden3coreLib, this._smtStorageRepository);

  Future<String> getIdentifier({required String pubX, required String pubY}) {
    try {
      Map<String, String> map = _iden3coreLib.generateIdentity(pubX, pubY);
      Uint8List hex = HexUtils.hexToBytes(map['id']!);

      return Future.value(Base58Encode(hex));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> getAuthClaim({required String pubX, required String pubY}) {
    try {
      String authClaim = _iden3coreLib.getAuthClaim(pubX, pubY);

      return Future.value(authClaim);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> createSMT(SMTStorageRepository smtStorageRepository) {
    try {
      return Future.value(
          json.encode(MerkleTree(_iden3coreLib, smtStorageRepository, 32)));
    } catch (e) {
      return Future.error(e);
    }
  }
}
