import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/credential_repository.dart';

class RemoveAllClaimsParam {
  final String did;
  final String privateKey;

  RemoveAllClaimsParam({
    required this.did,
    required this.privateKey,
  });
}

class RemoveAllClaimsUseCase extends FutureUseCase<RemoveAllClaimsParam, void> {
  final CredentialRepository _credentialRepository;
  final StacktraceStreamManager _stacktraceStreamManager;

  RemoveAllClaimsUseCase(
    this._credentialRepository,
    this._stacktraceStreamManager,
  );

  @override
  Future<void> execute({required RemoveAllClaimsParam param}) async {
    return _credentialRepository
        .removeAllClaims(
      genesisDid: param.did,
      privateKey: param.privateKey,
    )
        .then((_) {
      logger().i("[RemoveAllClaimsUseCase] Claims have been removed: $param");
      _stacktraceStreamManager
          .addTrace("[RemoveAllClaimsUseCase] Claims have been removed: $param");
    }).catchError((error) {
      logger().e("[RemoveAllClaimsUseCase] Error: $error");
_stacktraceStreamManager
          .addTrace("[RemoveAllClaimsUseCase] Error: $error");
      _stacktraceStreamManager
          .addError("[RemoveAllClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
