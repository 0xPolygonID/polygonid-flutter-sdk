import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/contract_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/fetch_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/offer_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_param_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_requests_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

import 'proof_requests_mapper_test.mocks.dart';

String authRequestData = '''
{
  "id": "a4ba573f-885f-48e1-98ce-b7dfdb47c42b",
  "thid": "a4ba573f-885f-48e1-98ce-b7dfdb47c42b",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "body": {
    "reason": "test flow",
    "message": "",
    "callbackUrl": "https://verifier.polygonid.me/api/callback?sessionId=136493",
    "scope": [
      {
        "id": 1,
        "circuit_id": "credentialAtomicQueryMTP",
        "rules": {
          "query": {
            "allowedIssuers": [
              "*"
            ],
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
    ]
  }
}
''';

String contractRequestData = '''
{
  "id": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/proofs/1.0/contract-invoke-request",
  "thid": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "body": {
    "transaction_data": {
      "contract_address": "0x516D8DBece16890d0670Dfd3Cb1740FcdF375B10",
      "method_id": "b68967e2",
      "chain_id": 80001,
      "network": "polygon-mumbai"
    },
    "reason": "airdrop participation",
    "scope": [
      {
        "id": 1,
        "circuit_id": "credentialAtomicQueryMTP",
        "rules": {
          "query": {
            "allowed_issuers": [
              "*"
            ],
            "req": {
              "birthday": {
                "\$lt": 20000101
              }
            },
            "schema": {
              "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
              "type": "KYCAgeCredential"
            }
          }
        }
      }
    ]
  }
}
''';
AuthRequest mockAuthRequest = AuthRequest.fromJson(jsonDecode(authRequestData));
ContractFunctionCallRequest mockContractCallRequest =
    ContractFunctionCallRequest.fromJson(jsonDecode(contractRequestData));

Iden3MessageMapper iden3messageMapper =
    Iden3MessageMapper(Iden3MessageTypeMapper());

// Dependencies
AuthRequestMapper authRequestMapper =
    AuthRequestMapper(Iden3MessageTypeDataMapper());
ContractRequestMapper contractRequestMapper =
    ContractRequestMapper(Iden3MessageTypeDataMapper());
ProofQueryParamMapper proofQueryParamMapper = ProofQueryParamMapper();
// Mock Dependencies
MockFetchRequestMapper fetchRequestMapper = MockFetchRequestMapper();
MockOfferRequestMapper offerRequestMapper = MockOfferRequestMapper();
// Tested instance
ProofRequestsMapper proofRequestsMapper = ProofRequestsMapper(
  authRequestMapper,
  fetchRequestMapper,
  offerRequestMapper,
  contractRequestMapper,
  proofQueryParamMapper,
);

@GenerateMocks([
  AuthRequestMapper,
  FetchRequestMapper,
  OfferRequestMapper,
  ContractRequestMapper,
  ProofQueryParamMapper,
])
main() {
  group("ProofRequestsMapper", () {
    test("mapFrom authRequest", () {
      Iden3MessageEntity iden3message =
          iden3messageMapper.mapFrom(authRequestData);

      List<ProofRequestEntity> result =
          proofRequestsMapper.mapFrom(iden3message);
      expect(result[0].id, "${mockAuthRequest.body.scope?[0].id}");
      expect(result[0].circuitId, mockAuthRequest.body.scope?[0].circuit_id);
      expect(result[0].info, mockAuthRequest.body.scope?[0].rules?.toJson());
      expect(result[0].optional, false);
      expect(result[0].queryParam.field,
          proofQueryParamMapper.mapFrom(mockAuthRequest.body.scope![0]).field);
      expect(
          result[0].queryParam.operator,
          proofQueryParamMapper
              .mapFrom(mockAuthRequest.body.scope![0])
              .operator);
      expect(result[0].queryParam.values,
          proofQueryParamMapper.mapFrom(mockAuthRequest.body.scope![0]).values);
    });

    test("mapFrom contractRequest", () {
      Iden3MessageEntity iden3message =
          iden3messageMapper.mapFrom(contractRequestData);

      List<ProofRequestEntity> result =
          proofRequestsMapper.mapFrom(iden3message);
      expect(result[0].id, "${mockContractCallRequest.body.scope?[0].id}");
      expect(result[0].circuitId,
          mockContractCallRequest.body.scope?[0].circuit_id);
      expect(result[0].info,
          mockContractCallRequest.body.scope?[0].rules?.toJson());
      expect(result[0].optional, false);
      expect(
          result[0].queryParam.field,
          proofQueryParamMapper
              .mapFrom(mockContractCallRequest.body.scope![0])
              .field);
      expect(
          result[0].queryParam.operator,
          proofQueryParamMapper
              .mapFrom(mockContractCallRequest.body.scope![0])
              .operator);
      expect(
          result[0].queryParam.values,
          proofQueryParamMapper
              .mapFrom(mockContractCallRequest.body.scope![0])
              .values);
    });
  });
}
