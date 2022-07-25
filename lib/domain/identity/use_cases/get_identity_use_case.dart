import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../entities/identity.dart';
import '../repositories/identity_repository.dart';

class GetIdentityUseCase extends FutureUseCase<String?, Identity> {
  final IdentityRepository _identityRepository;

  GetIdentityUseCase(this._identityRepository);

  @override
  Future<Identity> execute({String? param}) {
    return _identityRepository
        .getIdentityFromKey(privateKey: param)
        .then((identity) {
      logger().i("[GetIdentityUseCase] Identity: $identity");

      return identity;
    }).catchError((error) {
      logger().e("[GetIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
