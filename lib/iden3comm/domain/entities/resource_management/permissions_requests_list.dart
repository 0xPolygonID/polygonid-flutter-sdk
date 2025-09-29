import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/// Message sent to agent to track status of requests user sent for resource access.
/// The response should be a [ResourcePermissionsListMessage].
class ResourcePermissionsRequestsListMessage
    extends Iden3Message<Map<String, dynamic>> {
  ResourcePermissionsRequestsListMessage({
    required super.id,
    super.typ,
    super.thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    required super.attachments,
  }) : super(type: Iden3MessageType.permissionsListFetch);

  factory ResourcePermissionsRequestsListMessage.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsRequestsListMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: {},
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
