import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/utils/base_64.dart';

part 'jwz_header.g.dart';

/// Sample
/// ```
/// {
///     "alg": "groth16",
///     "circuitId": "auth",
///     "crit": [
///         "circuitId"
///     ],
///     "typ": "application/iden3-zkp-json"
/// }
/// ```
@JsonSerializable()
class JWZHeader extends Equatable with Base64Encoder {
  final String alg;
  final String circuitId;
  final List<String> crit;
  final String typ;

  JWZHeader(
      {required this.alg,
      required this.circuitId,
      required this.crit,
      required this.typ});

  factory JWZHeader.fromBase64(String data) =>
      JWZHeader.fromJson(jsonDecode(Base64Util.decode(data)));

  factory JWZHeader.fromJson(Map<String, dynamic> json) =>
      _$JWZHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$JWZHeaderToJson(this);

  @override
  List<Object?> get props => [alg, circuitId, crit, typ];
}
