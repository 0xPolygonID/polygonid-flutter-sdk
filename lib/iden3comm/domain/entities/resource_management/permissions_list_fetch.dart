import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

/// Message sent to request the list of permission request sent for user`s resources.
/// The response should be a [ResourcePermissionsListMessage].
class ResourcePermissionsListFetchMessage
    extends Iden3Message<ResourcePermissionsListFetchBody> {
  ResourcePermissionsListFetchMessage({
    String? id,
    super.typ,
    String? thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          id: id ?? Uuid().v4(),
          thid: thid ?? Uuid().v4(),
          type: Iden3MessageType.permissionsListFetch,
        );

  factory ResourcePermissionsListFetchMessage.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsListFetchMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ResourcePermissionsListFetchBody.fromJson(json['body']),
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
      "[ResourcePermissionsListFetchMessage] {${super.toString()}}";
}

class ResourcePermissionsListFetchBody with EquatableMixin {
  final String id;

  ResourcePermissionsListFetchBody({required this.id});

  factory ResourcePermissionsListFetchBody.fromJson(Map<String, dynamic> json) {
    return ResourcePermissionsListFetchBody(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id];
}
