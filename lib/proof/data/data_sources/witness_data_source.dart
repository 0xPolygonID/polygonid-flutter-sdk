import 'package:circom_witnesscalc/circom_witnesscalc.dart';
import 'package:flutter/services.dart';

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
