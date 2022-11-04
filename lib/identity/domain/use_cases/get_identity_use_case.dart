import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';

class GetIdentityParam {
  final String identifier;
  final String? privateKey;

  GetIdentityParam({
    required this.identifier,
    this.privateKey,
  });
}

class GetIdentityUseCase
    extends FutureUseCase<GetIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;

  GetIdentityUseCase(this._identityRepository);

  @override
  Future<IdentityEntity> execute({required GetIdentityParam param}) {
    return _identityRepository
        .getIdentity(identifier: param.identifier, privateKey: param.privateKey)
        .then((identity) {
      logger().i("[GetIdentityUseCase] Identity: $identity");

      return identity;
    }).catchError((error) {
      logger().e("[GetIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
