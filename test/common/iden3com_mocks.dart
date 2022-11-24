import 'dart:convert';

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/fetch/fetch_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/onchain/contract_function_call_request.dart';

import 'common_mocks.dart';

class Iden3commMocks {
  /// [ProofScopeRequest]
  static String proofScopeRequestJson = '''
    {
      "id": 1,
      "circuit_id": "${CommonMocks.circuitId}",
      "optional": false,
      "rules": {
        "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
        "challenge": 748916,
        "query": {
          "allowedIssuers": [
            "*"
          ],
          "challenge": 123456,
          "schema": {
            "type": "KYCAgeCredential",
            "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
          },
          "req": {
            "birthday": {
              "\$lt": 20000101
            }
          }
        }
      }
    }
  ''';
  static String otherProofScopeRequestJson = '''
    {
      "id": 1,
      "circuit_id": "${CommonMocks.circuitId}",
      "optional": false,
      "rules": {
        "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
        "challenge": 748916,
        "query": {
          "allowedIssuers": [
            "*"
          ],
          "challenge": 123456,
          "schema": {
            "type": "KYCCountryOfResidenceCredential",
            "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
          },
          "req": {
            "city": {
              "\$in": [208, 400]
            }
          }
        }
      }
    }
  ''';

  static ProofScopeRequest proofScopeRequest =
      ProofScopeRequest.fromJson(jsonDecode(proofScopeRequestJson));

  static ProofScopeRequest otherProofScopeRequest =
      ProofScopeRequest.fromJson(jsonDecode(otherProofScopeRequestJson));

  /// [AuthRequest]
  static String authRequestBodyJson = '''
  {
  "reason": "test flow",
  "message": "",
  "callbackUrl": "${CommonMocks.url}",
  "scope": [
    $proofScopeRequestJson, $otherProofScopeRequestJson
  ],
  "url": "theUrl",
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
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "body": $authRequestBodyJson
}
''';

  static AuthRequest authRequest =
      AuthRequest.fromJson(jsonDecode(authRequestJson));

  /// [FetchRequest]
  static String fetchRequestBodyJson = '''
  {
    "id": "fe4d9b5e-7b7e-4b9e-8c5a-1b5b4b4e4e4e"
  }
  ''';

  static String fetchRequestJson = '''
{
  "id": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "thid": "4dd6479b-99b6-405c-ba9e-c7b18d251a5e",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "to": "1244GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "body": $fetchRequestBodyJson
}
''';
  static FetchRequest fetchRequest =
      FetchRequest.fromJson(jsonDecode(fetchRequestJson));

  /// [OfferRequest]
  static String offerRequestBodyJson = '''
  {
      "url": "offerUrl",
      "credentials": [
        {
          "id": "credentialsId",
          "description": "credentialsDescription"
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
  static OfferRequest offerRequest =
      OfferRequest.fromJson(jsonDecode(offerRequestJson));

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

  static ContractFunctionCallRequest contractFunctionCallRequest =
      ContractFunctionCallRequest.fromJson(
          jsonDecode(contractFunctionCallRequestJson));
}
