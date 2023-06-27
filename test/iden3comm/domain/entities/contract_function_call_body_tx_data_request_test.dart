import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_tx_data_request.dart';

import '../../../common/iden3comm_mocks.dart';

var json = jsonDecode(Iden3commMocks.contractFunctionCallRequestBodyTxJson);

void main() {
  group("ContractFunctionCallBodyTxDataRequest", () {
    test("fromJson", () {
      var contractFunctionCallBodyTxDataRequest =
          ContractFunctionCallBodyTxDataRequest.fromJson(json);
      expect(contractFunctionCallBodyTxDataRequest.contractAddress,
          "0x0000000000000000000000000000000000000000");
      expect(contractFunctionCallBodyTxDataRequest.methodId, "0x00000000");
      expect(contractFunctionCallBodyTxDataRequest.chainId, 1);
      expect(contractFunctionCallBodyTxDataRequest.network, "mainnet");
    });
    test("toJson", () {
      var contractFunctionCallBodyTxDataRequest =
          ContractFunctionCallBodyTxDataRequest.fromJson(json);
      expect(contractFunctionCallBodyTxDataRequest.toJson(), json);
    });
  });
}
