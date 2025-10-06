import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

/// Message sent to agent to track status of requests user sent for resource access.
/// The response should be a [ResourcePermissionsListMessage].
class ResourcePermissionsRequestsListMessage extends Iden3Message<EmptyBody> {
  ResourcePermissionsRequestsListMessage({
    String? id,
    super.typ,
    String? thid,
    super.body = const EmptyBody(),
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          id: id ?? Uuid().v4(),
          thid: thid ?? Uuid().v4(),
          type: Iden3MessageType.permissionsRequestsList);

  factory ResourcePermissionsRequestsListMessage.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsRequestsListMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: const EmptyBody(),
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
