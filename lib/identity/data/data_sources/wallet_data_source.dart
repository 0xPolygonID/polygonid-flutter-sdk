import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:web3dart/crypto.dart';

import '../../libs/bjj/eddsa_babyjub.dart';
import '../../libs/bjj/privadoid_wallet.dart';

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
      throw const FormatException("message string couldnt be parsed as BigInt");
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
