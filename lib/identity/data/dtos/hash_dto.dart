import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';

part 'hash_dto.g.dart';

final _q = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617");

/// Represents an identity state hash DTO.
@JsonSerializable()
class HashDTO extends Equatable {
  final String data;

  const HashDTO({required this.data});

  HashDTO.zero() : data = HexMapper().mapFrom(Uint8List(32));

  HashDTO.fromUint8List(this.data) {
    assert(data.length == 32);
  }

  HashDTO.fromBigInt(BigInt i) : data = HexMapper().mapFrom(Uint8List(32)) {
    Uint8List dataBytes = Uint8List(32);
    if (i < BigInt.from(0)) {
      throw ArgumentError("BigInt must be positive");
    }

    if (i >= _q) {
      throw ArgumentError("BigInt must be less than $_q");
    }

    int bytes = (i.bitLength + 7) >> 3;
    final b = BigInt.from(256);
    for (int j = 0; j < bytes; j++) {
      HexMapper().mapTo(data)[j] = i.remainder(b).toInt();
      i = i >> 8;
    }
  }

  HashDTO.fromHex(String h) : data = HexMapper().mapFrom(Uint8List(32)) {
    if (h.length != 64) {
      throw ArgumentError("Hex string must be 64 characters long");
    }
    convert.hex.decode(h).asMap().forEach((i, b) {
      HexMapper().mapTo(data)[i] = b;
    });
  }

  factory HashDTO.fromJson(Map<String, dynamic> json) =>
      _$HashDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HashDTOToJson(this);

  BigInt toBigInt() {
    final b = BigInt.from(256);
    BigInt i = BigInt.from(0);
    for (int j = HexMapper().mapTo(data).length - 1; j >= 0; j--) {
      i = i * b + BigInt.from(HexMapper().mapTo(data)[j]);
    }
    return i;
  }

  bool testBit(int n) {
    if (n < 0 || n >= data.length * 8) {
      throw ArgumentError("n must be in range [0, ${data.length * 8}]");
    }
    return HexMapper().mapTo(data)[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  @override
  bool operator ==(Object other) {
    if (other is HashDTO) {
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
  int get hashCode => Object.hashAll(HexMapper().mapTo(data));

  @override
  List<Object?> get props => [data];
}
