import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_rapidsnark/flutter_rapidsnark.dart';

class ProverLibDataSource {
  ProverLibDataSource();

  ///
  Future<Map<String, dynamic>?> prove(
    String zKeyPath,
    Uint8List wtnsBytes,
  ) async {
    final result = await Rapidsnark().groth16Prove(
      zkeyPath: zKeyPath,
      witness: wtnsBytes,
    );

    return {
      'proof': jsonDecode(result.proof),
      'pub_signals': jsonDecode(result.publicSignals),
    };
  }
}
