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

import 'credential_credential_proof_mtp.dart';
import 'credential_credential_proof_state.dart';

class CredentialCredentialProofIssuerData {
  final List<String>? auth_claim;
  final CredentialCredentialProofMTP? mtp;
  final String? revocation_status;
  final String? id;
  final CredentialCredentialProofState? state;

  /*final String? type;
  final String? h_index;
  final String? h_value;
  final String? issuer;*/

  CredentialCredentialProofIssuerData({
    this.id,
    this.auth_claim,
    this.revocation_status,
    /*this.type,
    this.h_index,
    this.h_value,
    this.issuer,*/
    this.mtp,
    this.state,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialCredentialProofIssuerData]
  factory CredentialCredentialProofIssuerData.fromJson(
      Map<String, dynamic>? json) {
    if (json != null) {
      CredentialCredentialProofMTP? mtp;
      CredentialCredentialProofState? state;
      List<String>? auth_claim;
      try {
        state = CredentialCredentialProofState.fromJson(json['state']);
      } catch (e) {
        state = null;
      }

      try {
        mtp = CredentialCredentialProofMTP.fromJson(json['mtp']);
      } catch (e) {
        mtp = null;
      }

      try {
        auth_claim =
            (json['auth_claim'] as List).map((e) => e as String).toList();
      } catch (e) {
        auth_claim = null;
      }

      return CredentialCredentialProofIssuerData(
          id: json['id'],
          auth_claim: auth_claim,
          revocation_status: json['revocation_status'],
          /*type: json['@type'],
          h_index: json['h_index'],
          h_value: json['h_value'],
          issuer: json['issuer'],*/
          mtp: mtp,
          state: state);
    } else {
      throw "something went wrong";
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'auth_claim': auth_claim?.map((e) => e.toString()).toList(),
        /*'@type': type,
        'h_index': h_index,
        'h_value': h_value,
        'issuer': issuer,*/
        'revocation_status': revocation_status,
        'mtp': mtp?.toJson(),
        'state': state?.toJson()
      };
}
