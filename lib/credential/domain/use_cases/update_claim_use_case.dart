import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class UpdateClaimParam {
  final String id;
  final String? issuer;
  final String did;
  final ClaimState? state;
  final String? expiration;
  final String? type;
  final Map<String, dynamic>? data;
  final String privateKey;

  UpdateClaimParam({
    required this.id,
    this.issuer,
    required this.did,
    this.state,
    this.expiration,
    this.type,
    this.data,
    required this.privateKey,
  });
}

class UpdateClaimUseCase extends FutureUseCase<UpdateClaimParam, ClaimEntity> {
  final CredentialRepository _credentialRepository;

  UpdateClaimUseCase(this._credentialRepository);

  @override
  Future<ClaimEntity> execute({required UpdateClaimParam param}) async {
    /// Get the [ClaimEntity] associated with the [param.id]
    /// If found, we update the info with the corresponding [param]
    /// then update in storage
    return _credentialRepository
        .getClaim(
            claimId: param.id, did: param.did, privateKey: param.privateKey)
        .then((claim) => ClaimEntity(
            id: param.id,
            issuer: param.issuer ?? claim.issuer,
            did: param.did,
            state: param.state ?? claim.state,
            expiration: param.expiration ?? claim.expiration,
            type: param.type ?? claim.type,
            info: param.data ?? claim.info))
        .then((updated) => _credentialRepository.saveClaims(
            claims: [updated],
            did: param.did,
            privateKey: param.privateKey).then((_) => updated))
        .then((claim) {
      logger().i(
          "[UpdateClaimUseCase] Claim with id ${param.id} has been updated: $claim");

      return claim;
    }).catchError((error) {
      logger().e("[UpdateClaimUseCase] Error: $error");
      throw error;
    });
  }
}
