/*
{
  "type": "https://iden3-communication.io/authorization-response/v1",
  "data": {
    "scope": [
      {
        "type": "zeroknowledge",
        "circuit_id": "auth",
        "pub_signals": [
          "383481829333688262229762912714748186426235428103586432827469388069546950656",
          "12345"
        ],
        "proof_data": {
          "pi_a": [
            "14146277947056297753840642586002829867111675410988595047766001252156753371528",
            "14571022849315211248046007113544986624773029852663683182064313232057584750907",
            "1"
          ],
          "pi_b": [
            [
              "16643510334478363316178974136322830670001098048711963846055396047727066595515",
              "10398230582752448515583571758866992012509398625081722188208617704185602394573"
            ],
            [
              "6754852150473185509183929580585027939167256175425095292505368999953776521762",
              "4988338043999536569468301597030911639875135237017470300699903062776921637682"
            ],
            [
              "1",
              "0"
            ]
          ],
          "pi_c": [
            "17016608018243685488662035612576776697709541343999980909476169114486580874935",
            "1344455328868272682523157740509602348889110849570014394831093852006878298645",
            "1"
          ],
          "protocol": "groth16"
        }
      }
    ]
  }
}


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

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';

typedef AuthBodyRequest = AuthorizationRequestMessageBody;

class AuthorizationRequestMessageBody implements JsonEncodable {
  final String callbackUrl;
  final String? reason;
  final String? message;
  final DIDDocument? didDoc;
  final List<ZeroKnowledgeProofRequest> scope;
  final List<String>? accept;

  AuthorizationRequestMessageBody({
    required this.callbackUrl,
    required this.reason,
    this.message,
    this.didDoc,
    required this.scope,
    this.accept,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AuthorizationRequestMessageBody]
  factory AuthorizationRequestMessageBody.fromJson(Map<String, dynamic> json) {
    final scope =
        (json['scope'] as List?)
            ?.map((item) => ZeroKnowledgeProofRequest.fromJson(item))
            .toList() ??
        [];

    final didDoc = json['did_doc'] != null
        ? DIDDocument.fromJson(json['did_doc'])
        : null;

    final accept = (json['accept'] as List?)
        ?.map((item) => item.toString())
        .toList();

    return AuthorizationRequestMessageBody(
      callbackUrl: json['callbackUrl'],
      reason: json['reason'],
      message: json['message'],
      scope: scope,
      didDoc: didDoc,
      accept: accept,
    );
  }

  Map<String, dynamic> toJson() => {
    'callbackUrl': callbackUrl,
    'reason': reason,
    if (message != null) 'message': message,
    'scope': scope.map((item) => item.toJson()).toList(),
    if (didDoc != null) 'did_doc': didDoc?.toJson(),
    if (accept != null) 'accept': accept,
  };

  @override
  String toString() =>
      "[AuthBodyRequest] {callbackUrl: $callbackUrl, reason: $reason, message: $message, scope: $scope}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorizationRequestMessageBody &&
          runtimeType == other.runtimeType &&
          callbackUrl == other.callbackUrl &&
          reason == other.reason &&
          message == other.message &&
          listEquals(scope, other.scope);

  @override
  int get hashCode => runtimeType.hashCode;
}
