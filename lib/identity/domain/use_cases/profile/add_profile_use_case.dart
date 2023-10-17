import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
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
  final StacktraceManager _stacktraceManager;

  AddProfileUseCase(
    this._getIdentityUseCase,
    this._updateIdentityUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._createProfilesUseCase,
    this._stacktraceManager,
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
      Map<BigInt, String> profiles = identityEntity.profiles;
      if (profiles.containsKey(param.profileNonce)) {
        _stacktraceManager
            .addTrace('ProfileAlreadyExistsException: ${param.profileNonce}');
        _stacktraceManager
            .addError('ProfileAlreadyExistsException: ${param.profileNonce}');
        throw ProfileAlreadyExistsException(
            param.genesisDid, param.profileNonce);
      } else {
        // Create profile
        Map<BigInt, String> newProfiles = await _createProfilesUseCase.execute(
            param: CreateProfilesParam(
                privateKey: param.privateKey, profiles: [param.profileNonce]));

        String? profileDid = newProfiles[param.profileNonce];
        if (profileDid != null) {
          profiles[param.profileNonce] = profileDid;
        } else {
          _stacktraceManager
              .addTrace('UnknownProfileException: ${param.profileNonce}');
          _stacktraceManager
              .addError('UnknownProfileException: ${param.profileNonce}');
          throw UnknownProfileException(param.profileNonce);
        }

        // Update Identity
        await _updateIdentityUseCase.execute(
            param: UpdateIdentityParam(
          privateKey: param.privateKey,
          genesisDid: param.genesisDid,
          profiles: profiles,
        ));
      }
    } else {
      _stacktraceManager
          .addTrace('InvalidPrivateKeyException: ${param.privateKey}');
      _stacktraceManager
          .addError('InvalidPrivateKeyException: ${param.privateKey}');
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
