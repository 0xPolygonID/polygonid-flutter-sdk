import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetPrivateKeyUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final StacktraceManager _stacktraceManager;

  GetPrivateKeyUseCase(
    this._identityRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required String param}) async {
    try {
      final privateKey = await _identityRepository.getPrivateKey(secret: param);
      return privateKey;
    } catch (error) {
      _stacktraceManager.logError("[GetPrivateKeyUseCase] Error: $error");
      rethrow;
    }
  }
}
