import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class UpdateClaimParam {
  final String id;
  final Map<String, dynamic> data;

  UpdateClaimParam(this.id, this.data);
}

class UpdateClaimUseCase extends FutureUseCase<UpdateClaimParam, ClaimEntity> {
  final CredentialRepository _credentialRepository;

  UpdateClaimUseCase(this._credentialRepository);

  @override
  Future<ClaimEntity> execute({required UpdateClaimParam param}) async {
    return _credentialRepository
        .updateClaim(id: param.id, data: param.data)
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
