import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';

class GetProofQueryContextUseCase
    extends FutureUseCase<ProofScopeRequest, Map<String, dynamic>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final StacktraceManager _stacktraceManager;

  GetProofQueryContextUseCase(
    this._iden3commCredentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<Map<String, dynamic>> execute(
      {required ProofScopeRequest param}) async {
    String schemaUrl = param.query.context!;
    _stacktraceManager
        .addTrace("[GetProofQueryContextUseCase] schemaUrl: $schemaUrl");

    if (schemaUrl.isNotEmpty) {
      return _iden3commCredentialRepository
          .fetchSchema(url: schemaUrl)
          .catchError((error) {
        _stacktraceManager
            .addTrace("[GetProofQueryContextUseCase] Error: $error");
        return <String, dynamic>{};
      });
    } else {
      _stacktraceManager.addTrace(
          "[GetProofQueryContextUseCase] schemaUrl empty: $schemaUrl");
      return <String, dynamic>{};
    }
  }
}
