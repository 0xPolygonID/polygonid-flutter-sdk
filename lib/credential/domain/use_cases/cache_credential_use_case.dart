import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class CacheCredentialParam {
  final String credential;
  final String? config;

  CacheCredentialParam({
    required this.credential,
    this.config,
  });
}

class CacheCredentialUseCase
    extends FutureUseCase<CacheCredentialParam, String?> {
  final CredentialRepository _credentialRepository;

  CacheCredentialUseCase(
    this._credentialRepository,
  );

  @override
  Future<String?> execute({
    required CacheCredentialParam param,
  }) {
    return _credentialRepository.cacheCredential(
      credential: param.credential,
      config: param.config,
    );
  }
}
