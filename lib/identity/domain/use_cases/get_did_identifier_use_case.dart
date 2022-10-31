import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;

  GetDidIdentifierUseCase(this._identityRepository);

  @override
  Future<String> execute({required String param}) {
    return _identityRepository
        .getDidIdentifier(identifier: param)
        .then((didIdentifier) {
      logger().i("[GetDidIdentifierUseCase] DID identifier: $didIdentifier");

      return didIdentifier;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
