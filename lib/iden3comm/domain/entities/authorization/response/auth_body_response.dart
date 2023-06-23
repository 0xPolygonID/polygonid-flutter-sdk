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

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'auth_body_did_doc_response.dart';

class AuthBodyResponse {
  final AuthBodyDidDocResponse? did_doc;
  final String? message;
  final List<Iden3commProofEntity>? proofs;

  AuthBodyResponse({
    this.did_doc,
    required this.message,
    required this.proofs,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [AuthBodyResponse]
  factory AuthBodyResponse.fromJson(Map<String, dynamic> json) {
    AuthBodyDidDocResponse? didDoc = json['did_doc'] != null
        ? AuthBodyDidDocResponse.fromJson(json['did_doc'])
        : null;

    List<Iden3commProofEntity>? scope = (json['scope'] as List?)
        ?.map((item) => Iden3commProofEntity.fromJson(item))
        .toList();
    return AuthBodyResponse(
      did_doc: didDoc,
      message: json['message'],
      proofs: scope,
    );
  }

  Map<String, dynamic> toJson() => {
        'did_doc': did_doc,
        'message': message,
        'scope': proofs?.map((scope) => scope.toJson()).toList(),
      };
}
