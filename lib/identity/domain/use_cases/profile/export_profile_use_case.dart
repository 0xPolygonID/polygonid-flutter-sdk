import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

/// Param required to export the profile database
class ExportProfileParam {
  final String privateKey;
  final String did;

  ExportProfileParam({
    required this.privateKey,
    required this.did,
  });
}

/// Use case to export the encrypted profile database
class ExportProfileUseCase extends FutureUseCase<ExportProfileParam, String> {
  final IdentityRepository _identityRepository;

  ExportProfileUseCase(this._identityRepository);

  @override
  Future<String> execute({required ExportProfileParam param}) {
    return _identityRepository.exportIdentity(
      did: param.did,
      privateKey: param.privateKey,
    );
  }
}
