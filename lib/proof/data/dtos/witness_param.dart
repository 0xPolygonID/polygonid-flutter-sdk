import 'dart:typed_data';

class WitnessParam {
  final Uint8List inputs;
  final Uint8List graph;

  WitnessParam({
    required this.inputs,
    required this.graph,
  });
}
