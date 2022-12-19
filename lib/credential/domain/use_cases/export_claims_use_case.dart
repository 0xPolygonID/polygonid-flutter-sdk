import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

/// Param required to export the claims database
class ExportClaimsParam {
  final String privateKey;
  final String identifier;

  ExportClaimsParam({
    required this.privateKey,
    required this.identifier,
  });
}

/// Use case to export the claims database
class ExportClaimsUseCase
    extends FutureUseCase<ExportClaimsParam, String> {
  final CredentialRepository _credentialRepository;

  ExportClaimsUseCase(this._credentialRepository);

  @override
  Future<String> execute({required ExportClaimsParam param}) {
    return _credentialRepository.exportClaims(
      identifier: param.identifier,
      privateKey: param.privateKey,
    );
  }
}
