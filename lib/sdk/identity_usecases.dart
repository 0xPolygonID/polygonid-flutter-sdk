import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_state_roots_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_latest_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_new_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/backup_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/check_identity_validity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identities_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/remove_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/restore_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/restore_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

@injectable
class IdentityUsecases {
  //IDENTITY
  final AddIdentityUseCase _addIdentityUseCase;
  final AddNewIdentityUseCase _addNewIdentityUseCase;
  final BackupIdentityUseCase _backupIdentityUseCase;
  final CheckIdentityValidityUseCase _checkIdentityValidityUseCase;
  final CreateIdentityUseCase _createIdentityUseCase;
  final GetIdentitiesUseCase _getIdentitiesUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final GetPrivateKeyUseCase _getPrivateKeyUseCase;
  final RemoveIdentityUseCase _removeIdentityUseCase;
  final RestoreIdentityUseCase _restoreIdentityUseCase;
  final SignMessageUseCase _signMessageUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;

  //PROFILE
  final AddProfileUseCase _addProfileUseCase;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final CreateProfilesUseCase _createProfilesUseCase;
  final GetProfilesUseCase _getProfilesUseCase;
  final RemoveProfileUseCase _removeProfileUseCase;
  final RestoreProfilesUseCase _restoreProfilesUseCase;

  //SPARSE MERKLE TREE
  final CreateIdentityStateUseCase _createIdentityStateUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;

  //
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;
  final FetchStateRootsUseCase _fetchStateRootsUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetDidUseCase _getDidUseCase;
  final GetGenesisStateUseCase _getGenesisStateUseCase;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;
  final GetLatestStateUseCase _getLatestStateUseCase;
  final GetPublicKeysUseCase _getPublicKeysUseCase;

  IdentityUsecases(
    this._addIdentityUseCase,
    this._addNewIdentityUseCase,
    this._backupIdentityUseCase,
    this._checkIdentityValidityUseCase,
    this._createIdentityUseCase,
    this._getIdentitiesUseCase,
    this._getIdentityUseCase,
    this._getPrivateKeyUseCase,
    this._removeIdentityUseCase,
    this._restoreIdentityUseCase,
    this._signMessageUseCase,
    this._updateIdentityUseCase,
    this._addProfileUseCase,
    this._checkProfileValidityUseCase,
    this._createProfilesUseCase,
    this._getProfilesUseCase,
    this._removeProfileUseCase,
    this._restoreProfilesUseCase,
    this._createIdentityStateUseCase,
    this._removeIdentityStateUseCase,
    this._fetchIdentityStateUseCase,
    this._fetchStateRootsUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._getDidIdentifierUseCase,
    this._getDidUseCase,
    this._getGenesisStateUseCase,
    this._getIdentityAuthClaimUseCase,
    this._getLatestStateUseCase,
    this._getPublicKeysUseCase,
  );

  Future<PrivateIdentityEntity> addIdentity(AddIdentityParam param) {
    return _addIdentityUseCase.execute(param: param);
  }

  Future<PrivateIdentityEntity> addNewIdentity(String? secret) {
    return _addNewIdentityUseCase.execute(param: secret);
  }

  Future<String> backupIdentity(BackupIdentityParam param) {
    return _backupIdentityUseCase.execute(param: param);
  }

  Future<void> checkIdentityValidity(String secret) {
    return _checkIdentityValidityUseCase.execute(param: secret);
  }

  Future<PrivateIdentityEntity> createIdentity(CreateIdentityParam param) {
    return _createIdentityUseCase.execute(param: param);
  }

  Future<List<IdentityEntity>> getIdentities() {
    return _getIdentitiesUseCase.execute(param: null);
  }

  Future<IdentityEntity> getIdentity(GetIdentityParam param) {
    return _getIdentityUseCase.execute(param: param);
  }

  Future<String> getPrivateKey(String secret) {
    return _getPrivateKeyUseCase.execute(param: secret);
  }

  Future<void> removeIdentity(RemoveIdentityParam param) {
    return _removeIdentityUseCase.execute(param: param);
  }

  Future<PrivateIdentityEntity> restoreIdentity(RestoreIdentityParam param) {
    return _restoreIdentityUseCase.execute(param: param);
  }

  Future<String> signMessage(SignMessageParam param) {
    return _signMessageUseCase.execute(param: param);
  }

  Future<PrivateIdentityEntity> updateIdentity(UpdateIdentityParam param) {
    return _updateIdentityUseCase.execute(param: param);
  }

  ///PROFILE
  Future<void> addProfile(AddProfileParam param) {
    return _addProfileUseCase.execute(param: param);
  }

  Future<void> checkProfileValidity(CheckProfileValidityParam param) {
    return _checkProfileValidityUseCase.execute(param: param);
  }

  Future<Map<BigInt, String>> createProfiles(CreateProfilesParam param) {
    return _createProfilesUseCase.execute(param: param);
  }

  Future<Map<BigInt, String>> getProfiles(GetProfilesParam param) {
    return _getProfilesUseCase.execute(param: param);
  }

  Future<void> removeProfile(RemoveProfileParam param) {
    return _removeProfileUseCase.execute(param: param);
  }

  Future<void> restoreProfiles(RestoreProfilesParam param) {
    return _restoreProfilesUseCase.execute(param: param);
  }

  ///SPARSE MERKLE TREE
  Future<void> createIdentityState(CreateIdentityStateParam param) {
    return _createIdentityStateUseCase.execute(param: param);
  }

  Future<void> removeIdentityState(RemoveIdentityStateParam param) {
    return _removeIdentityStateUseCase.execute(param: param);
  }

  Future<String> fetchIdentityState(String did) {
    return _fetchIdentityStateUseCase.execute(param: did);
  }

  Future<RhsNodeEntity> fetchStateRoots(FetchStateRootsParam param) {
    return _fetchStateRootsUseCase.execute(param: param);
  }

  Future<String> getCurrentEnvDidIdentifier(
      GetCurrentEnvDidIdentifierParam param) {
    return _getCurrentEnvDidIdentifierUseCase.execute(param: param);
  }

  Future<String> getDidIdentifier(GetDidIdentifierParam param) {
    return _getDidIdentifierUseCase.execute(param: param);
  }

  Future<DidEntity> getDid(String did) {
    return _getDidUseCase.execute(param: did);
  }

  Future<TreeStateEntity> getGenesisState(String privateKey) {
    return _getGenesisStateUseCase.execute(param: privateKey);
  }

  Future<List<String>> getIdentityAuthClaim(String privateKey) {
    return _getIdentityAuthClaimUseCase.execute(param: privateKey);
  }

  Future<Map<String, dynamic>> getLatestState(GetLatestStateParam param) {
    return _getLatestStateUseCase.execute(param: param);
  }

  Future<List<String>> getPublicKeys(String privateKey) {
    return _getPublicKeysUseCase.execute(param: privateKey);
  }
}
