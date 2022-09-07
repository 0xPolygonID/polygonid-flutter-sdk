import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

class AuthenticateParam {
  final String issuerMessage;
  final CircuitDataEntity circuitDataEntity;
  final String identifier;

  AuthenticateParam({
    required this.issuerMessage,
    required this.circuitDataEntity,
    required this.identifier,
  });
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final IdentityRepository _identityRepository;

  AuthenticateUseCase(this._identityRepository);

  @override
  Future<void> execute({required AuthenticateParam param}) async {
    try {
      await _identityRepository.authenticate(
        issuerMessage: param.issuerMessage,
        circuitDataEntity: param.circuitDataEntity,
        identifier: param.identifier,
      );
    } catch (_) {}
  }
}
