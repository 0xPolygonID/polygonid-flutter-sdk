import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class SaveClaimsParam {
  final List<CredentialEntity> claims;
  final String genesisDid;
  final String encryptionKey;

  SaveClaimsParam({
    required this.claims,
    required this.genesisDid,
    required this.encryptionKey,
  });
}

class SaveClaimsUseCase
    extends FutureUseCase<SaveClaimsParam, List<CredentialEntity>> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  SaveClaimsUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<List<CredentialEntity>> execute(
      {required SaveClaimsParam param}) async {
    try {
      await _credentialRepository.saveCredentials(
        credentials: param.claims,
        genesisDid: param.genesisDid,
        encryptionKey: param.encryptionKey,
      );
      _stacktraceManager.logTrace(
          "[SaveClaimsUseCase] All claims have been saved: ${param.claims}");
      return param.claims;
    } catch (error) {
      _stacktraceManager.logError("[SaveClaimsUseCase] Error: $error");
      rethrow;
    }
  }
}
