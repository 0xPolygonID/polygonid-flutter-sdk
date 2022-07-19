import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../repositories/identity_repository.dart';

class SignMessageParam {
  final String identifier;
  final String message;

  SignMessageParam(this.identifier, this.message);
}

class SignMessageUseCase extends FutureUseCase<SignMessageParam, String> {
  final IdentityRepository _identityRepository;

  SignMessageUseCase(this._identityRepository);

  @override
  Future<String> execute({required SignMessageParam param}) {
    return _identityRepository
        .signMessage(identifier: param.identifier, message: param.message)
        .then((signature) {
      logger().i(
          "[SignMessageUseCase] message ${param.message} with identifier ${param.identifier} signed successfully: $signature");

      return signature;
    }).catchError((error) {
      logger().e("[SignMessageUseCase] Error: $error");

      throw error;
    });
  }
}
