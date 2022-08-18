import 'dart:typed_data';

import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/utils/hex_utils.dart';

import '../iden3core/iden3core.dart';

class LibIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;

  LibIdentityDataSource(this._iden3coreLib);

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
}
