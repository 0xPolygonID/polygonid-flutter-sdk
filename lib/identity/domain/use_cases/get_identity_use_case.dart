import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';

class GetIdentityUseCase extends FutureUseCase<String?, IdentityEntity> {
  final IdentityRepository _identityRepository;

  GetIdentityUseCase(this._identityRepository);

  @override
  Future<IdentityEntity> execute({String? param}) {
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
