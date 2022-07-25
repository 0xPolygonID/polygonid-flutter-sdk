import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/eddsa_babyjub.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

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

class WalletDataSource {
  final WalletLibWrapper _walletLibWrapper;

  WalletDataSource(this._walletLibWrapper);

  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    return _walletLibWrapper.createWallet(privateKey: privateKey);
  }

  Future<String> signMessage(
      {required Uint8List privateKey, required String message}) {
    return _walletLibWrapper.signMessage(
        privateKey: privateKey, message: message);
  }
}
