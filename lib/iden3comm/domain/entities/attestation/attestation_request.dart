/*
{
  "type": "EncryptionKey"
}
*/

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

@Deprecated('Use AttestationRequestMessage instead')
typedef AttestationRequestEntity = AttestationRequestMessage;

class AttestationRequestMessage extends Iden3Message<AttestationRequestBody> {
  AttestationRequestMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.thid,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.attestationRequest);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AttestationRequestMessage]
  factory AttestationRequestMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    final body = AttestationRequestBody.fromJson(json['body']);
    return AttestationRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
      nextRequest: json['next_request'],
    );
  }

  @override
  String toString() => "[AttestationRequestMessage] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is AttestationRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AttestationRequestBody {
  final String type;

  AttestationRequestBody({
    required this.type,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory AttestationRequestBody.fromJson(Map<String, dynamic> json) {
    return AttestationRequestBody(
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
      };

  @override
  String toString() => "[AttestationRequestBody] {type: $type}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttestationRequestBody &&
          runtimeType == other.runtimeType &&
          type == other.type;

  @override
  int get hashCode => runtimeType.hashCode;
}
