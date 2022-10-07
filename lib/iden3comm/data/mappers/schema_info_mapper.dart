import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_mapper.dart';

import '../../../common/domain/tuples.dart';
import '../../domain/entities/iden3_message_entity.dart';
import '../../domain/exceptions/iden3comm_exceptions.dart';
import '../dtos/request/auth/proof_scope_request.dart';
import '../dtos/request/onchain/contract_function_call_request.dart';

class SchemaInfoMapper
    extends FromMapper<Iden3Message, List<Pair<String, String>>> {
  @override
  List<Pair<String, String>> mapFrom(Iden3Message from) {
    Iden3MessageType iden3MsgType = Iden3MessageTypeMapper().mapTo(from.type!);
    List<Pair<String, String>> schemaInfo = [];
    switch (iden3MsgType) {
      case Iden3MessageType.unknown:
        throw UnsupportedIden3MsgTypeException(null);
      case Iden3MessageType.auth:
        AuthRequest authRequest = AuthRequest.fromJson(from.toJson());
        if (authRequest.body?.scope != null &&
            authRequest.body!.scope!.isNotEmpty) {
          for (ProofScopeRequest proofScopeRequest
              in authRequest.body!.scope!) {
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
            ContractFunctionCallRequest.fromJson(from.toJson());
        if (contractFunctionCallRequest.body?.scope != null &&
            contractFunctionCallRequest.body!.scope!.isNotEmpty) {
          for (ProofScopeRequest proofScopeRequest
              in contractFunctionCallRequest.body!.scope!) {
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
