import 'dart:convert';

import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/connection_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/fetch/fetch_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/onchain/contract_iden3_message_entity.dart';

import 'common_mocks.dart';
import 'proof_mocks.dart';

class Iden3commMocks {
  /// [ProofScopeRequest]
  static String proofScopeRequestJson = '''
    {
      "id": 1,
      "circuitId": "${CommonMocks.circuitId}",
      "optional": false,
      "query": {
        "allowedIssuers": [
          "*"
        ],
        "context": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld",
        "type": "KYCAgeCredential",
        "credentialSubject": {
          "birthday": {
            "\$lt": 20000101
          }
        }
      }
    }
  ''';
  static String otherProofScopeRequestJson = '''
    {
      "id": 1,
      "circuitId": "${CommonMocks.circuitId}",
      "optional": false,
      "query": {
        "allowedIssuers": [
          "*"
        ],
        "context": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld",
        "type": "KYCCountryOfResidenceCredential",
        "credentialSubject": {
          "city": {
            "\$in": [208, 400]
          }
        }
      }
    }
  ''';

  static ProofScopeRequest proofScopeRequest =
      ProofScopeRequest.fromJson(jsonDecode(proofScopeRequestJson));

  static ProofScopeRequest otherProofScopeRequest =
      ProofScopeRequest.fromJson(jsonDecode(otherProofScopeRequestJson));

  /// [AuthIden3MessageEntity]
  static String authRequestBodyJson = '''
  {
  "reason": "test flow",
  "message": "",
  "callbackUrl": "${CommonMocks.url}",
  "scope": [
    $proofScopeRequestJson, $otherProofScopeRequestJson
  ],
  "url": "${CommonMocks.url}",
  "credentials": [
    {
      "id": "27887",
      "description": "Authenticating with iden3"
    }
  ]
}
  ''';

  static String authRequestJson = '''
{
  "id": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "thid": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "from": "${CommonMocks.did}",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "body": $authRequestBodyJson
}
''';

  static AuthIden3MessageEntity authRequest =
      AuthIden3MessageEntity.fromJson(jsonDecode(authRequestJson));

  /// [FetchIden3MessageEntity]
  static String fetchRequestBodyJson = '''
  {
    "id": "fe4d9b5e-7b7e-4b9e-8c5a-1b5b4b4e4e4e"
  }
  ''';

  static String fetchRequestJson = '''
{
  "id": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/1.0/fetch-request",
  "thid": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "to": "1244GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "body": $fetchRequestBodyJson
}
''';
  static FetchIden3MessageEntity fetchRequest =
      FetchIden3MessageEntity.fromJson(jsonDecode(fetchRequestJson));

  /// [OfferIden3MessageEntity]
  static String offerUrl = "theOfferUrl";

  static String offerRequestBodyJson = '''
  {
      "url": "$offerUrl",
      "credentials": [
        {
          "id": "claimId",
          "description": "claimDescription"
        },
        {
          "id": "otherClaimId",
          "description": "otherClaimDescription"
        }
      ]
  }
''';
  static String offerRequestJson = '''
{
  "id": "1",
  "typ": "theTyp",
  "type": "theType",
  "thid": "theThid",
  "from": "theFrom",
  "body": $offerRequestBodyJson
}
''';
  static OfferIden3MessageEntity offerRequest =
      OfferIden3MessageEntity.fromJson(jsonDecode(offerRequestJson));

  /// [ContractFunctionCallRequest]
  static String contractFunctionCallRequestBodyTxJson = '''
{
  "contract_address": "0x0000000000000000000000000000000000000000",
  "method_id": "0x00000000",
  "chain_id": 1,
  "network": "mainnet"
}
''';
  static String contractFunctionCallRequestBodyJson = '''
{
  "transaction_data": $contractFunctionCallRequestBodyTxJson,
  "reason": "theTransactionReason",
  "scope": [
    $proofScopeRequestJson
  ]
}
''';

  static String contractFunctionCallRequestJson = '''
{
  "id": "theId",
  "typ": "theTyp",
  "type": "theType",
  "body": $contractFunctionCallRequestBodyJson
}
''';

  static ContractIden3MessageEntity contractFunctionCallRequest =
      ContractIden3MessageEntity.fromJson(
          jsonDecode(contractFunctionCallRequestJson));

  static List<ProofRequestEntity> proofRequestList = [
    ProofRequestEntity(Iden3commMocks.proofScopeRequest,
        ProofQueryParamEntity(CommonMocks.field, CommonMocks.intValues, 3)),
    ProofRequestEntity(Iden3commMocks.proofScopeRequest,
        ProofQueryParamEntity(CommonMocks.field, CommonMocks.intValues, 2)),
  ];

  static JWZProofEntity jwzProof = JWZProofEntity(
    id: proofRequestList[0].scope.id,
    circuitId: proofRequestList[0].scope.circuitId,
    proof: ProofMocks.jwzProof.proof,
    pubSignals: ProofMocks.jwzProof.pubSignals,
  );

  static JWZSDProofEntity jwzSdProof = JWZSDProofEntity(
    id: proofRequestList[0].scope.id,
    circuitId: proofRequestList[0].scope.circuitId,
    proof: ProofMocks.jwzProof.proof,
    pubSignals: ProofMocks.jwzProof.pubSignals,
    vp: ProofMocks.vp,
  );

  static List<ConnectionEntity> connectionEntities = [
    ConnectionEntity(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: [],
    ),
    ConnectionEntity(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: [],
    ),
    ConnectionEntity(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: [],
    )
  ];

  static List<ConnectionDTO> connectionDtos = [
    ConnectionDTO(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: const [],
    ),
    ConnectionDTO(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: const [],
    ),
    ConnectionDTO(
      from: CommonMocks.did,
      to: CommonMocks.did,
      interactions: const [],
    )
  ];
}
