import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

/// Param required to export the identity database
class ExportIdentityParam {
  final String privateKey;
  final String did;

  ExportIdentityParam({
    required this.privateKey,
    required this.did,
  });
}

/// Use case to export the claims database
class ExportIdentityUseCase extends FutureUseCase<ExportIdentityParam, String> {
  final IdentityRepository _identityRepository;

  ExportIdentityUseCase(this._identityRepository);

  @override
  Future<String> execute({required ExportIdentityParam param}) {
    return _identityRepository.exportIdentity(
      did: param.did,
      privateKey: param.privateKey,
    );
  }
}
