import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/witness_universal.dart';

@injectable
class WitnessIsolatesWrapper {
  Future<Uint8List?> computeWitnessUniversal(WitnessParam param) =>
      compute(_computeWitnessUniversal, param);
}

Future<Uint8List?> _computeWitnessUniversal(WitnessParam param) async {
  final WitnessUniversalLib witnessLib = WitnessUniversalLib();
  final Uint8List? witnessBytes = await witnessLib.calculateWitness(
    param.graph,
    param.inputs,
  );
  return witnessBytes;
}

class WitnessDataSource {
  final WitnessIsolatesWrapper _witnessIsolatesWrapper;

  WitnessDataSource(this._witnessIsolatesWrapper);

  Future<Uint8List?> computeWitness({
    required CircuitType type,
    required WitnessParam param,
  }) {
    return _witnessIsolatesWrapper.computeWitnessUniversal(param);
  }
}
