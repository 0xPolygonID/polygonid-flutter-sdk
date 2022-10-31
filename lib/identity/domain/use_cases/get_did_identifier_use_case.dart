import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final String identifier;
  final String networkName;
  final String networkEnv;

  GetDidIdentifierParam({
    required this.identifier,
    required this.networkName,
    required this.networkEnv,
  });
}

class GetDidIdentifierUseCase
    extends FutureUseCase<GetDidIdentifierParam, String> {
  final IdentityRepository _identityRepository;

  GetDidIdentifierUseCase(this._identityRepository);

  @override
  Future<String> execute({required GetDidIdentifierParam param}) {
    return _identityRepository
        .getDidIdentifier(
            identifier: param.identifier,
            networkName: param.networkName,
            networkEnv: param.networkEnv)
        .then((didIdentifier) {
      logger().i("[GetDidIdentifierUseCase] DID identifier: $didIdentifier");

      return didIdentifier;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
