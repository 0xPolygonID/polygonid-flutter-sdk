import 'dart:typed_data';

class CircuitDataEntity {
  final String circuitId;
  final Uint8List datFile;
  final Uint8List zKeyFile;

  CircuitDataEntity(this.circuitId, this.datFile, this.zKeyFile);

  factory CircuitDataEntity.fromJson(Map<String, dynamic> json) {
    return CircuitDataEntity(
      json['circuitId'] as String,
      json['datFile'] as Uint8List,
      json['zKeyFile'] as Uint8List,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'circuitId': circuitId,
      'datFile': datFile,
      'zKeyFile': zKeyFile,
    };
  }

  @override
  String toString() {
    return 'CircuitDataEntity{circuitId: $circuitId, datFile: $datFile, zKeyFile: $zKeyFile}';
  }
}
