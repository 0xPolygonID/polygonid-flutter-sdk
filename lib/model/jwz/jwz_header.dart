import 'package:json_annotation/json_annotation.dart';
import 'package:privadoid_sdk/utils/Base64Encoder.dart';

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
class JWZHeader with Base64Encoder {
  String alg;
  String circuitId;
  List<String> crit;
  String typ;

  JWZHeader(
      {required this.alg,
      required this.circuitId,
      required this.crit,
      required this.typ});

  factory JWZHeader.fromJson(Map<String, dynamic> json) =>
      _$JWZHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$JWZHeaderToJson(this);
}
