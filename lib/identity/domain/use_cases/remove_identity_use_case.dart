import 'package:polygonid_flutter_sdk/identity/domain/use_cases/remove_identity_state_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../repositories/identity_repository.dart';
import 'get_profiles_use_case.dart';

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
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;

  RemoveIdentityUseCase(this._identityRepository, this._getProfilesUseCase,
      this._removeIdentityStateUseCase, this._removeAllClaimsUseCase);

  @override
  Future<void> execute({required RemoveIdentityParam param}) async {
    try {
      Map<int, String> profilesMap =
          await _getProfilesUseCase.execute(param: param.genesisDid);

      // remove identity state and claims for each profile did
      if (profilesMap != null) {
        for (String profileDid in profilesMap.values) {
          await _removeIdentityStateUseCase.execute(
              param: RemoveIdentityStateParam(
                  did: profileDid, privateKey: param.privateKey));

          await _removeAllClaimsUseCase.execute(
              param: RemoveAllClaimsParam(
                  did: profileDid, privateKey: param.privateKey));
        }
      }

      // Remove genesisId identity state
      await _removeIdentityStateUseCase.execute(
          param: RemoveIdentityStateParam(
              did: param.genesisDid, privateKey: param.privateKey));

      // Remove the identity
      await _identityRepository.removeIdentity(
          genesisDid: param.genesisDid, privateKey: param.privateKey);
    } catch (error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
