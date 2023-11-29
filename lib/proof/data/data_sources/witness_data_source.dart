import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/mtp_v2/witness_mtp.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/sig_v2/witness_sig.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/v3/witness_v3.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/v3_onchain/witness_v3_onchain.dart';

import '../../libs/witnesscalc/auth_v2/witness_auth.dart';
import '../../libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart';
import '../../libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart';
import '../mappers/circuit_type_mapper.dart';

@injectable
class WitnessIsolatesWrapper {
  Future<Uint8List?> computeWitnessAuth(WitnessParam param) =>
      compute(_computeWitnessAuth, param);

  Future<Uint8List?> computeWitnessSig(WitnessParam param) =>
      compute(_computeWitnessSig, param);

  Future<Uint8List?> computeWitnessMtp(WitnessParam param) =>
      compute(_computeWitnessMtp, param);

  Future<Uint8List?> computeWitnessMtpOnchain(WitnessParam param) =>
      compute(_computeWitnessMtpOnchain, param);

  Future<Uint8List?> computeWitnessSigOnchain(WitnessParam param) =>
      compute(_computeWitnessSigOnchain, param);

  Future<Uint8List?> computeWitnessV3(WitnessParam param) =>
      compute(_computeWitnessV3, param);
}

/// As this is running in a separate thread, we cannot inject [WitnessAuthLib]
Future<Uint8List?> _computeWitnessAuth(WitnessParam param) async {
  final WitnessAuthV2Lib witnessAuthLib = WitnessAuthV2Lib();
  final Uint8List? witnessBytes =
      await witnessAuthLib.calculateWitnessAuth(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessSigLib]
Future<Uint8List?> _computeWitnessSig(WitnessParam param) async {
  final WitnessSigV2Lib witnessSigLib = WitnessSigV2Lib();
  final Uint8List? witnessBytes =
      await witnessSigLib.calculateWitnessSig(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessMtpLib]
Future<Uint8List?> _computeWitnessMtp(WitnessParam param) async {
  final WitnessMTPV2Lib witnessMtpLib = WitnessMTPV2Lib();
  final Uint8List? witnessBytes =
      await witnessMtpLib.calculateWitnessMTP(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessMTPV2OnchainLib]
Future<Uint8List?> _computeWitnessMtpOnchain(WitnessParam param) async {
  final WitnessMTPV2OnchainLib witnessMTPV2OnchainLib =
      WitnessMTPV2OnchainLib();
  final Uint8List? witnessBytes = await witnessMTPV2OnchainLib
      .calculateWitnessMTPOnchain(param.wasm, param.json);
  return witnessBytes;
}

/// As this is running in a separate thread, we cannot inject [WitnessSigV2OnchainLib]
Future<Uint8List?> _computeWitnessSigOnchain(WitnessParam param) async {
  final WitnessSigV2OnchainLib witnessSigV2OnchainLib =
      WitnessSigV2OnchainLib();
  final Uint8List? witnessBytes = await witnessSigV2OnchainLib
      .calculateWitnessSigOnchain(param.wasm, param.json);
  return witnessBytes;
}

Future<Uint8List?> _computeWitnessV3(WitnessParam param) async {
  final WitnessV3Lib witnessLib = WitnessV3Lib();
  final Uint8List? witnessBytes = await witnessLib.calculateWitness(
    param.wasm,
    param.json,
  );
  return witnessBytes;
}

class WitnessDataSource {
  final WitnessIsolatesWrapper _witnessIsolatesWrapper;

  WitnessDataSource(this._witnessIsolatesWrapper);

  Future<Uint8List?> computeWitness(
      {required CircuitType type, required WitnessParam param}) {
    switch (type) {
      case CircuitType.auth:
        return _witnessIsolatesWrapper.computeWitnessAuth(param);
      case CircuitType.mtp:
        return _witnessIsolatesWrapper.computeWitnessMtp(param);
      case CircuitType.sig:
        return _witnessIsolatesWrapper.computeWitnessSig(param);
      case CircuitType.mtponchain:
        return _witnessIsolatesWrapper.computeWitnessMtpOnchain(param);
      case CircuitType.sigonchain:
        return _witnessIsolatesWrapper.computeWitnessSigOnchain(param);
      case CircuitType.circuitsV3:
        return _witnessIsolatesWrapper.computeWitnessV3(param);
      default:
        return Future.value(null);
    }
  }
}
