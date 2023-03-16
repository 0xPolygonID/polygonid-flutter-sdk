import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../entities/did_entity.dart';
import '../../entities/identity_entity.dart';
import '../../repositories/identity_repository.dart';
import '../get_did_identifier_use_case.dart';
import '../get_did_use_case.dart';
import '../identity/get_identities_use_case.dart';
import '../smt/remove_identity_state_use_case.dart';
import 'create_profiles_use_case.dart';

class RemoveProfileParam {
  final int profileNonce;
  final String genesisDid;
  final String privateKey;

  RemoveProfileParam({
    required this.profileNonce,
    required this.genesisDid,
    required this.privateKey,
  });
}

class RemoveProfileUseCase extends FutureUseCase<RemoveProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;

  RemoveProfileUseCase(
      this._getIdentityUseCase,
      this._getDidUseCase,
      this._createProfilesUseCase,
      this._removeIdentityStateUseCase,
      this._removeAllClaimsUseCase,
      this._updateIdentityUseCase);

  @override
  Future<void> execute({required RemoveProfileParam param}) async {
    if (param.profileNonce > 0) {
      var identityEntity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.genesisDid, privateKey: param.privateKey));
      if (identityEntity is PrivateIdentityEntity) {
        List<int> profiles = identityEntity.profiles.keys.toList();
        if (!profiles.contains(param.profileNonce)) {
          throw UnknownProfileException(param.profileNonce);
        } else {
          var didEntity = await _getDidUseCase.execute(param: param.genesisDid);

          Map<int, String> newProfiles = await _createProfilesUseCase.execute(
              param: CreateProfilesParam(
                  privateKey: param.privateKey,
                  blockchain: didEntity.blockchain,
                  network: didEntity.network,
                  profiles: [param.profileNonce]));

          String? profileDid = newProfiles[param.profileNonce];
          // remove identity state and claims for profile did
          if (profileDid != null) {
            await _removeIdentityStateUseCase.execute(
                param: RemoveIdentityStateParam(
                    did: profileDid, privateKey: param.privateKey));

            await _removeAllClaimsUseCase.execute(
                param: RemoveAllClaimsParam(
                    did: profileDid, privateKey: param.privateKey));

            profiles.remove(param.profileNonce);
          } else {
            throw UnknownProfileException(param.profileNonce);
          }

          await _updateIdentityUseCase.execute(
              param: UpdateIdentityParam(
                  privateKey: param.privateKey,
                  blockchain: didEntity.blockchain,
                  network: didEntity.network,
                  profiles: profiles));
        }
      } else {
        throw InvalidPrivateKeyException(param.privateKey);
      }
    } else {
      String errorMsg = "Invalid profile";
      if (param.profileNonce == 0) {
        errorMsg = "Genesis profile can't be modified";
      } else if (param.profileNonce < 0) {
        errorMsg = "Profile nonce can't be negative";
      }
      throw InvalidProfileException(param.profileNonce, errorMsg);
    }
  }
}
