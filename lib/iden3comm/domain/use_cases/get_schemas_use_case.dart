import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

class GetSchemasUseCase
    extends FutureUseCase<Iden3Message, List<Map<String, dynamic>>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;

  GetSchemasUseCase(this._iden3commCredentialRepository);

  @override
  Future<List<Map<String, dynamic>>> execute({
    required Iden3Message param,
  }) async {
    if (![
      Iden3MessageType.authRequest,
      Iden3MessageType.proofContractInvokeRequest,
    ].contains(param.type)) {
      return Future.error(
        UnsupportedIden3MsgTypeException(
          type: param.type,
          errorMessage:
              "Unsupported message type: ${param.type}\nExpected: ${Iden3MessageType.authRequest}, ${Iden3MessageType.proofContractInvokeRequest}",
        ),
      );
    }

    List<ZeroKnowledgeProofRequest>? scopes;
    if (param is AuthorizationRequestMessage) {
      scopes = param.body.scope;
    } else if (param is ContractInvokeRequestMessage) {
      scopes = param.body.scope;
    }

    if (scopes == null || scopes.isEmpty) {
      return [];
    }

    List<Map<String, dynamic>> result = [];

    for (ZeroKnowledgeProofRequest proofScopeRequest in scopes) {
      String? schemaUrl = proofScopeRequest.query.context;

      if (schemaUrl.isNotEmpty) {
        Map<String, dynamic> schema = await _iden3commCredentialRepository
            .fetchSchema(url: schemaUrl)
            .catchError((error) => <String, dynamic>{});

        if (schema.isNotEmpty) {
          result.add(schema);
        }
      }
    }

    return result;
  }
}
