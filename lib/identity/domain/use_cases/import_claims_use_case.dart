import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

/// Param required to import the identity database
class ImportIdentityParam {
  final String privateKey;
  final String did;
  final String encryptedClaimsDb;

  ImportIdentityParam({
    required this.privateKey,
    required this.did,
    required this.encryptedClaimsDb,
  });
}

/// Use case to import the encrypted identity database
class ImportIdentityUseCase extends FutureUseCase<ImportIdentityParam, void> {
  final IdentityRepository _identityRepository;

  ImportIdentityUseCase(this._identityRepository);

  @override
  Future<void> execute({required ImportIdentityParam param}) {
    return _identityRepository.importIdentity(
      did: param.did,
      privateKey: param.privateKey,
      encryptedDb: param.encryptedClaimsDb,
    );
  }
}
