import 'dart:typed_data';

import 'package:privadoid_sdk/model/jwz/jwz.dart';
import 'package:privadoid_sdk/model/jwz/jwz_exceptions.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';
import 'package:privadoid_sdk/utils/Base64.dart';

abstract class JWZProver {
  String alg;
  String circuitID;

  Future<bool> verify(
      Uint8List hash, JWZProof proof, Uint8List verificationKey);

  Future<JWZProof> prove(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm);

  JWZProver({required this.alg, required this.circuitID});
}

abstract class JWZInputPreparer {
  Uint8List prepare(Uint8List hash, String circuitID);
}

abstract class JWZHashPreparer {
  Uint8List prepareForHash();
}

class JWZToken implements Base64Encoder {
  String get alg => prover.alg;

  String get circuitID => prover.circuitID;
  late JWZ jwz;
  JWZProver prover;
  JWZInputPreparer preparer;

  JWZToken({required this.prover, required this.preparer});

  factory JWZToken.withJWZ(
      {required JWZ jwz,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    JWZToken token = JWZToken(prover: prover, preparer: preparer);
    token.jwz = jwz;

    return token;
  }

  factory JWZToken.withPayload(
      {required dynamic payload,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    return JWZToken.withJWZ(
        jwz: JWZ(payload: payload), prover: prover, preparer: preparer);
  }

  factory JWZToken.fromBase64(
      {required String data,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    return JWZToken.withJWZ(
        jwz: JWZ.fromBase64(data), prover: prover, preparer: preparer);
  }

  Future<String> prove(Uint8List provingKey, Uint8List wasm) async {
    if (jwz.header == null) {
      throw NullJWZHeaderException();
    }

    Uint8List prepared = preparer.prepare(_getHash(), circuitID);
    jwz.proof = await prover.prove(prepared, provingKey, wasm);

    return encode();
  }

  Future<bool> verify(Uint8List verificationKey) {
    if (jwz.proof == null) {
      throw NullJWZProofException();
    }

    return prover.verify(_getHash(), jwz.proof!, verificationKey);
  }

  Uint8List _getHash() {
    // FIXME: need Poseidon hashing
    Uint8List toHash = jwz.prepareForHash();
    Uint8List hashed = toHash;

    return hashed;
  }

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
