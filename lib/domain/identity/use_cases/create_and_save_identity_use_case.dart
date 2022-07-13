import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../entities/identity.dart';
import '../repositories/identity_repository.dart';

class CreateAndSaveIdentityUseCase extends FutureUseCase<String?, Identity> {
  final IdentityRepository _identityRepository;

  CreateAndSaveIdentityUseCase(this._identityRepository);

  @override
  Future<Identity> execute({String? param}) {
    return _identityRepository
        .createIdentity(privateKey: param)
        .then((identity) {
      logger().i("[CreateAndSaveIdentityUseCase] Identity: $identity");

      return identity;
    }).catchError((error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
