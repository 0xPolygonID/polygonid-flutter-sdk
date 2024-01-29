import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class CredentialRefreshIden3MessageEntity extends Iden3MessageEntity {
  @override
  final CredentialRefreshBodyRequest body;

  CredentialRefreshIden3MessageEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required this.body,
    required super.to,
  }) : super(messageType: Iden3MessageType.credentialRefresh);

  factory CredentialRefreshIden3MessageEntity.fromJson(
      Map<String, dynamic> json) {
    CredentialRefreshBodyRequest body =
        CredentialRefreshBodyRequest.fromJson(json['body']);

    return CredentialRefreshIden3MessageEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() =>
      "[CredentialRefreshIden3MessageEntity] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialRefreshIden3MessageEntity;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CredentialRefreshBodyRequest {
  final String id;
  final String reason;

  CredentialRefreshBodyRequest(this.id, this.reason);

  factory CredentialRefreshBodyRequest.fromJson(Map<String, dynamic> json) {
    return CredentialRefreshBodyRequest(
      json['id'],
      json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reason': reason,
    };
  }

  @override
  String toString() =>
      "[CredentialRefreshBodyRequest] {id: $id, reason: $reason}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialRefreshBodyRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          reason == other.reason;

  @override
  int get hashCode => runtimeType.hashCode;
}
