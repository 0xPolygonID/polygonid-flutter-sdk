import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

@Deprecated('Use CredentialRefreshMessage instead')
typedef CredentialRefreshIden3MessageEntity = CredentialRefreshMessage;

class CredentialRefreshMessage
    extends Iden3Message<CredentialRefreshBodyRequest> {
  CredentialRefreshMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    super.thid,
    required super.from,
    required super.body,
    required super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.credentialRefresh);

  factory CredentialRefreshMessage.fromJson(Map<String, dynamic> json) {
    CredentialRefreshBodyRequest body = CredentialRefreshBodyRequest.fromJson(
      json['body'],
    );

    return CredentialRefreshMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() => "[CredentialRefreshMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialRefreshMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CredentialRefreshBodyRequest implements JsonEncodable {
  final String id;
  final String reason;

  CredentialRefreshBodyRequest(this.id, this.reason);

  factory CredentialRefreshBodyRequest.fromJson(Map<String, dynamic> json) {
    return CredentialRefreshBodyRequest(json['id'], json['reason']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'reason': reason};
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
