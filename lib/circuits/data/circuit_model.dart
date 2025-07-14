// example
// CircuitModel(fileName: 'linkedMultiQuery10-beta.1.dat', checksum: 'a5b1e217ace63fb0c2bd2d8673d70dea'),
class CircuitModel {
  final String fileName;
  final String? circuitId;

  /// MD5 checksum of the file, useful in case of large files.
  final String? checksum;

  CircuitModel({
    required this.fileName,
    this.circuitId,
    this.checksum,
  });

  factory CircuitModel.fromJson(Map<String, dynamic> json) {
    return CircuitModel(
      fileName: json['fileName'],
      circuitId: json['circuitId'],
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      if (circuitId != null) 'circuitId': circuitId,
      if (checksum != null) 'checksum': checksum,
    };
  }
}
