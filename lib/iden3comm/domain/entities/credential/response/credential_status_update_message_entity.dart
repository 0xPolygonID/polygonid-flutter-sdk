import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

@Deprecated('Use CredentialStatusUpdateMessage instead')
typedef CredentialStatusUpdateMessageEntity = CredentialStatusUpdateMessage;

class CredentialStatusUpdateMessage
    extends Iden3Message<CredentialStatusUpdateBody> {
  CredentialStatusUpdateMessage({
    String? id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    String? thid,
    required super.from,
    required super.to,
    required super.body,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         id: id ?? const Uuid().v4(),
         type: Iden3MessageType.credentialStatusUpdate,
         thid: thid ?? const Uuid().v4(),
       );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialStatusUpdateMessage]
  factory CredentialStatusUpdateMessage.fromJson(Map<String, dynamic> json) {
    CredentialStatusUpdateBody body = CredentialStatusUpdateBody.fromJson(
      json['body'],
    );

    return CredentialStatusUpdateMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['body'] = body.toJson();
    return data;
  }

  @override
  String toString() => "[CredentialStatusUpdateMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialStatusUpdateMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CredentialStatusUpdateBody implements JsonEncodable {
  final String id;
  final String reason;

  CredentialStatusUpdateBody({required this.id, required this.reason});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialStatusUpdateBody]
  factory CredentialStatusUpdateBody.fromJson(Map<String, dynamic> json) {
    return CredentialStatusUpdateBody(id: json['id'], reason: json['reason']);
  }

  @override
  Map<String, dynamic> toJson() => {'id': id, 'reason': reason};

  @override
  String toString() =>
      "[CredentialStatusUpdateBody] {id: $id, reason: $reason}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialStatusUpdateBody &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          reason == other.reason;

  @override
  int get hashCode => runtimeType.hashCode;
}
