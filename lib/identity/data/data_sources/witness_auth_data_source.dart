import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/auth/witness_auth.dart';

class WitnessAuthDataSource {
  final WitnessAuthLib _witnessAuthLib;

  WitnessAuthDataSource(this._witnessAuthLib);

  ///
  Future<Uint8List?> calculateWitnessAuth(WitnessParam param) {
    return _witnessAuthLib.calculateWitnessAuth(param.wasm, param.json);
  }
}
