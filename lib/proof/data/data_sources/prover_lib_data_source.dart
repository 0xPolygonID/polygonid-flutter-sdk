import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/prove_param.dart';
import 'package:polygonid_flutter_sdk/proof/libs/prover/prover.dart';

const _methodChannel = MethodChannel('polygonid_flutter_sdk');

@injectable
class ProverLibWrapper {
  Future<Map<String, dynamic>?> prover(
      String circuitId, String zKeyPath, Uint8List wtnsBytes) {
    return compute(_computeProve, ProveParam(circuitId, zKeyPath, wtnsBytes));
  }
}

///
Future<Map<String, dynamic>?> _computeProve(ProveParam param) async {
  ProverLib proverLib = ProverLib();
  // return proverLib.prove(param.circuitId, param.zKeyPath, param.wtns);
  return null;
}

class ProverLibDataSource {
  final ProverLibWrapper _proverLibWrapper;

  ProverLibDataSource(this._proverLibWrapper);

  ///
  Future<Map<String, dynamic>?> prove(
    String circuitId,
    String zKeyPath,
    Uint8List wtnsBytes,
  ) async {
    final result = await _methodChannel.invokeMapMethod(
      'prove',
      {
        'zKeyPath': zKeyPath,
        'wtnsBytes': wtnsBytes,
      },
    );
    result?['proof'] = jsonDecode(result['proof'] as String);
    result?['pub_signals'] = jsonDecode(result['pub_signals'] as String);

    return result?.cast<String, dynamic>();
  }
}
