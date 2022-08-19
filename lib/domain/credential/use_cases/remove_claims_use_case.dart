import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../../identity/repositories/credential_repository.dart';

class RemoveClaimsUseCase extends FutureUseCase<List<String>, void> {
  final CredentialRepository _credentialRepository;

  RemoveClaimsUseCase(this._credentialRepository);

  @override
  Future<void> execute({required List<String> param}) async {
    return _credentialRepository
        .removeClaims(ids: param)
        .then((_) => logger().i(
            "[RemoveClaimsUseCase] Claims with those ids have been removed: $param"))
        .catchError((error) {
      logger().e("[RemoveClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
