// ignore_for_file: overridden_fields
/*
{
  "type": "https://iden3-communication.io/authorization-request/v1",
  "data": {
    "callbackUrl": "https://auth-demo.idyllicvision.com/callback?id=27887",
    "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
    "scope": [
      {
        "circuit_id": "auth",
        "type": "zeroknowledge",
        "rules": {
          "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
          "challenge": 27887
        }
      }
    ]
  }
}


*/

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

import '../../authorization/request/auth_body_request.dart';

@Deprecated('use AuthorizationRequestMessage instead')
typedef AuthIden3MessageEntity = AuthorizationRequestMessage;

class AuthorizationRequestMessage
    extends Iden3Message<AuthorizationRequestMessageBody> {
  @override
  final String from;

  AuthorizationRequestMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.thid,
    required this.from,
    required super.body,
    super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          type: Iden3MessageType.authRequest,
          from: from,
        );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AuthorizationRequestMessage]
  factory AuthorizationRequestMessage.fromJson(Map<String, dynamic> json) {
    AuthorizationRequestMessageBody body =
        AuthorizationRequestMessageBody.fromJson(json['body']);

    return AuthorizationRequestMessage(
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['body'] = body.toJson();
    return data;
  }

  @override
  String toString() => "[AuthorizationRequestMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is AuthorizationRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}
