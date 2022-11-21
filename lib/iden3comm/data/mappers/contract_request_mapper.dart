import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../dtos/request/onchain/contract_function_call_body_request.dart';
import 'iden3_message_type_data_mapper.dart';

class ContractRequestMapper
    extends ToMapper<ContractFunctionCallRequest, Iden3MessageEntity> {
  final Iden3MessageTypeDataMapper _typeMapper;

  ContractRequestMapper(this._typeMapper);

  @override
  ContractFunctionCallRequest mapTo(Iden3MessageEntity to) {
    return ContractFunctionCallRequest(
        id: to.id,
        typ: to.typ,
        type: _typeMapper.mapTo(to.type),
        body: ContractFunctionCallBodyRequest.fromJson(to.body));
  }
}
