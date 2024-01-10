import 'package:equatable/equatable.dart';

class CircuitsToDownloadParam extends Equatable {
  final String circuitsName;
  final String bucketUrl;
  String? downloadPath;

  CircuitsToDownloadParam({
    required this.circuitsName,
    required this.bucketUrl,
    this.downloadPath,
  });

  @override
  List<Object> get props => [circuitsName, bucketUrl];

  @override
  bool get stringify => true;

  CircuitsToDownloadParam copyWith({
    String? circuitsName,
    String? bucketUrl,
    String? downloadPath,
  }) {
    return CircuitsToDownloadParam(
      circuitsName: circuitsName ?? this.circuitsName,
      bucketUrl: bucketUrl ?? this.bucketUrl,
      downloadPath: downloadPath ?? this.downloadPath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'circuitsName': circuitsName,
      'bucketUrl': bucketUrl,
      'downloadPath': downloadPath,
    };
  }

  factory CircuitsToDownloadParam.fromJson(Map<String, dynamic> map) {
    return CircuitsToDownloadParam(
      circuitsName: map['circuitsName'],
      bucketUrl: map['bucketUrl'],
      downloadPath: map['downloadPath'],
    );
  }
}
