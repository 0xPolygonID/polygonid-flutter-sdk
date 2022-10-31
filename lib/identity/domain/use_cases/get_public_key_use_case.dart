import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

/// FIXME: remove when [PublicIdentity] is created
class GetPublicKeysUseCase extends FutureUseCase<String, List<String>> {
  final IdentityRepository _identityRepository;

  GetPublicKeysUseCase(this._identityRepository);

  @override
  Future<List<String>> execute({required String param}) {
    return _identityRepository
        .getPublicKeys(privateKey: param)
        .catchError((error) {
      logger().e("[GetPublicKeyUseCase] Error: $error");

      throw error;
    });
  }
}
