import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/// Message sent to request the list of permission request sent for user`s resources.
/// The response should be a [ResourcePermissionsListMessage].
class ResourcePermissionsListFetchMessage
    extends Iden3Message<Map<String, dynamic>> {
  ResourcePermissionsListFetchMessage({
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

  factory ResourcePermissionsListFetchMessage.fromJson(
      Map<String, dynamic> json) {
    return ResourcePermissionsListFetchMessage(
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
