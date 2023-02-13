import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/use_cases/get_auth_claim_use_case.dart';
import '../repositories/identity_repository.dart';
import 'get_public_keys_use_case.dart';

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
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;

  GetDidIdentifierUseCase(
      this._identityRepository, this._getPublicKeysUseCase, this._getAuthClaimUseCase);

  @override
  Future<String> execute({required GetDidIdentifierParam param}) {
    return _getPublicKeysUseCase
        .execute(param: param.privateKey).then((publicKeys) => _getAuthClaimUseCase.execute(param: publicKeys))
        .then((authClaim) => _identityRepository.getDidIdentifier(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network,
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
