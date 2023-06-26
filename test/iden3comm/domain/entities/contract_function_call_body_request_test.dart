import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_request.dart';

import '../../../common/iden3comm_mocks.dart';

var json = jsonDecode(Iden3commMocks.contractFunctionCallRequestBodyJson);

void main() {
  group("ContractFunctionCallBodyRequest", () {
    test("fromJson", () {
      var contractFunctionCallBodyRequest =
          ContractFunctionCallBodyRequest.fromJson(json);
      expect(contractFunctionCallBodyRequest.transactionData.contractAddress,
          "0x0000000000000000000000000000000000000000");
      expect(contractFunctionCallBodyRequest.transactionData.methodId,
          "0x00000000");
      expect(contractFunctionCallBodyRequest.transactionData.chainId, 1);
      expect(
          contractFunctionCallBodyRequest.transactionData.network, "mainnet");
      expect(contractFunctionCallBodyRequest.reason, "theTransactionReason");
      expect(contractFunctionCallBodyRequest.scope![0].id, 1);
      expect(contractFunctionCallBodyRequest.scope![0].circuitId,
          "credentialAtomicQuerySig");
      expect(contractFunctionCallBodyRequest.scope![0].query.allowedIssuers![0],
          "*");
      expect(contractFunctionCallBodyRequest.scope![0].query.type,
          "KYCAgeCredential");
      expect(contractFunctionCallBodyRequest.scope![0].query.context,
          "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld");
    });

    test("toJson", () {
      var contractFunctionCallBodyRequest =
          ContractFunctionCallBodyRequest.fromJson(json);
      expect(contractFunctionCallBodyRequest.toJson(), json);
    });
  });
}
