import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';

class CheckIdentityValidityUseCase extends FutureUseCase<String, void> {
  final IdentityRepository _identityRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  CheckIdentityValidityUseCase(
    this._identityRepository,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<void> execute({required String param}) async {
    return _identityRepository
        .getPrivateKey(secret: param)
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
