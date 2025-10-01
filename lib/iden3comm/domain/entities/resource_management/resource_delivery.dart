import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class ResourceDeliveryMessage extends Iden3Message<ResourceDeliveryBody> {
  ResourceDeliveryMessage({
    required super.id,
    super.typ,
    super.thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }): super(type: Iden3MessageType.resourceDelivery);

  factory ResourceDeliveryMessage.fromJson(Map<String, dynamic> json) {
    return ResourceDeliveryMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ResourceDeliveryBody.fromJson(json['body']),
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
  String toString() => "[ResourceDeliveryMessage] {${super.toString()}}";
}

class ResourceDeliveryBody extends Equatable {
  final String id;
  final String status;

  ResourceDeliveryBody({
    required this.id,
    required this.status,
  });

  factory ResourceDeliveryBody.fromJson(Map<String, dynamic> json) {
    return ResourceDeliveryBody(
      id: json['id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, status];
}
