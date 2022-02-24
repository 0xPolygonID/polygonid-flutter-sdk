/*
{
    "type": "https://iden3-communication.io/credential-issuance/v1",
    "data": {
        "issuer": "11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba",
        "identifier": "11B34yHEY4tbE57kGKKFCHezo7rUBgouajFHeNszQm",
        "credential": {
            "@context": [
                "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/iden3credential.json-ld",
                "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
            ],
            "@type": [
                "Iden3Credential"
            ],
            "credentialSchema": {
                "@id": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
                "type": "JsonSchemaValidator2018"
            },
            "credentialStatus": {
                "id": "http://ubuntu@ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:8001/api/v1/identities/11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba/claims/revocation/status/2021140587075232766",
                "type": "SparseMerkleTreeProof"
            },
            "credentialSubject": {
                "birthday": 19960425,
                "documentType": 1,
                "id": "11B34yHEY4tbE57kGKKFCHezo7rUBgouajFHeNszQm",
                "type": "KYCAgeCredential"
            },
            "expiration": "2361-03-21T19:14:48Z",
            "id": "8edaf101-6472-4df9-a203-47afe101fb1e",
            "proof": [
                {
                    "@type": "BJJSignature2021",
                    "created": 1642420429,
                    "h_index": "9d5e8ab27d7f182a318c8237604d9f2b0d268b8c3cf93657085981082331460c",
                    "h_value": "805b189e63bdfdb14025823619318ce11d5f8d30a8575c10e6defb7d32b94506",
                    "issuer": "11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba",
                    "issuer_mtp": {
                        "@type": "Iden3SparseMerkleProof",
                        "h_index": "b2baba9e38ee25c5a7ce7d8b39ef497d9082d4319c18850380ba68dec2bb7301",
                        "h_value": "46993eb76d20c1880406798b1b9237092515c2d9949620510ec7196e43fd3205",
                        "issuer": "11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba",
                        "mtp": {
                            "existence": true,
                            "siblings": []
                        },
                        "state": {
                            "claims_tree_root": "ae6f27b2b035f09553d5983dd6383fb520952d0f3ee288984422455f86f10918",
                            "value": "72b09f9a34d11b9b66f8b20978ca7155343021dfcc7193fdc9c3ac77208ff200"
                        }
                    },
                    "proof_purpose": "Authentication",
                    "proof_value": "d65e9a8dec31343038b3f46a57d5ad6f87edc834e2aef1c3dbd369614b76a326aa074a3d125e7c46dbc79f43420cf3e80ed2341e56f09794f85758dc4632c305",
                    "verification_method": "c2bd6a213b7ea880453b8053fdc13c4a7ebd656a3c069fa0bcaaeb489981f808"
                },
                {
                    "@type": "Iden3SparseMerkleProof",
                    "h_index": "9d5e8ab27d7f182a318c8237604d9f2b0d268b8c3cf93657085981082331460c",
                    "h_value": "805b189e63bdfdb14025823619318ce11d5f8d30a8575c10e6defb7d32b94506",
                    "issuer": "11AVb27nWq5Eq4HzxbmiZandZCbRSh4MDkMyE3s6Ba",
                    "mtp": {
                        "existence": true,
                        "siblings": [
                            "10873076933116936432587820150928738343559297166429221106506697474674463829934",
                            "0",
                            "0",
                            "0",
                            "0",
                            "16042475069621918990647236921255770524340295309840957495747792277614674913463"
                        ]
                    },
                    "state": {
                        "block_number": 11832821,
                        "block_timestamp": 1642420486,
                        "claims_tree_root": "225e8cfb7e1b606fac1751d4be5974a54265822d8dfad691727aff2b0f05b30f",
                        "revocation_tree_root": "0000000000000000000000000000000000000000000000000000000000000000",
                        "tx_id": "0x6f41d8d5ec6032a656785db1b47504a010057237b1781e6bd9e0d70ce59fdcbe",
                        "value": "a799af427c8f140c3e5b4e85cbf2da2c3f0a3e2c7a7505d9f5b25c86fc4e3403"
                    }
                }
            ],
            "rev_nonce": 2021140587075232800,
            "updatable": false,
            "version": 0
        }
    }
}
*/

import 'credential_data.dart';

class Credential {
  final String? type;
  final CredentialData? data;

  Credential({
    this.type,
    this.data,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [Credential]
  factory Credential.fromJson(Map<String, dynamic> json) {
    CredentialData data = CredentialData.fromJson(json['data']);
    return Credential(
      type: json['type'],
      data: data,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data!.toJson(),
      };
}
