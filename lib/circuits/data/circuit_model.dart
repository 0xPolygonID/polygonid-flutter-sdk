// example
// CircuitModel(fileName: 'linkedMultiQuery10-beta.1.dat', checksum: 'a5b1e217ace63fb0c2bd2d8673d70dea'),
class CircuitModel {
  final String fileName;
  final String checksum;

  CircuitModel({required this.fileName, required this.checksum});

  factory CircuitModel.fromJson(Map<String, dynamic> json) {
    return CircuitModel(
      fileName: json['fileName'],
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['fileName'] = fileName;
    json['checksum'] = checksum;
    return json;
  }
}
