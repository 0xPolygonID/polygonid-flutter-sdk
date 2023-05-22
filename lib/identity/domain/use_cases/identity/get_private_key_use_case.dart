import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetPrivateKeyUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;

  GetPrivateKeyUseCase(
    this._identityRepository,
  );

  @override
  Future<String> execute({required String param}) async {
    return _identityRepository.getPrivateKey(secret: param).then((privateKey) {
      logger().i("[GetPrivateKeyUseCase] private key: $privateKey");
      return privateKey;
    }).catchError((error) {
      logger().e("[GetPrivateKeyUseCase] Error: $error");
      throw error;
    });
  }
}
