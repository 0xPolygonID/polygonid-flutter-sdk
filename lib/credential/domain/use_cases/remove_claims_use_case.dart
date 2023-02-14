import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/credential_repository.dart';

class RemoveClaimsParam {
  final List<String> claimIds;
  final String did;
  final String privateKey;

  RemoveClaimsParam({
    required this.claimIds,
    required this.did,
    required this.privateKey,
  });
}

class RemoveClaimsUseCase extends FutureUseCase<RemoveClaimsParam, void> {
  final CredentialRepository _credentialRepository;

  RemoveClaimsUseCase(this._credentialRepository);

  @override
  Future<void> execute({required RemoveClaimsParam param}) async {
    return _credentialRepository
        .removeClaims(
          claimIds: param.claimIds,
          did: param.did,
          privateKey: param.privateKey,
        )
        .then((_) => logger().i(
            "[RemoveClaimsUseCase] Claims with those ids have been removed: $param"))
        .catchError((error) {
      logger().e("[RemoveClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
