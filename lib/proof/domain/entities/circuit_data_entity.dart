import 'dart:typed_data';

class CircuitDataEntity {
  final String circuitId;
  final Uint8List datFile;
  final String zKeyPath;

  CircuitDataEntity(
    this.circuitId,
    this.datFile,
    this.zKeyPath,
  );

  factory CircuitDataEntity.fromJson(Map<String, dynamic> json) {
    return CircuitDataEntity(
      json['circuitId'] as String,
      json['datFile'] as Uint8List,
      json['zKeyPath'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'circuitId': circuitId,
      'datFile': datFile,
      'zKeyPath': zKeyPath,
    };
  }

  @override
  String toString() {
    return 'CircuitDataEntity{circuitId: $circuitId, datFile: $datFile, zKeyPath: $zKeyPath}';
  }
}
