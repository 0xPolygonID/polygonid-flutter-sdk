import 'dart:typed_data';

import 'package:web3dart/crypto.dart';

extension BigIntQ on BigInt {
  static BigInt Q = BigInt.parse(
      "21888242871839275222246405745257275088548364400416034343698204186575808495617");

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
    return hexToBytes(toRadixString(16));
  }
}
