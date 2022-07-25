import 'dart:typed_data';

class CircuitData {
  final String circuitId;
  final Uint8List datFile;
  final Uint8List zKeyFile;

  CircuitData(this.circuitId, this.datFile, this.zKeyFile);
}
