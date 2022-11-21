import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';

class ContractFuncCallMapper
    extends FromMapper<String, ContractFunctionCallRequest> {
  @override
  ContractFunctionCallRequest mapFrom(String from) {
    Map<String, dynamic> param = jsonDecode(from);
    ContractFunctionCallRequest contractFunctionCallRequest =
        ContractFunctionCallRequest.fromJson(param);
    return contractFunctionCallRequest;
  }
}
