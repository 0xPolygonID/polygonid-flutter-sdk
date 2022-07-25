import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../repositories/identity_repository.dart';

/// TODO: Remove this UC when we support multiple identity
class GetCurrentIdentifierUseCase extends FutureUseCase<void, String?> {
  final IdentityRepository _identityRepository;

  GetCurrentIdentifierUseCase(this._identityRepository);

  @override
  Future<String?> execute({void param}) {
    return _identityRepository.getCurrentIdentifier().then((identifier) {
      logger()
          .i("[GetCurrentIdentifierUseCase] Current identifier: $identifier");

      return identifier;
    }).catchError((error) {
      logger().e("[GetCurrentIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
