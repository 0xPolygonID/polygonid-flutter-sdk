import 'package:equatable/equatable.dart';
import 'package:privadoid_sdk/model/jwz/jwz_header.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';
import 'package:privadoid_sdk/utils/base_64.dart';

/// Wrapper for [JWZ] payload
class JWZPayload extends Equatable with Base64Encoder {
  final dynamic payload;

  JWZPayload({required this.payload});

  @override
  String encode() {
    return Base64Util.encode64(payload);
  }

  @override
  List<Object?> get props => [payload];
}

/// JSON Web Zero-knowledge (JWZ) is an open standard
/// for representing messages proven by zero-knowledge technology.
class JWZ extends Equatable with Base64Encoder {
  JWZHeader? header;
  final JWZPayload? payload;
  JWZProof? proof;

  JWZ({this.header, required this.payload, this.proof});

  factory JWZ.fromBase64(String data) {
    var split = data.split(".");

    return JWZ(
        header: JWZHeader.fromBase64(split[0]),
        payload: JWZPayload(payload: Base64Util.decode(split[1])),
        proof: split.length == 3 ? JWZProof.fromBase64(split[2]) : null);
  }

  @override
  String encode() {
    return "${header?.encode()}.${payload?.encode()}.${proof?.encode()}";
  }

  @override
  List<Object?> get props => [header, payload, proof];
}
