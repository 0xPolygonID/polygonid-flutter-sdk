import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/eddsa_babyjub.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';
import 'package:web3dart/crypto.dart';

@injectable
class WalletLibWrapper {
  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    try {
      return PrivadoIdWallet.createPrivadoIdWallet(privateKey: privateKey);
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Signs message with bjjKey derived from private key
  /// @param [String] privateKey - privateKey
  /// @param [String] message - message to sign
  /// @returns [String] - Babyjubjub signature packed and encoded as an hex string
  Future<String> signMessage(
      {required Uint8List privateKey, required String message}) {
    BigInt? messHash;
    if (message.toLowerCase().startsWith("0x")) {
      message = strip0x(message);
      messHash = BigInt.tryParse(message, radix: 16);
    } else {
      messHash = BigInt.tryParse(message, radix: 10);
    }
    final bjjKey = PrivateKey(privateKey);
    if (messHash != null) {
      final signature = bjjKey.sign(messHash);
      return Future.value(signature);
    } else {
      return Future.value("");
    }
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
