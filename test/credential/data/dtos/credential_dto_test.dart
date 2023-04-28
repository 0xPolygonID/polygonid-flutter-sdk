import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';

// Data
String data = '''
{
  "@context": [
    "https://www.w3.org/2018/credentials/v1",
    "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/iden3credential-v2.json-ld",
    "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld"
  ],
  "credentialSchema": {
    "id": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json/KYCAgeCredential-v3.json",
    "type": "JsonSchemaValidator2018"
  },
  "credentialStatus": {
    "id": "http://52.213.238.159/api/v1/identities/did%3Apolygonid%3Apolygon%3Amumbai%3A2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB/claims/revocation/status/2695678422",
    "revocationNonce": 2695678422,
    "type": "SparseMerkleTreeProof"
  },
  "credentialSubject": {
    "birthday": 19960424,
    "documentType": 899417,
    "id": "did:polygonid:polygon:mumbai:2qGJnNTaHyvZwcTG4jWDif2E5GnWuLGfuWb2misbrC",
    "type": "KYCAgeCredential"
  },
  "expirationDate": "2030-01-01T00:00:00Z",
  "id": "http://52.213.238.159/api/v1/identities/did:polygonid:polygon:mumbai:2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB/claims/3f43b616-9d57-11ed-a2b8-0242ac120004",
  "issuanceDate": "2023-01-26T08:55:56.747082936Z",
  "issuer": "did:polygonid:polygon:mumbai:2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB",
  "proof": [
    {
      "coreClaim": "c9b2370371b7fa8b3dab2a5ba81b68382a000000000000000000000000000000021254956ce0d077706ce9c95fe7e7998897a106a37c11d544154e151a850d006e9670688456f9f4be95af1f032b527ba957d5b7b9f70a6cfeac4abb151caf230000000000000000000000000000000000000000000000000000000000000000d6c9aca00000000080d8db700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      "issuerData": {
        "authCoreClaim": "cca3371a6cb1b715004407e325bd993c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c05e1567fa2f44c94f26e84f8463fb39dbee2d98d90c9a7d343aa02aea1e80146bb9acb6b6f75a23edbfbed032826b699ee637b9944cb5e7680f26e5b789fe0f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
        "credentialStatus": {
          "id": "http://52.213.238.159/api/v1/identities/did%3Apolygonid%3Apolygon%3Amumbai%3A2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB/claims/revocation/status/0",
          "revocationNonce": 0,
          "type": "SparseMerkleTreeProof"
        },
        "id": "did:polygonid:polygon:mumbai:2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB",
        "mtp": {
          "existence": true,
          "siblings": []
        },
        "state": {
          "rootOfRoots": "02427d5b0d16baf64e1513f9650eb959550b7c4d54738a707d1de355b756a914",
          "claimsTreeRoot": "6b8bb8c1dac02f010ac1642a694a3d7b32e1152907636521fb31dc01ba6abf0f",
          "revocationTreeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
          "value": "168f3b0c33822a02e3c070ead88e1169c922984b8a91a8600dfe8a51eb9de12e"
        }
      },
      "signature": "09f22d676951d71c96cea291a011708f9de1380b8bb895d28bf9784104c0e209fda21b1f3ff6e0f94dfdf38c2e4b9cf428a3798cc03b99ed0c4ddcd29e12f401",
      "type": "BJJSignature2021"
    },
    {
      "coreClaim": "c9b2370371b7fa8b3dab2a5ba81b68382a000000000000000000000000000000021254956ce0d077706ce9c95fe7e7998897a106a37c11d544154e151a850d006e9670688456f9f4be95af1f032b527ba957d5b7b9f70a6cfeac4abb151caf230000000000000000000000000000000000000000000000000000000000000000d6c9aca00000000080d8db700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      "issuerData": {
        "id": "did:polygonid:polygon:mumbai:2qJNoD4vLiuoaM6B5rEidsSR4Kj9ZTJp1wgvhB6wBB",
        "state": {
          "blockNumber": 31423536,
          "blockTimestamp": 1674723432,
          "claimsTreeRoot": "94b6bf063ddd6a0881f99b5580e5ebe36613d37dc6ade51679f46683f7f37e03",
          "revocationTreeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
          "rootOfRoots": "ae0d86725527bf08779e54ac6636ce6db251cb7e82fcf8fac089200f07fbc70c",
          "txId": "0xc723a7353e36d06e21bb1426db845ebc4705c28188c13e60a67d7de3c9ccef05",
          "value": "8eda95e0017d30a9b48d01ad26efdb47fe28b3a9704732b1fb8537917bf13d0f"
        }
      },
      "mtp": {
        "existence": true,
        "siblings": [
          "9224151524065521610459630456698808555233973268242007269052989118449206228209",
          "14838613564893626998757603376162516408231719530749557145478409763867715178472",
          "0",
          "1629821442553780810224570434827430830509082759185746511632017916301016098201",
          "14633544220149887348900383206633509039569184168313773699754851378075184622010"
        ]
      },
      "type": "Iden3SparseMerkleProof"
    }
  ],
  "type": [
    "VerifiableCredential",
    "KYCAgeCredential"
  ]
}
''';
var json = jsonDecode(data);

// Dependencies

// Tested instance

void main() {
  group("Credential DTO", () {
    setUp(() {});

    test("Serializable", () {
      ClaimInfoDTO dto = ClaimInfoDTO.fromJson(json);
      dto.toJson();
    });
  });
}
