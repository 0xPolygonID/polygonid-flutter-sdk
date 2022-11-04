import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class RemoveIdentityParam {
  final String identifier;
  final String privateKey;

  RemoveIdentityParam({
    required this.identifier,
    required this.privateKey,
  });
}

class RemoveIdentityUseCase extends FutureUseCase<RemoveIdentityParam, void> {
  final IdentityRepository _identityRepository;

  RemoveIdentityUseCase(this._identityRepository);

  @override
  Future<void> execute({required RemoveIdentityParam param}) {
    return _identityRepository
        .removeIdentity(
            identifier: param.identifier, privateKey: param.privateKey)
        .catchError((error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
