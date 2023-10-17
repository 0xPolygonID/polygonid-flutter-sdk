import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

class RemoveProfileParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  RemoveProfileParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class RemoveProfileUseCase extends FutureUseCase<RemoveProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final StacktraceManager _stacktraceManager;

  RemoveProfileUseCase(
    this._getIdentityUseCase,
    this._updateIdentityUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._createProfilesUseCase,
    this._removeIdentityStateUseCase,
    this._removeAllClaimsUseCase,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required RemoveProfileParam param}) async {
    await _checkProfileAndDidCurrentEnvUseCase.execute(
      param: CheckProfileAndDidCurrentEnvParam(
        did: param.genesisDid,
        privateKey: param.privateKey,
        profileNonce: BigInt.zero,
        excludeGenesisProfile: true,
      ),
    );
    var identityEntity = await _getIdentityUseCase.execute(
      param: GetIdentityParam(
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ),
    );

    if (identityEntity is PrivateIdentityEntity) {
      Map<BigInt, String> profiles = identityEntity.profiles;
      if (!profiles.containsKey(param.profileNonce)) {
        _stacktraceManager.addTrace(
            "[RemoveProfileUseCase] UnknownProfileException - profileNonce: ${param.profileNonce}");
        _stacktraceManager.addError(
            "[RemoveProfileUseCase] UnknownProfileException - profileNonce: ${param.profileNonce}");
        throw UnknownProfileException(param.profileNonce);
      } else {
        Map<BigInt, String> newProfiles = await _createProfilesUseCase.execute(
            param: CreateProfilesParam(
                privateKey: param.privateKey, profiles: [param.profileNonce]));

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
          _stacktraceManager.addTrace(
              "[RemoveProfileUseCase] UnknownProfileException - profileNonce: ${param.profileNonce}");
          _stacktraceManager.addError(
              "[RemoveProfileUseCase] UnknownProfileException - profileNonce: ${param.profileNonce}");
          throw UnknownProfileException(param.profileNonce);
        }

        await _updateIdentityUseCase.execute(
            param: UpdateIdentityParam(
          privateKey: param.privateKey,
          genesisDid: param.genesisDid,
          profiles: profiles,
        ));
      }
    } else {
      _stacktraceManager.addTrace(
          "[RemoveProfileUseCase] InvalidPrivateKeyException - privateKey: ${param.privateKey}");
      _stacktraceManager.addError(
          "[RemoveProfileUseCase] InvalidPrivateKeyException - privateKey: ${param.privateKey}");
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
