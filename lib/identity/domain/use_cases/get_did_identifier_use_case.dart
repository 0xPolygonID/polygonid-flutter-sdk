import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final int profileNonce;

  GetDidIdentifierParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    this.profileNonce = 0,
  });
}

class GetDidIdentifierUseCase
    extends FutureUseCase<GetDidIdentifierParam, String> {
  final IdentityRepository _identityRepository;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;

  GetDidIdentifierUseCase(
      this._identityRepository, this._getIdentityAuthClaimUseCase);

  @override
  Future<String> execute({required GetDidIdentifierParam param}) {
    return _getIdentityAuthClaimUseCase
        .execute(param: param.privateKey)
        .then((authClaim) => _identityRepository.getDidIdentifier(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network,
            authClaim: authClaim,
            profileNonce: param.profileNonce))
        .then((did) {
      logger().i("[GetDidIdentifierUseCase] did: $did");

      return did;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
