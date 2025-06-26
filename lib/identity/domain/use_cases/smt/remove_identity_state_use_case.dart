import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';

class RemoveIdentityStateParam {
  final String did;
  final String encryptionKey;

  RemoveIdentityStateParam({
    required this.did,
    required this.encryptionKey,
  });
}

class RemoveIdentityStateUseCase
    extends FutureUseCase<RemoveIdentityStateParam, void> {
  final SMTRepository _smtRepository;
  final StacktraceManager _stacktraceManager;

  RemoveIdentityStateUseCase(
    this._smtRepository,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required RemoveIdentityStateParam param}) {
    return Future.wait([
      _smtRepository.removeSMT(
        type: TreeType.claims,
        did: param.did,
        encryptionKey: param.encryptionKey,
      ),
      _smtRepository.removeSMT(
        type: TreeType.revocation,
        did: param.did,
        encryptionKey: param.encryptionKey,
      ),
      _smtRepository.removeSMT(
        type: TreeType.roots,
        did: param.did,
        encryptionKey: param.encryptionKey,
      ),
    ]).then((did) {
      _stacktraceManager.logTrace(
          "[RemoveIdentityStateUseCase] State has been removed for did: $did");
    }).catchError((error) {
      _stacktraceManager.logError("[RemoveIdentityStateUseCase] Error: $error");
      throw error;
    });
  }
}
