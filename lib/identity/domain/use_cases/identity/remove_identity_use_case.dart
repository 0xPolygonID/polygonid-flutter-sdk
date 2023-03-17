import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

class RemoveIdentityUseCase extends FutureUseCase<String, void> {
  final IdentityRepository _identityRepository;
  final GetProfilesUseCase _getProfilesUseCase;
  final RemoveProfileUseCase _removeProfileUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  RemoveIdentityUseCase(
    this._identityRepository,
    this._getProfilesUseCase,
    this._removeProfileUseCase,
    this._removeIdentityStateUseCase,
    this._removeAllClaimsUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<void> execute({required String param}) async {
    try {
      String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(privateKey: param));

      Map<int, String> profilesMap =
          await _getProfilesUseCase.execute(param: genesisDid);

      // remove identity state and claims for each profile did
      if (profilesMap.isNotEmpty) {
        for (int profileNonce in profilesMap.keys) {
          if (profileNonce > 0) {
            await _removeProfileUseCase.execute(
                param: RemoveProfileParam(
                    profileNonce: profileNonce, privateKey: param));
          }
        }
      }
      // Remove genesisId identity state and claims
      await _removeIdentityStateUseCase.execute(
          param: RemoveIdentityStateParam(did: genesisDid, privateKey: param));

      await _removeAllClaimsUseCase.execute(
          param: RemoveAllClaimsParam(did: genesisDid, privateKey: param));

      // Remove the identity
      await _identityRepository.removeIdentity(genesisDid: genesisDid);
    } catch (error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
