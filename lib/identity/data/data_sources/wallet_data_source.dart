import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';

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
      message = message.strip0x();
      messHash = message.hexToBytes();
    } else {
      var hex = BigInt.parse(message, radix: 10).toRadixString(16);
      hex = hex.length.isEven ? hex : "0$hex";
      messHash = hex.hexToBytes();
    }
    final bjjKey = BjjPrivateKey(privateKey);
    final signature = bjjKey.sign(messHash);
    return signature.bytesToHex();
  }
}
