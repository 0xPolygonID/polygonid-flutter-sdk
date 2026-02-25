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

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

import '../../authorization/request/auth_body_request.dart';

@Deprecated('use AuthorizationRequestMessage instead')
typedef AuthIden3MessageEntity = AuthorizationRequestMessage;

class AuthorizationRequestMessage
    extends Iden3Message<AuthorizationRequestMessageBody> {
  @override
  final String from;

  AuthorizationRequestMessage({
    String? id,
    super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    String? thid,
    required this.from,
    required super.body,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         id: id ?? const Uuid().v4(),
         type: Iden3MessageType.authRequest,
         thid: thid ?? const Uuid().v4(),
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
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      body: body,
      attachments: json['attachments'] != null
          ? List<Map<String, dynamic>>.from(
              json['attachments'],
            ).map((j) => Attachment.fromJson(j)).toList()
          : const [],
    );
  }

  @override
  String toString() => "[AuthorizationRequestMessage] {${super.toString()}}";
}
