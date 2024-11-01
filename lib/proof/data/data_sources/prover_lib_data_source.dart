import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/prove_param.dart';
import 'package:flutter_rapidsnark/flutter_rapidsnark.dart';

@injectable
class ProverLibWrapper {
  Future<Map<String, dynamic>?> prove(String zKeyPath, Uint8List wtnsBytes) {
    final rootToken = RootIsolateToken.instance!;

    return compute(
      _computeProof,
      ProveParam(zKeyPath, wtnsBytes, rootToken),
    );
  }
}

///
Future<Map<String, dynamic>?> _computeProof(ProveParam param) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(param.rootToken);

  final result = await Rapidsnark().groth16ProveWithZKeyFilePath(
    zkeyPath: param.zKeyPath,
    witness: param.wtns,
  );

  return {
    'proof': jsonDecode(result.proof),
    'pub_signals': jsonDecode(result.publicSignals),
  };
}

class ProverLibDataSource {
  final ProverLibWrapper _proverLibWrapper;

  ProverLibDataSource(this._proverLibWrapper);

  ///
  Future<Map<String, dynamic>?> prove(
    String zKeyPath,
    Uint8List wtnsBytes,
  ) async {
    final result = await _proverLibWrapper.prove(zKeyPath, wtnsBytes);
    return result;
  }
}
