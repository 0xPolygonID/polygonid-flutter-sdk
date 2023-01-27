import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/credential_repository.dart';

class RemoveAllClaimsParam {
  final String did;
  final String privateKey;

  RemoveAllClaimsParam({
    required this.did,
    required this.privateKey,
  });
}

class RemoveAllClaimsUseCase extends FutureUseCase<RemoveAllClaimsParam, void> {
  final CredentialRepository _credentialRepository;

  RemoveAllClaimsUseCase(this._credentialRepository);

  @override
  Future<void> execute({required RemoveAllClaimsParam param}) async {
    return _credentialRepository
        .removeAllClaims(
          did: param.did,
          privateKey: param.privateKey,
        )
        .then((_) => logger().i(
            "[RemoveAllClaimsUseCase] Claims have been removed: $param"))
        .catchError((error) {
      logger().e("[RemoveAllClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
