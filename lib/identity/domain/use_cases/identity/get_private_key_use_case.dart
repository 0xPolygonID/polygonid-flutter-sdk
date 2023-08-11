import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';

class GetPrivateKeyUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final StacktraceManager _stacktraceManager;

  GetPrivateKeyUseCase(
    this._identityRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required String param}) async {
    return _identityRepository.getPrivateKey(secret: param).then((privateKey) {
      logger().i("[GetPrivateKeyUseCase] private key: $privateKey");
      _stacktraceManager
          .addTrace("[GetPrivateKeyUseCase] private key: $privateKey");
      return privateKey;
    }).catchError((error) {
      logger().e("[GetPrivateKeyUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetPrivateKeyUseCase] Error: $error");
      _stacktraceManager.addError("[GetPrivateKeyUseCase] Error: $error");
      throw error;
    });
  }
}
