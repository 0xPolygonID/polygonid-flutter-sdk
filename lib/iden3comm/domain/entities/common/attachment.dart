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
      data: AttachData.fromJson(json['data'] ?? {}),
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

/// Represents the data contained in an attachment, which can be a JSON object
/// or a base64 encoded string.
class AttachData extends Equatable {
  /// JSON payload if present
  final Map<String, dynamic>? json;

  /// Base64 payload if present
  final String? base64;

  /// Backward compatible constructor expecting json (old behavior)
  @Deprecated('Use named .json constructor')
  AttachData({required Map<String, dynamic> this.json}) : base64 = null;

  /// Named constructor for json data
  AttachData.json(this.json) : base64 = null;

  /// Named constructor for base64 data
  AttachData.base64(this.base64) : json = null;

  /// General factory to create from either json or base64 keys.
  factory AttachData.fromJson(Map<String, dynamic> json) {
    // Accept shapes: { 'json': { ... } } OR { 'base64': '...' }
    if (json.containsKey('json') && json['json'] is Map<String, dynamic>) {
      return AttachData.json(Map<String, dynamic>.from(json['json']));
    }
    if (json.containsKey('base64') && json['base64'] is String) {
      return AttachData.base64(json['base64']);
    }
    // Fallback: if structure unexpected, treat as empty json map
    return AttachData.json(<String, dynamic>{});
  }

  bool get hasJson => json != null;

  bool get hasBase64 => base64 != null;

  Map<String, dynamic> toJson() {
    if (json != null) {
      return {'json': json};
    }
    if (base64 != null) {
      return {'base64': base64};
    }
    // If neither is set, return empty json map to remain consistent.
    return {'json': {}};
  }

  @override
  List<Object?> get props => [json, base64];
}
