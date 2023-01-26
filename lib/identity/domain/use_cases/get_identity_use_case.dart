import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';
import 'get_did_use_case.dart';

class GetIdentityParam {
  final String did;
  final String? privateKey;

  GetIdentityParam({
    required this.did,
    this.privateKey,
  });
}

class GetIdentityUseCase
    extends FutureUseCase<GetIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetDidUseCase _getDidUseCase;

  GetIdentityUseCase(this._identityRepository, this._getDidUseCase);

  @override
  Future<IdentityEntity> execute({required GetIdentityParam param}) {
    return param.privateKey != null
        ? _getDidUseCase.execute(param: param.did).then((did) =>
            _identityRepository.getPrivateIdentity(
                did: did, privateKey: param.privateKey!))
        : _identityRepository.getIdentity(did: param.did).then((identity) {
            logger().i("[GetIdentityUseCase] Identity: $identity");

            return identity;
          }).catchError((error) {
            logger().e("[GetIdentityUseCase] Error: $error");

            throw error;
          });
  }
}
