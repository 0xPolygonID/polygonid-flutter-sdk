import 'dart:typed_data';

class CircuitDataEntity {
  final String circuitId;
  final Uint8List datFile;
  final Uint8List zKeyFile;

  CircuitDataEntity(this.circuitId, this.datFile, this.zKeyFile);
}
