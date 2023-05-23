import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetClaimsParam {
  final List<FilterEntity>? filters;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  GetClaimsParam({
    this.filters,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class GetClaimsUseCase
    extends FutureUseCase<GetClaimsParam, List<ClaimEntity>> {
  final CredentialRepository _credentialRepository;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetClaimsUseCase(this._credentialRepository,
      this._checkProfileAndDidCurrentEnvUseCase, this._getIdentityUseCase);

  @override
  Future<List<ClaimEntity>> execute({required GetClaimsParam param}) {
    return _checkProfileAndDidCurrentEnvUseCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: param.genesisDid,
                privateKey: param.privateKey,
                profileNonce: param.profileNonce))
        .then((_) => _credentialRepository.getClaims(
            filters: param.filters,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey))
        .then((claims) {
      logger().i("[GetClaimsUseCase] Claims: $claims");
      return claims;
    }).catchError((error) {
      logger().e("[GetClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
