import 'package:circom_witnesscalc/circom_witnesscalc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class WitnessParam {
  final String inputsJson;
  final Uint8List circuitGraphFile;

  WitnessParam({
    required this.inputsJson,
    required this.circuitGraphFile,
  });
}

class WitnessDataSource {
  final WitnessIsolatesWrapper _witnessIsolatesWrapper;

  WitnessDataSource(this._witnessIsolatesWrapper);

  Future<Uint8List?> computeWitness({
    required CircuitType type,
    required WitnessParam param,
  }) {
    return _witnessIsolatesWrapper.computeWitness(param);
  }
}

@injectable
class WitnessIsolatesWrapper {
  Future<Uint8List?> computeWitness(WitnessParam param) {
    return compute(_computeWitness, param);
  }
}

/// As this is running in a separate thread, we cannot inject [WitnessAuthLib]
Future<Uint8List?> _computeWitness(WitnessParam param) async {
  final result = await CircomWitnesscalc().calculateWitness(
    inputs: param.inputsJson,
    graphData: param.circuitGraphFile,
  );

  return result;
}
