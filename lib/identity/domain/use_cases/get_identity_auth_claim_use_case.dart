import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

/// Get the public keys as List<String> associated with the @param String privateKey
class GetIdentityAuthClaimUseCase extends FutureUseCase<String, List<String>> {
  final IdentityRepository _identityRepository;
  final GetAuthClaimUseCase _getAuthClaimUseCase;

  GetIdentityAuthClaimUseCase(
    this._identityRepository,
    this._getAuthClaimUseCase,
  );

  @override
  Future<List<String>> execute({required String param}) {
    return _identityRepository
        .getPublicKeys(privateKey: param)
        .then((pubKeys) => _getAuthClaimUseCase.execute(param: pubKeys))
        .then((authClaim) {
      logger().i("[GetIdentityAuthClaimUseCase] AuthClaim is $authClaim");

      return authClaim;
    }).catchError((error) {
      logger().e("[GetIdentityAuthClaimUseCase] Error: $error");

      throw error;
    });
  }
}
