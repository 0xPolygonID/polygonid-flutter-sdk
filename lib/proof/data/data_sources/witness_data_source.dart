import 'package:circom_witnesscalc/circom_witnesscalc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WitnessParam {
  final String inputsJson;
  final Uint8List circuitGraphFile;
  final RootIsolateToken rootToken;

  WitnessParam(
    this.inputsJson,
    this.circuitGraphFile,
    this.rootToken,
  );
}

class WitnessDataSource {
  WitnessDataSource();

  Future<Uint8List?> computeWitness({
    required String inputsJson,
    required Uint8List circuitGraphFile,
  }) async {
    final result = await CircomWitnesscalc().calculateWitness(
      inputs: inputsJson,
      graphData: circuitGraphFile,
    );

    return result;
  }
}
