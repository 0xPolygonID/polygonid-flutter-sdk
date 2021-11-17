import 'dart:typed_data';

import 'package:hex/hex.dart';

class HexUtils {
  static Uint8List hexToBytes(String hexStr) {
    final bytes = HEX.decode(strip0x(hexStr));
    if (bytes is Uint8List) return bytes;

    return Uint8List.fromList(bytes);
  }

  static BigInt hexToInt(String hex) {
    return BigInt.parse(strip0x(hex), radix: 16);
  }

  static String bytesToHex(List<int> bytes,
      {bool include0x = false,
      int? forcePadLength,
      bool padToEvenLength = false}) {
    var encoded = HEX.encode(bytes);

    if (forcePadLength != null) {
      assert(forcePadLength >= encoded.length);

      final padding = forcePadLength - encoded.length;
      encoded = ('0' * padding) + encoded;
    }

    if (padToEvenLength && encoded.length % 2 != 0) {
      encoded = '0$encoded';
    }

    return (include0x ? '0x' : '') + encoded;
  }

  static String strip0x(String hex) {
    if (hex.startsWith('0x')) return hex.substring(2);
    return hex;
  }
}
