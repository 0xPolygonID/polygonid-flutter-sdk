import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/prove_param.dart';
import 'package:polygonid_flutter_sdk/proof/libs/prover/prover.dart';

@injectable
class ProverLibWrapper {
  Future<Map<String, dynamic>?> prover(
      String circuitId, Uint8List zKeyBytes, Uint8List wtnsBytes) {
    return compute(_computeProve, ProveParam(circuitId, zKeyBytes, wtnsBytes));
  }
}

///
Future<Map<String, dynamic>?> _computeProve(ProveParam param) {
  ProverLib proverLib = ProverLib();
  return proverLib.prove(param.circuitId, param.zKey, param.wtns);
}

class ProverLibDataSource {
  final ProverLibWrapper _proverLibWrapper;

  ProverLibDataSource(this._proverLibWrapper);

  ///
  Future<Map<String, dynamic>?> prove(
      String circuitId, Uint8List zKeyBytes, Uint8List wtnsBytes) async {
    return _proverLibWrapper.prover(circuitId, zKeyBytes, wtnsBytes);
  }
}
