import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:privadoid_sdk/libs/circomlib.dart';
import 'package:privadoid_sdk/model/jwz/jwz.dart';
import 'package:privadoid_sdk/model/jwz/jwz_exceptions.dart';
import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';
import 'package:privadoid_sdk/utils/base_64.dart';
import 'package:privadoid_sdk/utils/big_int_extension.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

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
  Uint8List prepare(Uint8List hash, String circuitID);
}

/// Representation of a JWZ Token with [JWZProver] and [JWZInputPreparer]
/// Wrapper around [JWZ]
class JWZToken implements Base64Encoder {
  String get alg => prover.alg;

  String get circuitID => prover.circuitID;
  late JWZ jwz;
  JWZProver prover;
  JWZInputPreparer preparer;

  JWZToken({required this.prover, required this.preparer});

  /// Construct a [JWZToken] with [JWZ]
  factory JWZToken.withJWZ(
      {required JWZ jwz,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    JWZToken token = JWZToken(prover: prover, preparer: preparer);
    token.jwz = jwz;

    return token;
  }

  /// Construct a [JWZToken] with payload
  factory JWZToken.withPayload(
      {required dynamic payload,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    return JWZToken.withJWZ(
        jwz: JWZ(payload: JWZPayload(payload: payload)),
        prover: prover,
        preparer: preparer);
  }

  /// Construct a [JWZToken] from a Base64 string
  factory JWZToken.fromBase64(
      {required String data,
      required JWZProver prover,
      required JWZInputPreparer preparer}) {
    return JWZToken.withJWZ(
        jwz: JWZ.fromBase64(data), prover: prover, preparer: preparer);
  }

  /// Prove and set [JWZToken.proof]
  /// @return compacted [JWZ]
  Future<String> prove(Uint8List provingKey, Uint8List wasm) async {
    Uint8List prepared = preparer.prepare(_getHash(), circuitID);
    jwz.proof = await prover.prove(prepared, provingKey, wasm);

    return encode();
  }

  /// Verify [JWZ]
  /// @return true if valid
  Future<bool> verify(Uint8List verificationKey) {
    if (jwz.proof == null) {
      throw NullJWZProofException();
    }

    return prover.verify(_getHash(), jwz.proof!, verificationKey);
  }

  Uint8List _getHash() {
    if (jwz.header == null) {
      throw NullJWZHeaderException();
    }

    if (jwz.payload == null) {
      throw NullJWZPayloadException();
    }

    // Sha256
    Uint8List sha = Uint8List.fromList(sha256
        .convert(Uint8ArrayUtils.uint8ListfromString(
            "${jwz.header!.encode()}.${jwz.payload!.encode()}"))
        .bytes);

    // Endianness
    //BigInt endian =
    //    BigInt.from(ByteData.sublistView(sha).getInt16(0, Endian.big));
    BigInt endian = Uint8ArrayUtils.beBuff2int(sha);
    //BigInt endian = Uint8ArrayUtils.leBuff2int(sha);

    // Check Q
    BigInt q = endian.qNormalize();

    // Poseidon hash
    CircomLib lib = CircomLib();
    String hashed = lib.poseidonHash(q.toString());

    return Uint8ArrayUtils.uint8ListfromString(hashed);
  }

  /// @return compact [JWT]
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
