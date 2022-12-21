import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

/// Param required to import the claims database
class ImportClaimsParam {
  final String privateKey;
  final String identifier;
  final String encryptedClaimsDb;

  ImportClaimsParam({
    required this.privateKey,
    required this.identifier,
    required this.encryptedClaimsDb,
  });
}

/// Use case to import the encrypted claims database
class ImportClaimsUseCase extends FutureUseCase<ImportClaimsParam, void> {
  final CredentialRepository _credentialRepository;

  ImportClaimsUseCase(this._credentialRepository);

  @override
  Future<void> execute({required ImportClaimsParam param}) {
    return _credentialRepository.importClaims(
      identifier: param.identifier,
      privateKey: param.privateKey,
      encryptedDb: param.encryptedClaimsDb,
    );
  }
}
