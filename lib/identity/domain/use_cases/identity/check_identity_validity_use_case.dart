import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart';

class CheckIdentityValidityUseCase extends FutureUseCase<String, void> {
  final GetPrivateKeyUseCase _getPrivateKeyUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  CheckIdentityValidityUseCase(
    this._getPrivateKeyUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required String param}) {
    return _getPrivateKeyUseCase
        .execute(param: param)
        .then((privateKey) => _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: privateKey, profileNonce: BigInt.zero)))
        .then((_) {
      logger().i("[CheckIdentityValidityUseCase] Identity is valid");
      _stacktraceManager
          .addTrace("[CheckIdentityValidityUseCase] Identity is valid");
    }).catchError((error) {
      logger().e("[CheckValidIdentityUseCase] Error: $error");

      _stacktraceManager.addTrace("[CheckValidIdentityUseCase] Error: $error");
      _stacktraceManager.addError("[CheckValidIdentityUseCase] Error: $error");
      throw error;
    });
  }
}
