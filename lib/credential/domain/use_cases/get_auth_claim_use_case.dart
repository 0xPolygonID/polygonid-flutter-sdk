import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

class GetAuthClaimUseCase extends FutureUseCase<List<String>, List<String>> {
  final CredentialRepository _credentialRepo;
  final StacktraceManager _stacktraceManager;

  GetAuthClaimUseCase(
    this._credentialRepo,
    this._stacktraceManager,
  );

  @override
  Future<List<String>> execute({required List<String> param}) async {
    return Future(() async {
      final authClaim = await _credentialRepo.getAuthClaim(publicKey: param);
      logger().i("[GetAuthClaimUseCase] auth claim: $authClaim");
      return authClaim;
    }).catchError((error) {
      logger().e("[GetAuthClaimUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetAuthClaimUseCase] Error: $error");
      _stacktraceManager.addError("[GetAuthClaimUseCase] Error: $error");
      throw error;
    });
  }
}
