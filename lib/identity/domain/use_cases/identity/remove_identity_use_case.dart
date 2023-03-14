import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../../repositories/identity_repository.dart';
import '../profile/get_profiles_use_case.dart';

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

  RemoveIdentityUseCase(
      this._identityRepository,
      this._getProfilesUseCase,
      this._removeProfileUseCase,
      this._removeIdentityStateUseCase,
      this._removeAllClaimsUseCase);

  @override
  Future<void> execute({required RemoveIdentityParam param}) async {
    try {
      Map<int, String> profilesMap =
          await _getProfilesUseCase.execute(param: param.genesisDid);

      // remove identity state and claims for each profile did
      if (profilesMap != null) {
        for (int profileNonce in profilesMap.keys) {
          await _removeProfileUseCase.execute(
              param: RemoveProfileParam(
                  profileNonce: profileNonce,
                  genesisDid: param.genesisDid,
                  privateKey: param.privateKey));
        }
      } else {
        // Remove genesisId identity state and claims
        await _removeIdentityStateUseCase.execute(
            param: RemoveIdentityStateParam(
                did: param.genesisDid, privateKey: param.privateKey));

        await _removeAllClaimsUseCase.execute(
            param: RemoveAllClaimsParam(
                did: param.genesisDid, privateKey: param.privateKey));
      }

      // Remove the identity
      await _identityRepository.removeIdentity(genesisDid: param.genesisDid);
    } catch (error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
