import 'dart:typed_data';

import '../../../common/utils/base_64.dart';
import 'jwz.dart';
import 'jwz_exceptions.dart';
import 'jwz_proof.dart';

/// Prove and verify a [JWZToken]
abstract class JWZProver {
  String alg;
  String circuitID;

  Future<bool> verify(
      Uint8List hash, JWZProof proof, Uint8List verificationKey);

  Future<JWZProof> prove(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm);

  JWZProver({required this.alg, required this.circuitID});
}

/// Prepare circuit inputs
abstract class JWZInputPreparer {
  Future<Uint8List> prepare(Uint8List hash, String circuitID);
}

/// Representation of a JWZ Token with [JWZProver] and [JWZInputPreparer]
/// Wrapper around [JWZ]
class JWZToken implements Base64Encoder {
  late JWZ jwz;

  JWZToken();

  /// Construct a [JWZToken] with [JWZ]
  factory JWZToken.withJWZ({required JWZ jwz}) {
    JWZToken token = JWZToken();
    token.jwz = jwz;

    return token;
  }

  /// Construct a [JWZToken] with payload
  factory JWZToken.withPayload({required dynamic payload}) {
    return JWZToken.withJWZ(jwz: JWZ(payload: JWZPayload(payload: payload)));
  }

  /// Construct a [JWZToken] from a Base64 string
  factory JWZToken.fromBase64({required String data}) {
    return JWZToken.withJWZ(jwz: JWZ.fromBase64(data));
  }

  /// Returns compact [JWT]
  @override
  String encode() {
    if (jwz.header == null) {
      throw NullJWZHeaderException();
    }

    if (jwz.payload == null) {
      throw NullJWZPayloadException();
    }

    if (jwz.proof == null) {
      throw NullJWZProofException();
    }

    return jwz.encode();
  }
}
