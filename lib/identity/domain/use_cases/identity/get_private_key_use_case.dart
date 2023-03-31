import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';

class GetPrivateKeyUseCase extends FutureUseCase<String, String> {
  final String _accessMessage;
  final IdentityRepository _identityRepository;

  GetPrivateKeyUseCase(
    @Named('accessMessage') this._accessMessage,
    this._identityRepository,
  );

  @override
  Future<String> execute({required String param}) async {
    return _identityRepository
        .getPrivateKey(accessMessage: _accessMessage, secret: param)
        .then((privateKey) {
      logger().i("[GetPrivateKeyUseCase] private key: $privateKey");
      return privateKey;
    }).catchError((error) {
      logger().e("[GetPrivateKeyUseCase] Error: $error");
      throw error;
    });
  }
}
