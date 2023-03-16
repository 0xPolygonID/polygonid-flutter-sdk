import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../entities/did_entity.dart';
import '../../entities/identity_entity.dart';
import '../../repositories/identity_repository.dart';
import '../smt/create_identity_state_use_case.dart';
import '../get_did_identifier_use_case.dart';
import '../get_did_use_case.dart';
import '../identity/get_identities_use_case.dart';
import 'create_profiles_use_case.dart';

class AddProfileParam {
  final int profileNonce;
  final String genesisDid;
  final String privateKey;

  AddProfileParam({
    required this.profileNonce,
    required this.genesisDid,
    required this.privateKey,
  });
}

class AddProfileUseCase extends FutureUseCase<AddProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final CreateIdentityStateUseCase _createIdentityStateUseCase;

  AddProfileUseCase(
      this._getIdentityUseCase,
      this._getDidUseCase,
      this._updateIdentityUseCase,
      this._createProfilesUseCase,
      this._createIdentityStateUseCase);

  @override
  Future<void> execute({required AddProfileParam param}) async {
    if (param.profileNonce > 0) {
      var identityEntity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.genesisDid, privateKey: param.privateKey));
      if (identityEntity is PrivateIdentityEntity) {
        List<int> profiles = identityEntity.profiles.keys.toList();
        if (profiles.contains(param.profileNonce)) {
          throw ProfileAlreadyExistsException(
              param.genesisDid, param.profileNonce);
        } else {
          // Create profile
          var didEntity = await _getDidUseCase.execute(param: param.genesisDid);
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
