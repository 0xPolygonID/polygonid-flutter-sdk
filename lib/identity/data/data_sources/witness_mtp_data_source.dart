import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/identity/data/dtos/witness_param.dart';
import 'package:polygonid_flutter_sdk/proof_generation/libs/witnesscalc/mtp/witness_mtp.dart';

class WitnessMtpDataSource{
  final WitnessMtpLib _witnessMtpLib;

  WitnessMtpDataSource(this._witnessMtpLib);

  ///
  Future<Uint8List?> calculateWitnessMtp(WitnessParam param){
    return _witnessMtpLib.calculateWitnessMtp(param.wasm, param.json);
  }
}