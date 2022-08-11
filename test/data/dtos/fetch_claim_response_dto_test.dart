import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/fetch_claim_response_dto.dart';

// Data
String mockFetchClaim = '''{
    "body": {
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
                "id": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea/claims/revocation/status/2333442972",
                "type": "SparseMerkleTreeProof"
            },
            "credentialSubject": {
                "birthday": 19960424,
                "documentType": 364488,
                "id": "114JV5rPRxpzwiPq68yjh8dtN82Nht8CGQViZKG1vc",
                "type": "KYCAgeCredential"
            },
            "expiration": "2023-08-15T09:59:08Z",
            "id": "09beadfa-a639-4b83-b70c-e10815ed5dcc",
            "proof": [
                {
                    "@type": "BJJSignature2021",
                    "issuer_data": {
                        "auth_claim": [
                            "304427537360709784173770334266246861770",
                            "0",
                            "19026364412758441267617760696237191085589085513218952390158161375679299212208",
                            "12354833440408705252360074764442381137030093943321809386816483544349245170041",
                            "0",
                            "0",
                            "0",
                            "0"
                        ],
                        "id": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
                        "mtp": {
                            "existence": true,
                            "siblings": []
                        },
                        "revocation_status": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea/claims/revocation/status/0",
                        "state": {
                            "claims_tree_root": "8259e1ce82d9fa9012e917a75bd70d35e72af49865d53a698761f725116b710e",
                            "value": "704f89fe5b4d4b1733fdb1a33d0f6f76085206ae9ef925e5d4fdb383540a0215"
                        }
                    },
                    "signature": "103bfb853f9001ecb3297faaf07d2b4965fb0074b21a4a9f1bba4be450742d0cdbe836d754a9645de1117b6bd4c3f838c61aebe18b736689a95513804f8e6700"
                },
                {
                    "@type": "Iden3SparseMerkleProof",
                    "issuer_data": {
                        "id": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
                        "state": {
                            "block_number": 27629115,
                            "block_timestamp": 1660557578,
                            "claims_tree_root": "530aa9e960c697b079ddbd6c6764e2b0675f86379f45c4b457c45f6243dac81c",
                            "revocation_tree_root": "0000000000000000000000000000000000000000000000000000000000000000",
                            "root_of_roots": "597bfd9b3f1843557d08ca2a1cc44d78cb9506b10258f1ab5f18eb8f48c6cc1d",
                            "tx_id": "0xb683592ea79c74ebaa9b588086c22321bccd9d09a29f232ef43540fd3d96c0da",
                            "value": "30fc2edace6e9281cedc9fbadf19e439dd69faa5e5a17d47514174b5fbe16619"
                        }
                    },
                    "mtp": {
                        "existence": true,
                        "siblings": [
                            "3650528590008061575565400577488966641798644359685602984307114515625901064765",
                            "17296061398950303447778193664869526731784014233976855510716683849493268664245",
                            "11087461068546970012590250327623418039558762269680107894366532898838979552879",
                            "7568206232157644635595492085767319463261623509698923817958348256190281588535",
                            "11493873449623598605487952823323128786954699618715167579844990807712802434897",
                            "0",
                            "12176259679018411545190292107702961719299101725412188075187763685938545916887"
                        ]
                    }
                }
            ],
            "rev_nonce": 2333442972,
            "subject_position": "index",
            "updatable": false,
            "version": 0
        }
    },
    "from": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
    "id": "75ea7aab-ea09-418f-9a1b-8c24d6599351",
    "thid": "05a6b9cc-a3d5-4bc0-891f-feceeb269b08",
    "to": "114JV5rPRxpzwiPq68yjh8dtN82Nht8CGQViZKG1vc",
    "typ": "application/iden3comm-plain-json",
    "type": "https://iden3-communication.io/credentials/1.0/issuance-response"
}''';
String mockOtherTypeFetchClaim = '''{
    "body": {
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
                "id": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea/claims/revocation/status/2333442972",
                "type": "SparseMerkleTreeProof"
            },
            "credentialSubject": {
                "birthday": 19960424,
                "documentType": 364488,
                "id": "114JV5rPRxpzwiPq68yjh8dtN82Nht8CGQViZKG1vc",
                "type": "KYCAgeCredential"
            },
            "expiration": "2023-08-15T09:59:08Z",
            "id": "09beadfa-a639-4b83-b70c-e10815ed5dcc",
            "proof": [
                {
                    "@type": "BJJSignature2021",
                    "issuer_data": {
                        "auth_claim": [
                            "304427537360709784173770334266246861770",
                            "0",
                            "19026364412758441267617760696237191085589085513218952390158161375679299212208",
                            "12354833440408705252360074764442381137030093943321809386816483544349245170041",
                            "0",
                            "0",
                            "0",
                            "0"
                        ],
                        "id": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
                        "mtp": {
                            "existence": true,
                            "siblings": []
                        },
                        "revocation_status": "http://ec2-34-247-165-109.eu-west-1.compute.amazonaws.com:9988/api/v1/identities/114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea/claims/revocation/status/0",
                        "state": {
                            "claims_tree_root": "8259e1ce82d9fa9012e917a75bd70d35e72af49865d53a698761f725116b710e",
                            "value": "704f89fe5b4d4b1733fdb1a33d0f6f76085206ae9ef925e5d4fdb383540a0215"
                        }
                    },
                    "signature": "103bfb853f9001ecb3297faaf07d2b4965fb0074b21a4a9f1bba4be450742d0cdbe836d754a9645de1117b6bd4c3f838c61aebe18b736689a95513804f8e6700"
                },
                {
                    "@type": "Iden3SparseMerkleProof",
                    "issuer_data": {
                        "id": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
                        "state": {
                            "block_number": 27629115,
                            "block_timestamp": 1660557578,
                            "claims_tree_root": "530aa9e960c697b079ddbd6c6764e2b0675f86379f45c4b457c45f6243dac81c",
                            "revocation_tree_root": "0000000000000000000000000000000000000000000000000000000000000000",
                            "root_of_roots": "597bfd9b3f1843557d08ca2a1cc44d78cb9506b10258f1ab5f18eb8f48c6cc1d",
                            "tx_id": "0xb683592ea79c74ebaa9b588086c22321bccd9d09a29f232ef43540fd3d96c0da",
                            "value": "30fc2edace6e9281cedc9fbadf19e439dd69faa5e5a17d47514174b5fbe16619"
                        }
                    },
                    "mtp": {
                        "existence": true,
                        "siblings": [
                            "3650528590008061575565400577488966641798644359685602984307114515625901064765",
                            "17296061398950303447778193664869526731784014233976855510716683849493268664245",
                            "11087461068546970012590250327623418039558762269680107894366532898838979552879",
                            "7568206232157644635595492085767319463261623509698923817958348256190281588535",
                            "11493873449623598605487952823323128786954699618715167579844990807712802434897",
                            "0",
                            "12176259679018411545190292107702961719299101725412188075187763685938545916887"
                        ]
                    }
                }
            ],
            "rev_nonce": 2333442972,
            "subject_position": "index",
            "updatable": false,
            "version": 0
        }
    },
    "from": "114WWtmHRG26ea4HgZMhj6hP2P8F9fmFA5DKG1rSea",
    "id": "75ea7aab-ea09-418f-9a1b-8c24d6599351",
    "thid": "05a6b9cc-a3d5-4bc0-891f-feceeb269b08",
    "to": "114JV5rPRxpzwiPq68yjh8dtN82Nht8CGQViZKG1vc",
    "typ": "application/iden3comm-plain-json",
    "type": "https://iden3-communication.io/credentials/1.0/offer"
}''';
var json = jsonDecode(mockFetchClaim);

// Dependencies

// Tested instance

void main() {
  group("Claim DTO", () {
    setUp(() {});

    test("Serializable", () {
      FetchClaimResponseDTO dto = FetchClaimResponseDTO.fromJson(json);
    });
  });
}
