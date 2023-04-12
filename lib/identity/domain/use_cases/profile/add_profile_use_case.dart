import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';

class AddProfileParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  AddProfileParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class AddProfileUseCase extends FutureUseCase<AddProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;

  AddProfileUseCase(
    this._getIdentityUseCase,
    this._updateIdentityUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._createProfilesUseCase,
  );

  @override
  Future<void> execute({required AddProfileParam param}) async {
    await _checkProfileAndDidCurrentEnvUseCase.execute(
        param: CheckProfileAndDidCurrentEnvParam(
            did: param.genesisDid,
            profileNonce: param.profileNonce,
            privateKey: param.privateKey,
            excludeGenesisProfile: true));
    var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: param.genesisDid, privateKey: param.privateKey));

    if (identityEntity is PrivateIdentityEntity) {
      List<BigInt> profiles = identityEntity.profiles.keys.toList();
      if (profiles.contains(param.profileNonce)) {
        throw ProfileAlreadyExistsException(
            param.genesisDid, param.profileNonce);
      } else {
        // Create profile
        Map<BigInt, String> newProfiles = await _createProfilesUseCase.execute(
            param: CreateProfilesParam(
                privateKey: param.privateKey, profiles: [param.profileNonce]));

        String? profileDid = newProfiles[param.profileNonce];
        if (profileDid != null) {
          profiles.add(param.profileNonce);
        } else {
          throw UnknownProfileException(param.profileNonce);
        }

        // Update Identity
        await _updateIdentityUseCase.execute(
            param: UpdateIdentityParam(
                privateKey: param.privateKey, profiles: profiles));
      }
    } else {
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
