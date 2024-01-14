import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class CredentialStatusUpdateMessageEntity extends Iden3MessageEntity {
  @override
  final CredentialStatusUpdateBody body;

  CredentialStatusUpdateMessageEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.to,
    required this.body,
  }) : super(messageType: Iden3MessageType.credentialStatusUpdate);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialStatusUpdateMessageEntity]
  factory CredentialStatusUpdateMessageEntity.fromJson(
      Map<String, dynamic> json) {
    CredentialStatusUpdateBody body =
        CredentialStatusUpdateBody.fromJson(json['body']);

    return CredentialStatusUpdateMessageEntity(
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['body'] = body.toJson();
    return data;
  }

  @override
  String toString() =>
      "[CredentialStatusUpdateMessageEntity] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialStatusUpdateMessageEntity;

  @override
  int get hashCode => super.hashCode;
}

class CredentialStatusUpdateBody {
  final String id;
  final String reason;

  CredentialStatusUpdateBody({
    required this.id,
    required this.reason,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialStatusUpdateBody]
  factory CredentialStatusUpdateBody.fromJson(Map<String, dynamic> json) {
    return CredentialStatusUpdateBody(
      id: json['id'],
      reason: json['reason'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'reason': reason,
      };

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
