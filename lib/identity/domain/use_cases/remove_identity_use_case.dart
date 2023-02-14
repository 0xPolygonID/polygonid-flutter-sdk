import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../../../credential/domain/use_cases/remove_claims_use_case.dart';
import '../repositories/identity_repository.dart';

class RemoveIdentityParam {
  final String did;
  final String privateKey;

  RemoveIdentityParam({
    required this.did,
    required this.privateKey,
  });
}

class RemoveIdentityUseCase extends FutureUseCase<RemoveIdentityParam, void> {
  final IdentityRepository _identityRepository;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;

  RemoveIdentityUseCase(this._identityRepository, this._removeAllClaimsUseCase);

  @override
  Future<void> execute({required RemoveIdentityParam param}) {
    return _removeAllClaimsUseCase
        .execute(
            param: RemoveAllClaimsParam(
                did: param.did, privateKey: param.privateKey))
        .then((value) => _identityRepository
                .removeIdentity(did: param.did, privateKey: param.privateKey)
                .catchError((error) {
              logger().e("[RemoveIdentityUseCase] Error: $error");

              throw error;
            }))
        .catchError((error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
