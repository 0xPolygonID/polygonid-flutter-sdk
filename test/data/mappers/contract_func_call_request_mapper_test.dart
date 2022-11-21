import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/contract_func_call_request_mapper.dart';

String data = '''
{
  "id": "theId",
  "typ": "theTyp",
  "type": "theType",
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

// Tested instance
ContractFuncCallMapper contractFuncCallMapper = ContractFuncCallMapper();

void main() {
  group("ContractFuncCallMapper", () {
    test("mapFrom", () {
      var contractFunctionCallRequest = contractFuncCallMapper.mapFrom(data);
      expect(contractFunctionCallRequest.id, "theId");
      expect(contractFunctionCallRequest.typ, "theTyp");
      expect(contractFunctionCallRequest.type, "theType");
      expect(contractFunctionCallRequest.body.transactionData.contractAddress,
          "0x0000000000000000000000000000000000000000");
      expect(contractFunctionCallRequest.body.transactionData.methodId,
          "0x00000000");
      expect(contractFunctionCallRequest.body.transactionData.chainId, 1);
      expect(
          contractFunctionCallRequest.body.transactionData.network, "mainnet");
      expect(contractFunctionCallRequest.body.reason, "theTransactionReason");
      expect(contractFunctionCallRequest.body.scope?[0].id, 1);
      expect(contractFunctionCallRequest.body.scope?[0].circuit_id,
          "credentialAtomicQuerySig");
      expect(contractFunctionCallRequest.body.scope?[0].optional, false);
      expect(contractFunctionCallRequest.body.scope?[0].rules?.audience,
          "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b");
      expect(
          contractFunctionCallRequest.body.scope?[0].rules?.challenge, 748916);
      expect(
          contractFunctionCallRequest
              .body.scope?[0].rules?.query?.allowedIssuers?[0],
          "*");
      expect(contractFunctionCallRequest.body.scope?[0].rules?.query?.challenge,
          123456);
      expect(
          contractFunctionCallRequest.body.scope?[0].rules?.query?.schema?.type,
          "KYCAgeCredential");
      expect(
          contractFunctionCallRequest.body.scope?[0].rules?.query?.schema?.url,
          "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld");
    });
  });
}
