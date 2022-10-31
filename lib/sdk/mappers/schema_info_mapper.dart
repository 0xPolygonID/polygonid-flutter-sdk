import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/contract_request_mapper.dart';

import '../../common/domain/tuples.dart';
import '../../iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import '../../iden3comm/data/dtos/request/onchain/contract_function_call_request.dart';
import '../../iden3comm/domain/entities/iden3_message_entity.dart';
import '../../iden3comm/domain/exceptions/iden3comm_exceptions.dart';

/// FIXME: handle this on Data side
class SchemaInfoMapper
    extends FromMapper<Iden3MessageEntity, List<Pair<String, String>>> {
  final AuthRequestMapper _authRequestMapper;
  final ContractRequestMapper _contractMapper;

  SchemaInfoMapper(this._authRequestMapper, this._contractMapper);

  @override
  List<Pair<String, String>> mapFrom(Iden3MessageEntity from) {
    List<Pair<String, String>> schemaInfo = [];
    switch (from.type) {
      case Iden3MessageType.unknown:
        throw UnsupportedIden3MsgTypeException(from.type);
      case Iden3MessageType.auth:
        AuthRequest authRequest = _authRequestMapper.mapTo(from);
        if (authRequest.body.scope != null &&
            authRequest.body.scope!.isNotEmpty) {
          for (ProofScopeRequest proofScopeRequest in authRequest.body.scope!) {
            String? schemaUrl = proofScopeRequest.rules?.query?.schema?.url;
            String? schemaType = proofScopeRequest.rules?.query?.schema?.type;
            if (schemaUrl != null &&
                schemaUrl.isNotEmpty &&
                schemaType != null &&
                schemaType.isNotEmpty) {
              schemaInfo.add(Pair(schemaUrl, schemaType));
            }
          }
        }
        break;
      case Iden3MessageType.offer:
        // TODO: Handle this case.
        break;
      case Iden3MessageType.issuance:
        // TODO: Handle this case.
        break;
      case Iden3MessageType.contractFunctionCall:
        ContractFunctionCallRequest contractFunctionCallRequest =
            _contractMapper.mapTo(from);

        if (contractFunctionCallRequest.body.scope != null &&
            contractFunctionCallRequest.body.scope!.isNotEmpty) {
          for (ProofScopeRequest proofScopeRequest
              in contractFunctionCallRequest.body.scope!) {
            String? schemaUrl = proofScopeRequest.rules?.query?.schema?.url;
            String? schemaType = proofScopeRequest.rules?.query?.schema?.type;
            if (schemaUrl != null &&
                schemaUrl.isNotEmpty &&
                schemaType != null &&
                schemaType.isNotEmpty) {
              schemaInfo.add(Pair(schemaUrl, schemaType));
            }
          }
        }
        break;
    }
    return schemaInfo;
  }
}
