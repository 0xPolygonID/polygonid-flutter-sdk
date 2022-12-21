import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';

import '../../../common/domain/use_case.dart';

class GetAuthClaimUseCase extends FutureUseCase<IdentityEntity, String> {
  final CredentialRepository _credentialRepository;

  GetAuthClaimUseCase(this._credentialRepository);

  @override
  Future<String> execute({required IdentityEntity param}) {
    return _credentialRepository
        .getAuthClaim(identity: param)
        .then((authClaim) {
      logger().i("[GetAuthClaimUseCase] AuthClaim: $authClaim");

      return authClaim;
    }).catchError((error) {
      logger().e("[GetAuthClaimUseCase] Error: $error");

      throw error;
    });
  }
}
