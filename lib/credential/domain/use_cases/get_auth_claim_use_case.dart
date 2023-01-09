import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/use_case.dart';

class GetAuthClaimUseCase extends FutureUseCase<List<String>, List<String>> {
  final CredentialRepository _credentialRepository;

  GetAuthClaimUseCase(this._credentialRepository);

  @override
  Future<List<String>> execute({required List<String> param}) {
    return _credentialRepository
        .getAuthClaim(publicKey: param)
        .then((authClaim) {
      logger().i("[GetAuthClaimUseCase] AuthClaim: $authClaim");

      return authClaim;
    }).catchError((error) {
      logger().e("[GetAuthClaimUseCase] Error: $error");

      throw error;
    });
  }
}
