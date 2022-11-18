import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/contract_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

String data = '''
{
  "from":"theFrom",
  "thid": "theThid",
  "id": "theId",
  "typ": "theTyp",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "body": {
    "transaction_data": {
      "contract_address": "0x0000000000000000000000000000000000000000",
      "method_id": "0x00000000",
      "chain_id": 1,
      "network": "mainnet"
    },
    "reason": "theTransactionReason",
    "scope": [
      {
        "id": 1,
        "circuit_id": "credentialAtomicQuerySig",
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
    ]
  }
}
''';
var json = jsonDecode(data);
final contractRequest = ContractFunctionCallRequest.fromJson(json);

Iden3MessageMapper iden3messageMapper =
Iden3MessageMapper(Iden3MessageTypeMapper());
// Tested instance
ContractRequestMapper contractRequestMapper =
    ContractRequestMapper(Iden3MessageTypeDataMapper());


void main() {
  group("ContractRequestMapper", () {
    test("toMapper", () {
      Iden3MessageEntity iden3message = iden3messageMapper.mapFrom(data);
      ContractFunctionCallRequest mapTo = contractRequestMapper.mapTo(iden3message);
      expect(mapTo.id, contractRequest.id);
      expect(mapTo.typ, contractRequest.typ);
      expect(mapTo.type, contractRequest.type);
      expect(mapTo.body.transactionData.contractAddress, contractRequest.body.transactionData.contractAddress);
      expect(mapTo.body.transactionData.methodId, contractRequest.body.transactionData.methodId);
      expect(mapTo.body.transactionData.chainId, contractRequest.body.transactionData.chainId);
      expect(mapTo.body.transactionData.network, contractRequest.body.transactionData.network);
      expect(mapTo.body.reason, contractRequest.body.reason);
      expect(mapTo.body.scope?.length, contractRequest.body.scope?.length);
      expect(mapTo.body.scope?[0].id, contractRequest.body.scope?[0].id);
      expect(mapTo.body.scope?[0].circuit_id, contractRequest.body.scope?[0].circuit_id);
      expect(mapTo.body.scope?[0].optional, contractRequest.body.scope?[0].optional);
      expect(mapTo.body.scope?[0].rules?.audience, contractRequest.body.scope?[0].rules?.audience);
      expect(mapTo.body.scope?[0].rules?.challenge, contractRequest.body.scope?[0].rules?.challenge);
      expect(mapTo.body.scope?[0].rules?.query?.allowedIssuers?.length, contractRequest.body.scope?[0].rules?.query?.allowedIssuers?.length);
      expect(mapTo.body.scope?[0].rules?.query?.challenge, contractRequest.body.scope?[0].rules?.query?.challenge);
      expect(mapTo.body.scope?[0].rules?.query?.schema?.type, contractRequest.body.scope?[0].rules?.query?.schema?.type);
      expect(mapTo.body.scope?[0].rules?.query?.schema?.url, contractRequest.body.scope?[0].rules?.query?.schema?.url);
      expect(mapTo.body.scope?[0].rules?.query?.req?.length, contractRequest.body.scope?[0].rules?.query?.req?.length);
    });
  });
}
