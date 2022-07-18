import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../repositories/identity_repository.dart';

class CreateIdentityUseCase extends FutureUseCase<String?, String> {
  final IdentityRepository _identityRepository;

  CreateIdentityUseCase(this._identityRepository);

  @override
  Future<String> execute({String? param}) {
    return _identityRepository
        .createIdentity(privateKey: param)
        .then((identifier) {
      logger().i(
          "[CreateIdentityUseCase] Identity created with identifier: $identifier, for key $param");

      return identifier;
    }).catchError((error) {
      logger().e("[CreateIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
