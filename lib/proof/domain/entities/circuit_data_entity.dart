import 'dart:typed_data';

class CircuitDataEntity {
  final String circuitId;
  final Uint8List graphBinFile;
  final String zKeyPath;

  CircuitDataEntity(
    this.circuitId,
    this.graphBinFile,
    this.zKeyPath,
  );

  factory CircuitDataEntity.fromJson(Map<String, dynamic> json) {
    return CircuitDataEntity(
      json['circuitId'] as String,
      json['graphBinFile'] as Uint8List,
      json['zKeyPath'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'circuitId': circuitId,
      'graphBinFile': graphBinFile,
      'zKeyPath': zKeyPath,
    };
  }

  @override
  String toString() {
    return 'CircuitDataEntity{circuitId: $circuitId, graphBinFile: $graphBinFile, zKeyPath: $zKeyPath}';
  }
}
