import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class RemoveIdentityUseCase extends FutureUseCase<String, void> {
  final IdentityRepository _identityRepository;

  RemoveIdentityUseCase(this._identityRepository);

  @override
  Future<void> execute({required String param}) {
    return _identityRepository.removeIdentity(did: param).catchError((error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
