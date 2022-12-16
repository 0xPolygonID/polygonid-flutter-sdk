import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

/// Param required to import the encrypted claims database
class ImportEncryptedClaimsDbParam {
  final String privateKey;
  final String identifier;
  final String encryptedClaimsDb;

  ImportEncryptedClaimsDbParam({
    required this.privateKey,
    required this.identifier,
    required this.encryptedClaimsDb,
  });
}

/// Use case to import the encrypted claims database
class ImportEncryptedClaimsDbUseCase extends FutureUseCase<ImportEncryptedClaimsDbParam, void> {
  final CredentialRepository _credentialRepository;

  ImportEncryptedClaimsDbUseCase(this._credentialRepository);

  @override
  Future<void> execute({required ImportEncryptedClaimsDbParam param}) {
    return _credentialRepository.importEncryptedClaimsDb(
      identifier: param.identifier,
      privateKey: param.privateKey,
      encryptedDb: param.encryptedClaimsDb,
    );
  }
}