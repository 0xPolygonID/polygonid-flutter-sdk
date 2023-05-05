import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import '../../../iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import '../entities/claim_entity.dart';
import '../../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart';

class SaveClaimsParam {
  final List<ClaimEntity> claims;
  final String genesisDid;
  //final BigInt profileNonce;
  final String privateKey;

  SaveClaimsParam({
    required this.claims,
    required this.genesisDid,
    //required this.profileNonce,
    required this.privateKey,
  });
}

class SaveClaimsUseCase
    extends FutureUseCase<SaveClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;

  SaveClaimsUseCase(this._credentialRepository);

  @override
  Future<List<ClaimEntity>> execute({required SaveClaimsParam param}) {
    return _credentialRepository
        .saveClaims(
      claims: param.claims,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    )
        .then((_) {
      logger()
          .i("[SaveClaimsUseCase] All claims have been saved: ${param.claims}");

      return param.claims;
    }).catchError((error) {
      logger().e("[SaveClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
