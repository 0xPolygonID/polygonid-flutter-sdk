/*
{
  "type": "https://iden3-communication.io/credential-issuance/v1",
  "data": {
    "issuer": "11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP",
    "identifier": "114vzNuAfaDyf3XhZgjsoDZe3hRd38dppjSt31YxEL",
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
        "type": "KYCAgeCredential"
      },
      "credentialStatus": {
        "id": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP/claims/revocation/status/36138297",
        "type": "SparseMerkleTreeProof"
      },
      "credentialSubject": {
        "birthday": 19960424,
        "documentType": 693339,
        "id": "114vzNuAfaDyf3XhZgjsoDZe3hRd38dppjSt31YxEL",
        "type": "KYCAgeCredential"
      },
      "expiration": "2023-05-19T07:47:24Z",
      "id": "f7697ea1-3743-4f7d-915d-11b152903f91",
      "proof": [
        {
          "@type": "BJJSignature2021",
          "issuer_data": {
            "auth_claim": [
              "304427537360709784173770334266246861770",
              "0",
              "4902319020363733960211326143115662501466483792224968513997363225717272327641",
              "16007064978769174493437938948140849180766527662203394392738685512899225781288",
              "0",
              "0",
              "0",
              "0"
            ],
            "id": "11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP",
            "mtp": {
              "existence": true,
              "siblings": []
            },
            "revocation_status": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP/claims/revocation/status/36138297",
            "state": {
              "claims_tree_root": "19fc3b9a749d06f0277e5031ced5b4184258039c0e5ffb000f6e66abb265560b",
              "value": "ead5e9c7c90abf298caef3e224ea9ed90d5f534d1688fa7abd7bdb8b9d4b9f01"
            }
          },
          "signature": "9127a8ac4f8a2e01ecf4c853cd8d9bd50741ad243092675f59f6457e9cc55caa84c31d0572949a8d75b11e3effb70635df165815aad95abc12b2399d18340300"
        },
        {
          "@type": "Iden3SparseMerkleProof",
          "issuer_data": {
            "id": "11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP",
            "state": {
              "block_number": 26375171,
              "block_timestamp": 1652946742,
              "claims_tree_root": "0c56936300a13fede7fb44c5e9974ba2b5e1b3a3b24e019fbd4eaaf04afe4c1c",
              "revocation_tree_root": "0000000000000000000000000000000000000000000000000000000000000000",
              "root_of_roots": "f68f983691cdfc1c0fae586988db3dc1e069f96282b281c6d7dc519454f29427",
              "tx_id": "0x9d917227b790e4569fae12255a3e2ecb3eaa6f5326d100f0d9ad48e0e3948cfb",
              "value": "514fac4f225f99cdddfc11b5c0390cc1f7f92f42789936f28f01d3d0ab317e18"
            }
          },
          "mtp": {
            "existence": true,
            "siblings": [
              "21577822386095325298045402000602747458832154492886108792944260455562841911385",
              "0",
              "11764747098890799176479333422181335576391826379623241547783168505160075026856",
              "16972325038497616634656140877692223710673692994081477911197990319195510820618"
            ]
          }
        }
      ],
      "rev_nonce": 36138297,
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
