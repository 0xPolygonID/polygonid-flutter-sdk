import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';

extension BigIntQ on BigInt {
  static BigInt Q = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617",
  );

  bool checkBigIntInField() {
    return this < Q;
  }

  BigInt qNormalize() {
    if (this < Q) {
      return this;
    }

    return this % Q;
  }

  Uint8List toBytes() {
    final hex = toRadixString(16);
    final normalizedHex = hex.length.isOdd ? '0$hex' : hex;
    return normalizedHex.hexToBytes();
  }
}
