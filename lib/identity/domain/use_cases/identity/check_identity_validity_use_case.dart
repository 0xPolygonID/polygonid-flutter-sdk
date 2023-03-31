import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart';

class CheckIdentityValidityUseCase extends FutureUseCase<String, void> {
  final GetPrivateKeyUseCase _getPrivateKeyUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  CheckIdentityValidityUseCase(
    this._getPrivateKeyUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<void> execute({required String param}) async {
    return _getPrivateKeyUseCase
        .execute(param: param)
        .then((privateKey) => _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(privateKey: privateKey)))
        .then((_) {
      logger().i("[CheckIdentityValidityUseCase] Identity is valid");
    }).catchError((error) {
      logger().e("[CheckValidIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
