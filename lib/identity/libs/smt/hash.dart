import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;

final _q = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617");

//@injectable
class Hash {
  final Uint8List data;

  Hash.zero() : data = Uint8List(32);

  Hash.fromUint8List(this.data) {
    assert(data.length == 32);
  }

  Hash.fromBigInt(BigInt i) : data = Uint8List(32) {
    if (i < BigInt.from(0)) {
      throw ArgumentError("BigInt must be positive");
    }

    if (i >= _q) {
      throw ArgumentError("BigInt must be less than $_q");
    }

    int bytes = (i.bitLength + 7) >> 3;
    final b = BigInt.from(256);
    for (int j = 0; j < bytes; j++) {
      data[j] = i.remainder(b).toInt();
      i = i >> 8;
    }
  }

  Hash.fromHex(String h) : data = Uint8List(32) {
    if (h.length != 64) {
      throw ArgumentError("Hex string must be 64 characters long");
    }
    convert.hex.decode(h).asMap().forEach((i, b) {
      data[i] = b;
    });
  }

  @override
  String toString() {
    return convert.hex.encode(data);
  }

  BigInt toBigInt() {
    final b = BigInt.from(256);
    BigInt i = BigInt.from(0);
    for (int j = data.length - 1; j >= 0; j--) {
      i = i * b + BigInt.from(data[j]);
    }
    return i;
  }

  bool testBit(int n) {
    if (n < 0 || n >= data.length * 8) {
      throw ArgumentError("n must be in range [0, ${data.length * 8}]");
    }
    return data[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  @override
  bool operator ==(Object other) {
    if (other is Hash) {
      for (int i = 0; i < data.length; i++) {
        if (data[i] != other.data[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll(data);
}
