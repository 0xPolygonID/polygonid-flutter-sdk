import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

class ResourceRequestMessage extends Iden3Message<ResourceRequestBody> {
  ResourceRequestMessage({
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
         type: Iden3MessageType.resourceRequest,
         id: id ?? const Uuid().v4(),
         thid: thid ?? const Uuid().v4(),
       );

  factory ResourceRequestMessage.fromJson(Map<String, dynamic> json) {
    return ResourceRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ResourceRequestBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  String toString() => "[ResourceRequestMessage] {${super.toString()}}";
}

class ResourceRequestBody extends Equatable implements JsonEncodable {
  final String id;
  final String? reason;
  final String? owner;

  ResourceRequestBody({required this.id, this.reason, this.owner});

  factory ResourceRequestBody.fromJson(Map<String, dynamic> json) {
    return ResourceRequestBody(
      id: json['id'],
      reason: json['reason'],
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (reason != null) 'reason': reason,
      if (owner != null) 'owner': owner,
    };
  }

  @override
  List<Object?> get props => [id, reason, owner];
}
