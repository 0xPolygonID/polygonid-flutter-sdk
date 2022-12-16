import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

/// Param required to export the encrypted claims database
class ExportEncryptedClaimsDbParam {
  final String privateKey;
  final String identifier;

  ExportEncryptedClaimsDbParam({
    required this.privateKey,
    required this.identifier,
  });
}

/// Use case to export the encrypted claims database
class ExportEncryptedClaimsDbUseCase
    extends FutureUseCase<ExportEncryptedClaimsDbParam, String> {
  final CredentialRepository _credentialRepository;

  ExportEncryptedClaimsDbUseCase(this._credentialRepository);

  @override
  Future<String> execute({required ExportEncryptedClaimsDbParam param}) {
    return _credentialRepository.exportEncryptedClaimsDb(
      identifier: param.identifier,
      privateKey: param.privateKey,
    );
  }
}
