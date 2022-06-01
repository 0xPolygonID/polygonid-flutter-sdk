import 'dart:typed_data';

import 'package:privadoid_sdk/model/jwz/jwz_proof.dart';

import 'jwz_token.dart';
import 'libs/iden3corelib.dart';

class JWZProverImpl extends JWZProver {
  static Iden3CoreLib get _iden3coreLib {
    return Iden3CoreLib();
  }

  JWZProverImpl({required String alg, required String circuitID})
      : super(alg: alg, circuitID: circuitID);

  @override
  Future<JWZProof> prove(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm) async {
    Map<String, dynamic>? proof = await _iden3coreLib.prove(provingKey, wasm);
    return JWZProof(proof: JWZBaseProof.fromJson(proof!), pubSignals: []);
  }

  @override
  Future<bool> verify(
      Uint8List hash, JWZProof proof, Uint8List verificationKey) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
