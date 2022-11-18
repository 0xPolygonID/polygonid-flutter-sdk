import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_body_tx_data_request.dart';

String data = '''
{
  "contract_address": "0x0000000000000000000000000000000000000000",
  "method_id": "0x00000000",
  "chain_id": 1,
  "network": "mainnet"
}
''';
var json = jsonDecode(data);

void main() {
  group("ContractFunctionCallBodyTxDataRequest", () {
    test("fromJson", () {
      var contractFunctionCallBodyTxDataRequest = ContractFunctionCallBodyTxDataRequest.fromJson(json);
      expect(contractFunctionCallBodyTxDataRequest.contractAddress, "0x0000000000000000000000000000000000000000");
      expect(contractFunctionCallBodyTxDataRequest.methodId, "0x00000000");
      expect(contractFunctionCallBodyTxDataRequest.chainId, 1);
      expect(contractFunctionCallBodyTxDataRequest.network, "mainnet");
    });
    test("toJson", () {
      var contractFunctionCallBodyTxDataRequest = ContractFunctionCallBodyTxDataRequest.fromJson(json);
      expect(contractFunctionCallBodyTxDataRequest.toJson(), json);
    });
  });
}
