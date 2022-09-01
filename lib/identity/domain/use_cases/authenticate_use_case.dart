import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

class AuthenticateParam {
  final String authQrCodeResult;
  final CircuitDataEntity circuitDataEntity;

  AuthenticateParam({required this.authQrCodeResult, required this.circuitDataEntity});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, bool> {
  final IdentityRepository _identityRepository;

  AuthenticateUseCase(this._identityRepository);

  @override
  Future<bool> execute({required AuthenticateParam param}) async {
    bool authenticated = false;
    try {
      authenticated = await _identityRepository.authenticate(authQrCodeResult: param.authQrCodeResult, circuitDataEntity: param.circuitDataEntity);
    } catch (_) {}
    return authenticated;
  }
}
