import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/sig/witness_sig.dart';

class WitnessSigDataSource {
  final WitnessSigLib _witnessSigLib;

  WitnessSigDataSource(this._witnessSigLib);

  ///
  Future<Uint8List?> calculateWitnessSig(WitnessParam param) {
    return _witnessSigLib.calculateWitnessSig(param.wasm, param.json);
  }
}
