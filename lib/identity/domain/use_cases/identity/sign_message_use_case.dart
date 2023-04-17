import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class SignMessageParam {
  final String privateKey;
  final String message;

  SignMessageParam(this.privateKey, this.message);
}

class SignMessageUseCase extends FutureUseCase<SignMessageParam, String> {
  final IdentityRepository _identityRepository;

  SignMessageUseCase(this._identityRepository);

  @override
  Future<String> execute({required SignMessageParam param}) {
    return _identityRepository
        .signMessage(privateKey: param.privateKey, message: param.message)
        .then((signature) {
      logger().i(
          "[SignMessageUseCase] message ${param.message} with privateKey ${param.privateKey} signed successfully: $signature");

      return signature;
    }).catchError((error) {
      logger().e("[SignMessageUseCase] Error: $error");

      throw error;
    });
  }
}
