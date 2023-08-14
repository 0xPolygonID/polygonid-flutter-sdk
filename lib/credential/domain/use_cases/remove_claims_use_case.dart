import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/credential_repository.dart';

class RemoveClaimsParam {
  final List<String> claimIds;
  final String genesisDid;
  final String privateKey;

  RemoveClaimsParam({
    required this.claimIds,
    required this.genesisDid,
    required this.privateKey,
  });
}

class RemoveClaimsUseCase extends FutureUseCase<RemoveClaimsParam, void> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  RemoveClaimsUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required RemoveClaimsParam param}) async {
    return _credentialRepository
        .removeClaims(
      claimIds: param.claimIds,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    )
        .then((_) {
      logger().i(
          "[RemoveClaimsUseCase] Claims with those ids have been removed: $param");
      _stacktraceManager.addTrace(
          "[RemoveClaimsUseCase] Claims with those ids have been removed: $param");
    }).catchError((error) {
      logger().e("[RemoveClaimsUseCase] Error: $error");
      _stacktraceManager.addTrace("[RemoveClaimsUseCase] Error: $error");
      _stacktraceManager.addError("[RemoveClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
