import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

class GetSchemasUseCase
    extends FutureUseCase<Iden3MessageEntity, List<Map<String, dynamic>>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;

  GetSchemasUseCase(this._iden3commCredentialRepository);

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required Iden3MessageEntity param}) async {
    if (![Iden3MessageType.auth, Iden3MessageType.contractFunctionCall]
        .contains(param.messageType)) {
      return Future.error(UnsupportedIden3MsgTypeException(param.messageType));
    }

    List<Map<String, dynamic>> result = [];

    for (ProofScopeRequest proofScopeRequest in param.body.scope) {
      String? schemaUrl = proofScopeRequest.query.context;

      if (schemaUrl != null && schemaUrl.isNotEmpty) {
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
