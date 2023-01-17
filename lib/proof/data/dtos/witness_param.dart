import 'dart:typed_data';

class WitnessParam {
  final Uint8List wasm;
  final Uint8List json;

  WitnessParam({
    required this.wasm,
    required this.json,
  });
}
