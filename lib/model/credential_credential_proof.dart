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

import 'credential_credential_proof_issuer_mtp.dart';
import 'credential_credential_proof_mtp.dart';
import 'credential_credential_proof_state.dart';

class CredentialCredentialProof {
  final String? type;
  final int? created;
  final String? h_index;
  final String? h_value;
  final String? issuer;

  final CredentialCredentialProofIssuerMTP? issuer_mtp;
  final String? proof_purpose;
  final String? proof_value;
  final String? verification_method;

  final CredentialCredentialProofMTP? mtp;
  final CredentialCredentialProofState? state;

  CredentialCredentialProof({
    this.type,
    this.created,
    this.h_index,
    this.h_value,
    this.issuer,
    this.issuer_mtp,
    this.proof_purpose,
    this.proof_value,
    this.verification_method,
    this.mtp,
    this.state,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialCredentialProof]
  factory CredentialCredentialProof.fromJson(Map<String, dynamic> json) {
    CredentialCredentialProofIssuerMTP? issuer_mtp = json['issuer_mtp'] != null
        ? CredentialCredentialProofIssuerMTP.fromJson(json['issuer_mtp'])
        : null;
    CredentialCredentialProofState? state = json['state'] != null
        ? CredentialCredentialProofState.fromJson(json['state'])
        : null;
    CredentialCredentialProofMTP? mtp = json['mtp'] != null
        ? CredentialCredentialProofMTP.fromJson(json['mtp'])
        : null;
    return CredentialCredentialProof(
        type: json['@type'],
        created: json['created'],
        h_index: json['h_index'],
        h_value: json['h_value'],
        issuer: json['issuer'],
        issuer_mtp: issuer_mtp,
        proof_purpose: json['proof_purpose'],
        proof_value: json['proof_value'],
        verification_method: json['verification_method'],
        mtp: mtp,
        state: state);
  }

  Map<String, dynamic> toJson() => {
        '@type': type,
        'created': created,
        'h_index': h_index,
        'h_value': h_value,
        'issuer': issuer,
        'issuer_mtp': issuer_mtp?.toJson(),
        'proof_purpose': proof_purpose,
        'proof_value': proof_value,
        'verification_method': verification_method,
        'mtp': mtp?.toJson(),
        'state': state?.toJson(),
      };
}
