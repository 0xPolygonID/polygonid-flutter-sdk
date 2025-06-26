import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class BackupIdentityParam {
  final String genesisDid;
  final String encryptionKey;

  BackupIdentityParam({
    required this.genesisDid,
    required this.encryptionKey,
  });
}

class BackupIdentityUseCase extends FutureUseCase<BackupIdentityParam, String> {
  final GetIdentityUseCase _getIdentityUseCase;
  final IdentityRepository _identityRepository;
  final StacktraceManager _stacktraceManager;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._identityRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required BackupIdentityParam param}) async {
    final identity = await _getIdentityUseCase.execute(
      param: GetIdentityParam(
        genesisDid: param.genesisDid,
      ),
    );

    try {
      final export = await _identityRepository.exportIdentity(
        did: identity.did,
        encryptionKey: param.encryptionKey,
      );
      _stacktraceManager.logTrace(
          "[BackupIdentityUseCase] Identity backed up with did: ${identity.did}");
      return export;
    } catch (error) {
      _stacktraceManager.logError("[BackupIdentityUseCase] Error: $error");
      rethrow;
    }
  }
}
