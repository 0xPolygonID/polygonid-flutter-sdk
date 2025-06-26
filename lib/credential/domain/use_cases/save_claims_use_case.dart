import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class SaveClaimsParam {
  final List<ClaimEntity> claims;
  final String genesisDid;
  final String encryptionKey;

  SaveClaimsParam({
    required this.claims,
    required this.genesisDid,
    required this.encryptionKey,
  });
}

class SaveClaimsUseCase
    extends FutureUseCase<SaveClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  SaveClaimsUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity>> execute({required SaveClaimsParam param}) async {
    try {
      await _credentialRepository.saveClaims(
        claims: param.claims,
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
