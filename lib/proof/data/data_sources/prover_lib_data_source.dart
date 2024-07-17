import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rapidsnark/flutter_rapidsnark.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/prove_param.dart';

@injectable
class ProverLibWrapper {
  Future<Map<String, dynamic>?> prover(
    Uint8List zkey,
    Uint8List wtnsBytes,
  ) {
    final rootToken = RootIsolateToken.instance!;

    return compute(
      _computeProve,
      ProveParam(zkey, wtnsBytes, rootToken),
    );
  }
}

///
Future<Map<String, dynamic>?> _computeProve(ProveParam param) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(param.token);
  final result = await Rapidsnark().groth16Prove(
    zkey: param.zkey,
    witness: param.wtns,
  );
  return {
    "proof": jsonDecode(result.proof),
    "pub_signals": jsonDecode(result.publicSignals),
  };
}

class ProverLibDataSource {
  final ProverLibWrapper _proverLibWrapper;

  ProverLibDataSource(this._proverLibWrapper);

  ///
  Future<Map<String, dynamic>?> prove(
    Uint8List zkey,
    Uint8List wtnsBytes,
  ) async {
    final result = await _proverLibWrapper.prover(zkey, wtnsBytes);

    return result;
  }
}
