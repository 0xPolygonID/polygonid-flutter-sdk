import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

class RemoveProfileParam {
  final int profileNonce;
  final String privateKey;

  RemoveProfileParam({
    required this.profileNonce,
    required this.privateKey,
  });
}

class RemoveProfileUseCase extends FutureUseCase<RemoveProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;

  RemoveProfileUseCase(
    this._getIdentityUseCase,
    this._getDidUseCase,
    this._updateIdentityUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._createProfilesUseCase,
    this._removeIdentityStateUseCase,
    this._removeAllClaimsUseCase,
  );

  @override
  Future<void> execute({required RemoveProfileParam param}) async {
    var genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
        param: GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey));
    var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: genesisDid, privateKey: param.privateKey));
    if (identityEntity is PrivateIdentityEntity) {
      List<int> profiles = identityEntity.profiles.keys.toList();
      if (!profiles.contains(param.profileNonce)) {
        throw UnknownProfileException(param.profileNonce);
      } else {
        var didEntity = await _getDidUseCase.execute(param: genesisDid);

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
                privateKey: param.privateKey, profiles: profiles));
      }
    } else {
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
