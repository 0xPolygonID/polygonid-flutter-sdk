import 'dart:typed_data';

class CircuitDataEntity {
  final String circuitId;
  final Uint8List graphFile;
  final String zKeyPath;

  CircuitDataEntity(
    this.circuitId,
    this.graphFile,
    this.zKeyPath,
  );

  factory CircuitDataEntity.fromJson(Map<String, dynamic> json) {
    return CircuitDataEntity(
      json['circuitId'] as String,
      json['graphFile'] as Uint8List,
      json['zKeyPath'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'circuitId': circuitId,
      'graphFile': graphFile,
      'zKeyPath': zKeyPath,
    };
  }

  @override
  String toString() {
    return 'CircuitDataEntity{circuitId: $circuitId, graphFile: $graphFile, zKeyPath: $zKeyPath}';
  }
}
