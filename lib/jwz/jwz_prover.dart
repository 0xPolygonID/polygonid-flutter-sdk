import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/model/jwz/jwz_proof.dart';

import '../libs/iden3corelib.dart';
import 'jwz_token.dart';

class CalculateProofIsolateParam {
  final Uint8List inputs;
  final Uint8List provingKey;
  final Uint8List wasm;

  CalculateProofIsolateParam(this.inputs, this.provingKey, this.wasm);
}

class JWZProverImpl extends JWZProver {
  JWZProverImpl(
      {required String alg, required String circuitID})
      : super(alg: alg, circuitID: circuitID);

  @override
  Future<JWZProof> prove(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm) async {
    Map<String, dynamic>? proof = await compute(_computeCalculateProof,
        CalculateProofIsolateParam(inputs, provingKey, wasm));
    return JWZProof(
        proof: JWZBaseProof.fromJson(proof!["proof"]),
        pubSignals: (proof["pub_signals"] as List<String>));
  }

  @override
  Future<bool> verify(
      Uint8List hash, JWZProof proof, Uint8List verificationKey) {
    // TODO: implement verify
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>?> _computeCalculateProof(
      CalculateProofIsolateParam param) {
    final iden3coreLib = Iden3CoreLib();

    return Future.value(iden3coreLib.calculateProof(
        param.inputs, param.provingKey, param.wasm));
  }
}
