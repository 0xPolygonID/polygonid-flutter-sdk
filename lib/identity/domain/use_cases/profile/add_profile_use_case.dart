import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
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
  final String? existingProfileDid;

  AddProfileParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    this.existingProfileDid,
  });
}

class AddProfileUseCase extends FutureUseCase<AddProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final LibPolygonIdCoreIdentityDataSource _libPolygonIdCoreIdentityDataSource;
  final StacktraceManager _stacktraceManager;

  AddProfileUseCase(
    this._getIdentityUseCase,
    this._updateIdentityUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._createProfilesUseCase,
    this._libPolygonIdCoreIdentityDataSource,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required AddProfileParam param}) async {
    var existingProfileDid = param.existingProfileDid;
    if (existingProfileDid == null) {
      await _checkProfileAndDidCurrentEnvUseCase.execute(
        param: CheckProfileAndDidCurrentEnvParam(
          did: param.genesisDid,
          profileNonce: param.profileNonce,
          privateKey: param.privateKey,
          excludeGenesisProfile: true,
        ),
      );
    }

    final identityEntity = await _getIdentityUseCase.execute(
      param: GetIdentityParam(
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ),
    );

    if (identityEntity is! PrivateIdentityEntity) {
      // Private key missing
      _stacktraceManager
          .addTrace('InvalidPrivateKeyException: ${param.privateKey}');
      _stacktraceManager
          .addError('InvalidPrivateKeyException: ${param.privateKey}');
      throw InvalidPrivateKeyException(param.privateKey);
    }

    Map<BigInt, String> profiles = identityEntity.profiles;
    if (profiles.containsKey(param.profileNonce)) {
      // Profile already exists
      _stacktraceManager
          .addTrace('ProfileAlreadyExistsException: ${param.profileNonce}');
      _stacktraceManager
          .addError('ProfileAlreadyExistsException: ${param.profileNonce}');
      throw ProfileAlreadyExistsException(param.genesisDid, param.profileNonce);
    }

    String profileDid;
    if (existingProfileDid == null) {
      // Create new profile for selected network
      Map<BigInt, String> newProfiles = await _createProfilesUseCase.execute(
        param: CreateProfilesParam(
          privateKey: param.privateKey,
          profiles: [param.profileNonce],
        ),
      );

      final newProfileDid = newProfiles[param.profileNonce];
      if (newProfileDid == null) {
        _stacktraceManager
            .addTrace('UnknownProfileException: ${param.profileNonce}');
        _stacktraceManager
            .addError('UnknownProfileException: ${param.profileNonce}');
        throw UnknownProfileException(param.profileNonce);
      }

      profileDid = newProfileDid;
    } else {
      // Check if existing profile is valid. Uses network and blockchain from genesisDid.
      final genesisDid = param.genesisDid;
      final profileNonce = param.profileNonce;
      final calculatedDid = _libPolygonIdCoreIdentityDataSource
          .calculateProfileId(genesisDid, profileNonce);

      if (existingProfileDid != calculatedDid) {
        _stacktraceManager.addTrace(
            'InvalidProfileException: $existingProfileDid != $calculatedDid');
        _stacktraceManager.addError(
            'InvalidProfileException: $existingProfileDid != $calculatedDid');
        throw InvalidProfileException(profileNonce);
      }

      profileDid = existingProfileDid;
    }

    profiles[param.profileNonce] = profileDid;

    // Update Identity
    await _updateIdentityUseCase.execute(
        param: UpdateIdentityParam(
      privateKey: param.privateKey,
      genesisDid: param.genesisDid,
      profiles: profiles,
    ));
  }
}
