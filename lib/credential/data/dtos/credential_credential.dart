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

import 'credential_credential_proof.dart';
import 'credential_credential_schema.dart';
import 'credential_credential_status.dart';
import 'credential_credential_subject.dart';

class CredentialCredential {
  final CredentialCredentialSchema? credentialSchema;
  final CredentialCredentialStatus? credentialStatus;
  final CredentialCredentialSubject? credentialSubject;
  final String? expiration;
  final String? id;
  final List<CredentialCredentialProof>? proof;
  final BigInt? rev_nonce;
  final bool? updatable;
  final int? version;

  CredentialCredential(
      {this.credentialSchema,
      this.credentialStatus,
      this.credentialSubject,
      this.expiration,
      this.id,
      this.proof,
      this.rev_nonce,
      this.updatable,
      this.version});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialCredential]
  factory CredentialCredential.fromJson(Map<String, dynamic> json) {
    CredentialCredentialSchema credentialSchema =
        CredentialCredentialSchema.fromJson(json['credentialSchema']);
    CredentialCredentialStatus credentialStatus =
        CredentialCredentialStatus.fromJson(json['credentialStatus']);
    CredentialCredentialSubject credentialSubject =
        CredentialCredentialSubject.fromJson(json['credentialSubject']);
    List<CredentialCredentialProof>? proof = (json['proof'] as List?)
        ?.map((item) => CredentialCredentialProof.fromJson(item))
        .toList();

    return CredentialCredential(
        credentialSchema: credentialSchema,
        credentialStatus: credentialStatus,
        credentialSubject: credentialSubject,
        expiration: json['expiration'],
        id: json['id'],
        proof: proof,
        rev_nonce: BigInt.parse(json['rev_nonce'].toInt().toString()),
        updatable: json['updatable'],
        version: json['version']);
  }

  Map<String, dynamic> toJson() => {
        'credentialSchema': credentialSchema!.toJson(),
        'credentialStatus': credentialStatus!.toJson(),
        'credentialSubject': credentialSubject!.toJson(),
        'expiration': expiration,
        'id': id,
        'proof': proof?.map((e) => e.toJson()).toList(),
        'rev_nonce': rev_nonce!.toInt(),
        'updatable': updatable,
        'version': version,
      };
}
