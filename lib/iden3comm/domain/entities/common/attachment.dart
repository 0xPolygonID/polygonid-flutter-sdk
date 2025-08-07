import 'package:equatable/equatable.dart';

/// Represents an attachment in a message, which can include json, base64 or other data.
class Attachment extends Equatable {
  final String id;
  final String? description;
  final String? mediaType;
  final AttachData data;

  Attachment({
    required this.id,
    required this.description,
    required this.mediaType,
    required this.data,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      description: json['description'],
      mediaType: json['media_type'],
      data: AttachData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'media_type': mediaType,
      'data': data.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, description, mediaType, data];
}

/// Represents the data contained in an attachment, which can be a JSON object or other data types.
class AttachData extends Equatable {
  final Map<String, dynamic> json;

  AttachData({required this.json});

  factory AttachData.fromJson(Map<String, dynamic> json) {
    return AttachData(json: json['json']);
  }

  Map<String, dynamic> toJson() {
    return {
      'json': json,
    };
  }

  @override
  List<Object?> get props => [json];
}
