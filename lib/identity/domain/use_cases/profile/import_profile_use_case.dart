import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

/// Param required to import the profile database
class ImportProfileParam {
  final String privateKey;
  final String did;
  final String encryptedDb;

  ImportProfileParam({
    required this.privateKey,
    required this.did,
    required this.encryptedDb,
  });
}

/// Use case to import the encrypted profile database
class ImportProfileUseCase extends FutureUseCase<ImportProfileParam, void> {
  final IdentityRepository _identityRepository;

  ImportProfileUseCase(this._identityRepository);

  @override
  Future<void> execute({required ImportProfileParam param}) {
    return _identityRepository
        .importIdentity(
      did: param.did,
      privateKey: param.privateKey,
      encryptedDb: param.encryptedDb,
    )
        .then((_) {
      logger().i(
          "[ImportProfileUseCase] Profile for did ${param.did} has been imported");
    }).catchError((error) {
      logger().e("[ImportProfileUseCase] Error: $error");

      throw error;
    });
  }
}
