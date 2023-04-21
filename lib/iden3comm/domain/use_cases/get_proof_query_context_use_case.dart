import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

class GetProofQueryContextUseCase
    extends FutureUseCase<ProofScopeRequest, Map<String, dynamic>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;

  GetProofQueryContextUseCase(this._iden3commCredentialRepository);

  @override
  Future<Map<String, dynamic>> execute(
      {required ProofScopeRequest param}) async {
    String? schemaUrl = param.query.context!;

    if (schemaUrl != null && schemaUrl.isNotEmpty) {
      return _iden3commCredentialRepository
          .fetchSchema(url: schemaUrl)
          .catchError((error) => <String, dynamic>{});
    } else {
      return <String, dynamic>{};
    }
  }
}
