import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class ResourcePermissionsUpdateRequestMessage
    extends Iden3Message<ResourcePermissionsUpdateRequestBody> {
  ResourcePermissionsUpdateRequestMessage({
    required super.id,
    super.typ,
    required super.type,
    super.thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    required super.attachments,
  });

  factory ResourcePermissionsUpdateRequestMessage.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsUpdateRequestMessage(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      body: ResourcePermissionsUpdateRequestBody.fromJson(json['body']),
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
      "[ResourcePermissionsUpdateRequestMessage] {${super.toString()}}";
}

class ResourcePermissionsUpdateRequestBody extends Equatable {
  final String id;
  final List<String> current;
  final List<String>? add;
  final List<String>? remove;

  ResourcePermissionsUpdateRequestBody({
    required this.id,
    required this.current,
    required this.add,
    required this.remove,
  });

  factory ResourcePermissionsUpdateRequestBody.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsUpdateRequestBody(
      id: json['id'],
      current:
          (json['current'] as List<dynamic>).map((e) => e as String).toList(),
      add: (json['add'] as List<dynamic>?)?.map((e) => e as String).toList(),
      remove:
          (json['remove'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'current': current,
      if (add != null) 'add': add,
      if (remove != null) 'remove': remove,
    };
  }

  @override
  List<Object?> get props => [id, current, add, remove];
}
