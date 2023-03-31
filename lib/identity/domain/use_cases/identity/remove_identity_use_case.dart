import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

class RemoveIdentityParam {
  final String genesisDid;
  final String privateKey;

  RemoveIdentityParam({
    required this.genesisDid,
    required this.privateKey,
  });
}

class RemoveIdentityUseCase extends FutureUseCase<RemoveIdentityParam, void> {
  final IdentityRepository _identityRepository;
  final GetProfilesUseCase _getProfilesUseCase;
  final RemoveProfileUseCase _removeProfileUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;

  RemoveIdentityUseCase(
    this._identityRepository,
    this._getProfilesUseCase,
    this._removeProfileUseCase,
    this._removeIdentityStateUseCase,
    this._removeAllClaimsUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
  );

  @override
  Future<void> execute({required RemoveIdentityParam param}) async {
    try {
      await _checkProfileAndDidCurrentEnvUseCase.execute(
          param: CheckProfileAndDidCurrentEnvParam(
              did: param.genesisDid, privateKey: param.privateKey));

      Map<int, String> profilesMap = await _getProfilesUseCase.execute(
          param: GetProfilesParam(
              genesisDid: param.genesisDid, privateKey: param.privateKey));

      // remove identity state and claims for each profile did
      if (profilesMap.isNotEmpty) {
        for (int profileNonce in profilesMap.keys) {
          if (profileNonce > 0) {
            await _removeProfileUseCase.execute(
                param: RemoveProfileParam(
                    genesisDid: param.genesisDid,
                    profileNonce: profileNonce,
                    privateKey: param.privateKey));
          }
        }
      }
      // Remove genesisId identity state and claims
      await _removeIdentityStateUseCase.execute(
          param: RemoveIdentityStateParam(
              did: param.genesisDid, privateKey: param.privateKey));

      await _removeAllClaimsUseCase.execute(
          param: RemoveAllClaimsParam(
              did: param.genesisDid, privateKey: param.privateKey));

      // Remove the identity
      await _identityRepository.removeIdentity(genesisDid: param.genesisDid);
    } catch (error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
