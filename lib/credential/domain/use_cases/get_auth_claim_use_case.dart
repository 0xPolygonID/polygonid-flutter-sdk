import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

class GetAuthClaimUseCase extends FutureUseCase<List<String>, List<String>> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  GetAuthClaimUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<List<String>> execute({required List<String> param}) async {
    return _credentialRepository
        .getAuthClaim(publicKey: param)
        .then((authClaim) {
      logger().i("[GetAuthClaimUseCase] auth claim: $authClaim");
      _stacktraceManager
          .addTrace("[GetAuthClaimUseCase] auth claim: $authClaim");
      return authClaim;
    }).catchError((error) {
      logger().e("[GetAuthClaimUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetAuthClaimUseCase] Error: $error");
      _stacktraceManager.addError("[GetAuthClaimUseCase] Error: $error");
      throw error;
    });
  }
}
