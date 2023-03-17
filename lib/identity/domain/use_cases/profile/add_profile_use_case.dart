import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';

class AddProfileParam {
  final int profileNonce;
  final String privateKey;

  AddProfileParam({
    required this.profileNonce,
    required this.privateKey,
  });
}

class AddProfileUseCase extends FutureUseCase<AddProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final CreateIdentityStateUseCase _createIdentityStateUseCase;

  AddProfileUseCase(
    this._getIdentityUseCase,
    this._getDidUseCase,
    this._updateIdentityUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._createProfilesUseCase,
    this._createIdentityStateUseCase,
  );

  @override
  Future<void> execute({required AddProfileParam param}) async {
    if (param.profileNonce > 0) {
      var genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey));
      var identityEntity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: genesisDid, privateKey: param.privateKey));
      if (identityEntity is PrivateIdentityEntity) {
        List<int> profiles = identityEntity.profiles.keys.toList();
        if (profiles.contains(param.profileNonce)) {
          throw ProfileAlreadyExistsException(genesisDid, param.profileNonce);
        } else {
          // Create profile
          var didEntity = await _getDidUseCase.execute(param: genesisDid);
          Map<int, String> newProfiles = await _createProfilesUseCase.execute(
              param: CreateProfilesParam(
                  privateKey: param.privateKey,
                  blockchain: didEntity.blockchain,
                  network: didEntity.network,
                  profiles: [param.profileNonce]));

          String? profileDid = newProfiles[param.profileNonce];
          // create identity state for profile did
          if (profileDid != null) {
            await _createIdentityStateUseCase.execute(
                param: CreateIdentityStateParam(
                    did: profileDid, privateKey: param.privateKey));
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
    } else {
      throw InvalidProfileException(param.profileNonce);
    }
  }
}
