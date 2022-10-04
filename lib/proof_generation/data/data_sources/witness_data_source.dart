import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/auth/witness_auth.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/mtp/witness_mtp.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/sig/witness_sig.dart';

@injectable
class WitnessIsolatesWrapper {
  Future<Uint8List?> computeWitnessAuth(WitnessParam param) =>
      compute(_computeWitnessAuth, param);

  Future<Uint8List?> computeWitnessSig(WitnessParam param) =>
      compute(_computeWitnessSig, param);

  Future<Uint8List?> computeWitnessMtp(WitnessParam param) =>
      compute(_computeWitnessMtp, param);
}

/// As this is running in a separate thread, we cannot inject [WitnessAuthLib]
Future<Uint8List?> _computeWitnessAuth(WitnessParam param) async {
  final WitnessAuthLib witnessAuthLib = WitnessAuthLib();
  final Uint8List? witnessBytes =
      await witnessAuthLib.calculateWitnessAuth(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessSigLib]
Future<Uint8List?> _computeWitnessSig(WitnessParam param) async {
  final WitnessSigLib witnessSigLib = WitnessSigLib();
  final Uint8List? witnessBytes =
      await witnessSigLib.calculateWitnessSig(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessMtpLib]
Future<Uint8List?> _computeWitnessMtp(WitnessParam param) async {
  final WitnessMtpLib witnessMtpLib = WitnessMtpLib();
  final Uint8List? witnessBytes =
      await witnessMtpLib.calculateWitnessMtp(param.wasm, param.json);
  return witnessBytes;
}

class WitnessDataSource {
  final WitnessIsolatesWrapper _witnessIsolatesWrapper;

  WitnessDataSource(this._witnessIsolatesWrapper);

  ///
  Future<Uint8List?> computeWitnessAuth(WitnessParam param) async {
    return _witnessIsolatesWrapper.computeWitnessAuth(param);
  }

  ///
  Future<Uint8List?> computeWitnessMtp(WitnessParam param) async {
    return _witnessIsolatesWrapper.computeWitnessMtp(param);
  }

  ///
  Future<Uint8List?> computeWitnessSig(WitnessParam param) async {
    return _witnessIsolatesWrapper.computeWitnessSig(param);
  }
}