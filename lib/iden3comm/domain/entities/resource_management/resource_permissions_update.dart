import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class ResourcePermissionsUpdateMessage
    extends Iden3Message<ResourcePermissionsUpdateBody> {
  ResourcePermissionsUpdateMessage({
    required super.id,
    super.typ,
    super.thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.resourcePermissionsUpdate);

  factory ResourcePermissionsUpdateMessage.fromJson(Map<String, dynamic> json) {
    return ResourcePermissionsUpdateMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ResourcePermissionsUpdateBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  String toString() =>
      "[ResourcePermissionsUpdateMessage] {${super.toString()}}";
}

class ResourcePermissionsUpdateBody extends Equatable {
  final String id;
  final List<String> grant;
  final List<String> reject;

  ResourcePermissionsUpdateBody({
    required this.id,
    required this.grant,
    required this.reject,
  });

  factory ResourcePermissionsUpdateBody.fromJson(Map<String, dynamic> json) {
    return ResourcePermissionsUpdateBody(
      id: json['id'],
      grant: (json['grant'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      reject: (json['reject'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grant': grant,
      'reject': reject,
    };
  }

  @override
  List<Object?> get props => [id, grant, reject];
}
