import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';

import '../../../common/utils/uint8_list_utils.dart';

//part 'hash_dto.g.dart';

final _q = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617");

/// Represents an identity state hash DTO.
//@JsonSerializable(explicitToJson: true)
class HashDTO extends Equatable {
  final Uint8List data; // hex string 64 chars - big int string 77 chars

  const HashDTO({required this.data});

  HashDTO.zero() : data = Uint8List(32);

  HashDTO.fromUint8List(this.data) {
    assert(data.length == 32);
  }

  HashDTO.fromBigInt(BigInt i) : data = Uint8List(32) {
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

  HashDTO.fromHex(String h) : data = Uint8List(32) {
    if (h.length != 64) {
      throw ArgumentError("Hex string must be 64 characters long");
    }
    HexMapper().mapTo(h).asMap().forEach((i, b) {
      data[i] = b;
    });
  }

  factory HashDTO.fromJson(Map<String, dynamic> json) =>
      HashDTO.fromBigInt(BigInt.parse(json["data"]));
  //_$HashDTOFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': toBigInt().toString(),
      };

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

  // TestBit tests whether the bit n in bitmap is 1.
  bool _testBit(Uint8List byte, int n) {
    return data[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  @override
  bool operator ==(Object other) {
    if (other is HashDTO) {
      if (data.length != other.data.length) {
        return false;
      }
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
  String toString() {
    return Uint8ArrayUtils.bytesToBigInt(data).toString();
  }

  @override
  int get hashCode => Object.hashAll(data);

  @override
  List<Object?> get props => [data];
}
