import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';

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
class JWZHeader {
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

  factory JWZHeader.fromJson(Map<String, dynamic> json) => JWZHeader(
        alg: json['alg'] as String,
        circuitId: json['circuitId'] as String,
        crit: (json['crit'] as List<dynamic>).map((e) => e as String).toList(),
        typ: json['typ'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'alg': alg,
        'circuitId': circuitId,
        'crit': crit,
        'typ': typ,
      };

  @override
  String toString() =>
      "[JWZHeader] {alg: $alg, circuitId: $circuitId, crit: $crit, typ: $typ}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JWZHeader &&
          runtimeType == other.runtimeType &&
          alg == other.alg &&
          circuitId == other.circuitId &&
          listEquals(crit, other.crit) &&
          typ == other.typ;

  @override
  int get hashCode => runtimeType.hashCode;
}
