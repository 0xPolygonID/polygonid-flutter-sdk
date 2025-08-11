/*
{
  "type": "EncryptionKey",
  "payload": "TBD"
}
*/

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

@Deprecated('Use AttestationResponseMessage instead')
typedef AttestationResponseEntity = AttestationResponseMessage;

class AttestationResponseMessage extends Iden3Message<AttestationResponseBody> {
  AttestationResponseMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.thid,
    required super.body,
    super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          type: Iden3MessageType.attestationResponse,
          from: "",
        );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AttestationResponseMessage]
  factory AttestationResponseMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    final body = AttestationResponseBody.fromJson(json['body']);
    return AttestationResponseMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      to: json['to'],
      body: body,
      nextRequest: json['next_request'],
    );
  }

  @override
  String toString() => "[AttestationResponseMessage] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is AttestationResponseMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AttestationResponseBody {
  final String type;
  final dynamic payload;

  AttestationResponseBody({
    required this.type,
    required this.payload,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory AttestationResponseBody.fromJson(Map<String, dynamic> json) {
    return AttestationResponseBody(
      type: json['type'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'payload': payload,
      };

  @override
  String toString() =>
      "[AttestationResponseBody] {type: $type, payload: $payload}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttestationResponseBody &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          payload == other.payload;

  @override
  int get hashCode => runtimeType.hashCode;
}
