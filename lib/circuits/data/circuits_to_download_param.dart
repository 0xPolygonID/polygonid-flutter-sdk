import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';

class CircuitsToDownloadParam extends Equatable {
  final String zipFileName;
  final String bucketUrl;
  String? temporaryZipDownloadPath;
  final List<CircuitModel> circuitsWithChecksum;

  CircuitsToDownloadParam({
    required this.zipFileName,
    required this.bucketUrl,
    required this.circuitsWithChecksum,
    this.temporaryZipDownloadPath,
  });

  @override
  List<Object> get props => [zipFileName, bucketUrl, circuitsWithChecksum];

  @override
  bool get stringify => true;

  CircuitsToDownloadParam copyWith({
    String? zipFileName,
    String? bucketUrl,
    String? temporaryZipDownloadPath,
    List<CircuitModel>? circuitsWithChecksum,
  }) {
    return CircuitsToDownloadParam(
      zipFileName: zipFileName ?? this.zipFileName,
      bucketUrl: bucketUrl ?? this.bucketUrl,
      temporaryZipDownloadPath:
          temporaryZipDownloadPath ?? this.temporaryZipDownloadPath,
      circuitsWithChecksum: circuitsWithChecksum ?? this.circuitsWithChecksum,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zipFileName': zipFileName,
      'bucketUrl': bucketUrl,
      'temporaryZipDownloadPath': temporaryZipDownloadPath,
      'circuitsWithChecksum': circuitsWithChecksum,
    };
  }

  factory CircuitsToDownloadParam.fromJson(Map<String, dynamic> map) {
    return CircuitsToDownloadParam(
      zipFileName: map['zipFileName'],
      bucketUrl: map['bucketUrl'],
      temporaryZipDownloadPath: map['temporaryZipDownloadPath'],
      circuitsWithChecksum:
          List<CircuitModel>.from(map['circuitsWithChecksum']),
    );
  }
}
