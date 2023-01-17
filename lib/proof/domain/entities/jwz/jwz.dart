import 'package:polygonid_flutter_sdk/common/utils/base_64.dart';

import 'jwz_header.dart';
import 'jwz_proof.dart';

/// Wrapper for [JWZEntity] payload
class JWZPayload {
  final dynamic payload;

  JWZPayload({required this.payload});

  @override
  String toString() => "[JWZPayload] {payload: $payload}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JWZPayload &&
          runtimeType == other.runtimeType &&
          payload == other.payload;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// JSON Web Zero-knowledge (JWZ) is an open standard
/// for representing messages proven by zero-knowledge technology.
class JWZEntity {
  final JWZHeader? header;
  final JWZPayload? payload;
  JWZProof? proof;

  JWZEntity({this.header, required this.payload, this.proof});

  /// FIXME: should we move this to a mapper?
  factory JWZEntity.fromBase64(String data) {
    var split = data.split(".");

    return JWZEntity(
        header: JWZHeader.fromBase64(split[0]),
        payload: JWZPayload(payload: Base64Util.decode(split[1])),
        proof: split.length == 3 ? JWZProof.fromBase64(split[2]) : null);
  }

  @override
  String toString() =>
      "[JWZEntity] {header: $header, payload: $payload, proof: $proof}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JWZEntity &&
          runtimeType == other.runtimeType &&
          header == other.header &&
          payload == other.payload &&
          proof == other.proof;

  @override
  int get hashCode => runtimeType.hashCode;
}
