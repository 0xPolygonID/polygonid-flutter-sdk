import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

import '../repositories/credential_repository.dart';

class GetVocabsUseCase
    extends FutureUseCase<Iden3MessageEntity, List<Map<String, dynamic>>> {
  final CredentialRepository _credentialRepository;

  GetVocabsUseCase(this._credentialRepository);

  @override
  Future<List<Map<String, dynamic>>> execute(
      {required Iden3MessageEntity param}) async {
    if (param.type != Iden3MessageType.auth ||
        param.type != Iden3MessageType.contractFunctionCall) {
      return Future.error(UnsupportedIden3MsgTypeException(param.type));
    }

    List<Map<String, dynamic>> result = [];

    for (ProofScopeRequest proofScopeRequest in param.body.scope) {
      String? schemaUrl = proofScopeRequest.rules.query.schema?.url;
      String? schemaType = proofScopeRequest.rules.query.schema?.type;

      if (schemaUrl != null &&
          schemaUrl.isNotEmpty &&
          schemaType != null &&
          schemaType.isNotEmpty) {
        result.add(await _credentialRepository.fetchSchema(url: schemaUrl).then(
            (schema) => _credentialRepository.fetchVocab(
                schema: schema, type: schemaType)));
      }
    }

    return result;
  }
}
