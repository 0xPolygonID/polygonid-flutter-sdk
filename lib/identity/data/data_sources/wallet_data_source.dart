import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';
import 'package:web3dart/web3dart.dart';

@injectable
class WalletDataSource {
  WalletDataSource();

  /// Signs message with bjjKey derived from private key
  /// @param [String] privateKey - privateKey
  /// @param [String] message - message to sign
  /// @returns [String] - Babyjubjub signature packed and encoded as an hex string
  Future<String> signMessage({
    required Uint8List privateKey,
    required String message,
  }) async {
    Uint8List messHash;
    if (message.toLowerCase().startsWith("0x")) {
      message = strip0x(message);
      messHash = hexToBytes(message);
    } else {
      var hex = BigInt.parse(message, radix: 10).toRadixString(16);
      hex = hex.length.isEven ? hex : "0$hex";
      messHash = hexToBytes(hex);
    }
    final bjjKey = BjjPrivateKey(privateKey);
    final signature = bjjKey.sign(messHash);
    return bytesToHex(signature);
  }
}
