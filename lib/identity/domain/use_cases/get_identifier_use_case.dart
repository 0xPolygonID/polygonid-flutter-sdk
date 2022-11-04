import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetIdentifierParam {
  final String privateKey;

  GetIdentifierParam({
    required this.privateKey,
  });
}

class GetIdentifierUseCase extends FutureUseCase<GetIdentifierParam, String> {
  final IdentityRepository _identityRepository;

  GetIdentifierUseCase(this._identityRepository);

  @override
  Future<String> execute({required GetIdentifierParam param}) {
    return _identityRepository
        .getIdentifier(privateKey: param.privateKey)
        .then((identifier) {
      logger().i("[GetIdentifierUseCase] Identifier: $identifier");

      return identifier;
    }).catchError((error) {
      logger().e("[GetIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
