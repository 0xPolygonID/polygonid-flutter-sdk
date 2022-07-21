import 'dart:typed_data';

import 'package:fast_base58/fast_base58.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/eddsa_babyjub.dart';
import 'package:polygonid_flutter_sdk/libs/iden3corelib.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/utils/hex_utils.dart';

@injectable
class WalletLibWrapper {
  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    try {
      return PrivadoIdWallet.createPrivadoIdWallet(privateKey: privateKey);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> signMessage(
      {required Uint8List privateKey, required String message}) {
    BigInt? messHash = BigInt.tryParse(message, radix: 10);
    final bbjjKey = PrivateKey(privateKey);
    final signature = bbjjKey.sign(messHash!);

    return Future.value(signature);
  }
}

class LibIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;
  final WalletLibWrapper _walletLibWrapper;

  LibIdentityDataSource(this._iden3coreLib, this._walletLibWrapper);

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

  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    return _walletLibWrapper.createWallet(privateKey: privateKey);
  }

  Future<String> signMessage(
      {required Uint8List privateKey, required String message}) {
    return _walletLibWrapper.signMessage(
        privateKey: privateKey, message: message);
  }
}
