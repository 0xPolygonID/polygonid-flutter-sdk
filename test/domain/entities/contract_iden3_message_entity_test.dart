import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/onchain/contract_iden3_message_entity.dart';

import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.contractFunctionCallRequestJson);

void main() {
  group("ContractFunctionCallRequest", () {
    test("fromJson", () {
      var contractFunctionCallRequest =
          ContractIden3MessageEntity.fromJson(json);
      expect(contractFunctionCallRequest.id, "theId");
      expect(contractFunctionCallRequest.typ, "theTyp");
      expect(contractFunctionCallRequest.messageType,
          Iden3MessageType.contractFunctionCall);
      expect(contractFunctionCallRequest.body.transactionData.contractAddress,
          "0x0000000000000000000000000000000000000000");
      expect(contractFunctionCallRequest.body.transactionData.methodId,
          "0x00000000");
      expect(contractFunctionCallRequest.body.transactionData.chainId, 1);
      expect(
          contractFunctionCallRequest.body.transactionData.network, "mainnet");
      expect(contractFunctionCallRequest.body.reason, "theTransactionReason");
      expect(contractFunctionCallRequest.body.scope![0].id, 1);
      expect(contractFunctionCallRequest.body.scope![0].circuitId,
          "credentialAtomicQuerySig");

      /// TODO: is there no challenge anymore?
      // expect(
      //     contractFunctionCallRequest.body.scope![0].query.challenge, 748916);
      expect(
          contractFunctionCallRequest.body.scope![0].query.allowedIssuers![0],
          "*");
      expect(contractFunctionCallRequest.body.scope![0].query.type,
          "KYCAgeCredential");
      expect(contractFunctionCallRequest.body.scope![0].query.context,
          "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld");
    });
  });
}
