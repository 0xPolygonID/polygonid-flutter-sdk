// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i66;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i93;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i73;
import 'package:sembast/sembast.dart' as _i14;
import 'package:web3dart/web3dart.dart' as _i91;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i21;
import '../../common/data/data_sources/package_info_datasource.dart' as _i72;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i62;
import '../../common/data/repositories/config_repository_impl.dart' as _i117;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i74;
import '../../common/domain/repositories/config_repository.dart' as _i33;
import '../../common/domain/repositories/package_info_repository.dart' as _i44;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i32;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i43;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i102;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i75;
import '../../credential/data/credential_repository_impl.dart' as _i136;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i127;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i131;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i92;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i13;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i11;
import '../../credential/data/mappers/claim_mapper.dart' as _i116;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i12;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i25;
import '../../credential/data/mappers/filters_mapper.dart' as _i26;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i53;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i99;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i30;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i29;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i121;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i154;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i96;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i97;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i101;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i107;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i76;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i128;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i94;
import '../../iden3comm/data/data_sources/storage_connection_data_source.dart'
    as _i16;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i115;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/connection_mapper.dart' as _i15;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i124;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i85;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i126;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i139;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i50;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i28;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i162;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i142;
import '../../iden3comm/domain/use_cases/connection/get_connections_use_case.dart'
    as _i155;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i153;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i27;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i144;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i145;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i34;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i122;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i156;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i157;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i36;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i37;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i46;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i47;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i49;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i77;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i19;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i129;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i65;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i95;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i90;
import '../../identity/data/data_sources/smt_data_source.dart' as _i134;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i57;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i56;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i108;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i20;
import '../../identity/data/mappers/hash_mapper.dart' as _i51;
import '../../identity/data/mappers/hex_mapper.dart' as _i52;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i55;
import '../../identity/data/mappers/node_mapper.dart' as _i132;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i69;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i70;
import '../../identity/data/mappers/node_type_mapper.dart' as _i71;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i80;
import '../../identity/data/mappers/private_key_mapper.dart' as _i81;
import '../../identity/data/mappers/q_mapper.dart' as _i89;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i133;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i100;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i104;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i105;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i106;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i140;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i135;
import '../../identity/domain/repositories/identity_repository.dart' as _i23;
import '../../identity/domain/repositories/smt_repository.dart' as _i42;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i119;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i24;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i120;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i146;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i137;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i31;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i123;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i39;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart' as _i41;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i48;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i159;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i160;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i149;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i150;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i151;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i38;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i138;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i45;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i167;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i166;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i103;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i6;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i152;
import '../../identity/domain/use_cases/profile/export_profile_use_case.dart'
    as _i22;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/profile/import_profile_use_case.dart'
    as _i58;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i118;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i98;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i78;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i8;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i130;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i67;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i82;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i88;
import '../../proof/data/data_sources/witness_data_source.dart' as _i110;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i125;
import '../../proof/data/mappers/jwz_mapper.dart' as _i60;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i61;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i68;
import '../../proof/data/mappers/proof_mapper.dart' as _i84;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i141;
import '../../proof/domain/repositories/proof_repository.dart' as _i10;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart' as _i9;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i18;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i143;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i35;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i40;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i59;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i64;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i86;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i83;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i79;
import '../../proof/libs/prover/prover.dart' as _i87;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i109;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i111;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i112;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i113;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i114;
import '../credential.dart' as _i163;
import '../iden3comm.dart' as _i164;
import '../identity.dart' as _i168;
import '../mappers/iden3_message_type_mapper.dart' as _i54;
import '../proof.dart' as _i148; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthInputsMapper>(() => _i3.AuthInputsMapper());
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.CheckProfileValidityUseCase>(
      () => _i6.CheckProfileValidityUseCase());
  gh.factory<_i7.CircuitTypeMapper>(() => _i7.CircuitTypeMapper());
  gh.factory<_i8.CircuitsDownloadDataSource>(
      () => _i8.CircuitsDownloadDataSource());
  gh.factory<_i9.CircuitsFilesExistUseCase>(
      () => _i9.CircuitsFilesExistUseCase(get<_i10.ProofRepository>()));
  gh.factory<_i11.ClaimInfoMapper>(() => _i11.ClaimInfoMapper());
  gh.factory<_i12.ClaimStateMapper>(() => _i12.ClaimStateMapper());
  gh.factory<_i13.ClaimStoreRefWrapper>(() => _i13.ClaimStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i15.ConnectionMapper>(() => _i15.ConnectionMapper());
  gh.factory<_i16.ConnectionStoreRefWrapper>(() =>
      _i16.ConnectionStoreRefWrapper(
          get<_i14.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'connectionStore')));
  gh.factory<_i17.CreatePathWrapper>(() => _i17.CreatePathWrapper());
  gh.factory<_i17.DestinationPathDataSource>(
      () => _i17.DestinationPathDataSource(get<_i17.CreatePathWrapper>()));
  gh.factory<_i18.DownloadCircuitsUseCase>(() => _i18.DownloadCircuitsUseCase(
        get<_i10.ProofRepository>(),
        get<_i9.CircuitsFilesExistUseCase>(),
      ));
  gh.factory<_i19.EncryptionDbDataSource>(() => _i19.EncryptionDbDataSource());
  gh.factory<_i20.EncryptionKeyMapper>(() => _i20.EncryptionKeyMapper());
  gh.factory<_i21.EnvMapper>(() => _i21.EnvMapper());
  gh.factory<_i22.ExportProfileUseCase>(
      () => _i22.ExportProfileUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i24.FetchStateRootsUseCase>(
      () => _i24.FetchStateRootsUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i25.FilterMapper>(() => _i25.FilterMapper());
  gh.factory<_i26.FiltersMapper>(
      () => _i26.FiltersMapper(get<_i25.FilterMapper>()));
  gh.factory<_i27.GetAuthChallengeUseCase>(
      () => _i27.GetAuthChallengeUseCase(get<_i28.Iden3commRepository>()));
  gh.factory<_i29.GetAuthClaimUseCase>(
      () => _i29.GetAuthClaimUseCase(get<_i30.CredentialRepository>()));
  gh.factory<_i31.GetDidUseCase>(
      () => _i31.GetDidUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i32.GetEnvUseCase>(
      () => _i32.GetEnvUseCase(get<_i33.ConfigRepository>()));
  gh.factory<_i34.GetFetchRequestsUseCase>(
      () => _i34.GetFetchRequestsUseCase());
  gh.factory<_i35.GetGistProofUseCase>(() => _i35.GetGistProofUseCase(
        get<_i10.ProofRepository>(),
        get<_i23.IdentityRepository>(),
        get<_i32.GetEnvUseCase>(),
        get<_i31.GetDidUseCase>(),
      ));
  gh.factory<_i36.GetIden3MessageTypeUseCase>(
      () => _i36.GetIden3MessageTypeUseCase());
  gh.factory<_i37.GetIden3MessageUseCase>(() =>
      _i37.GetIden3MessageUseCase(get<_i36.GetIden3MessageTypeUseCase>()));
  gh.factory<_i38.GetIdentitiesUseCase>(
      () => _i38.GetIdentitiesUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i39.GetIdentityAuthClaimUseCase>(
      () => _i39.GetIdentityAuthClaimUseCase(
            get<_i23.IdentityRepository>(),
            get<_i29.GetAuthClaimUseCase>(),
          ));
  gh.factory<_i40.GetJWZUseCase>(
      () => _i40.GetJWZUseCase(get<_i10.ProofRepository>()));
  gh.factory<_i41.GetLatestStateUseCase>(
      () => _i41.GetLatestStateUseCase(get<_i42.SMTRepository>()));
  gh.factory<_i43.GetPackageNameUseCase>(
      () => _i43.GetPackageNameUseCase(get<_i44.PackageInfoRepository>()));
  gh.factory<_i45.GetPrivateKeyUseCase>(
      () => _i45.GetPrivateKeyUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i46.GetProofQueryUseCase>(() => _i46.GetProofQueryUseCase());
  gh.factory<_i47.GetProofRequestsUseCase>(
      () => _i47.GetProofRequestsUseCase(get<_i46.GetProofQueryUseCase>()));
  gh.factory<_i48.GetPublicKeysUseCase>(
      () => _i48.GetPublicKeysUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i49.GetVocabsUseCase>(
      () => _i49.GetVocabsUseCase(get<_i50.Iden3commCredentialRepository>()));
  gh.factory<_i51.HashMapper>(() => _i51.HashMapper());
  gh.factory<_i52.HexMapper>(() => _i52.HexMapper());
  gh.factory<_i53.IdFilterMapper>(() => _i53.IdFilterMapper());
  gh.factory<_i54.Iden3MessageTypeMapper>(() => _i54.Iden3MessageTypeMapper());
  gh.factory<_i55.IdentityDTOMapper>(() => _i55.IdentityDTOMapper());
  gh.factory<_i56.IdentitySMTStoreRefWrapper>(() =>
      _i56.IdentitySMTStoreRefWrapper(
          get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i57.IdentityStoreRefWrapper>(() => _i57.IdentityStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i58.ImportProfileUseCase>(
      () => _i58.ImportProfileUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i59.IsProofCircuitSupportedUseCase>(
      () => _i59.IsProofCircuitSupportedUseCase(get<_i10.ProofRepository>()));
  gh.factory<_i60.JWZMapper>(() => _i60.JWZMapper());
  gh.factory<_i61.JWZProofMapper>(() => _i61.JWZProofMapper());
  gh.factory<_i62.KeyValueStoreRefWrapper>(() => _i62.KeyValueStoreRefWrapper(
      get<_i14.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i63.LibBabyJubJubDataSource>(
      () => _i63.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i64.LoadCircuitUseCase>(
      () => _i64.LoadCircuitUseCase(get<_i10.ProofRepository>()));
  gh.factory<_i65.LocalContractFilesDataSource>(
      () => _i65.LocalContractFilesDataSource(get<_i66.AssetBundle>()));
  gh.factory<_i67.LocalProofFilesDataSource>(
      () => _i67.LocalProofFilesDataSource());
  gh.factory<_i68.NodeAuxMapper>(() => _i68.NodeAuxMapper());
  gh.factory<_i69.NodeTypeDTOMapper>(() => _i69.NodeTypeDTOMapper());
  gh.factory<_i70.NodeTypeEntityMapper>(() => _i70.NodeTypeEntityMapper());
  gh.factory<_i71.NodeTypeMapper>(() => _i71.NodeTypeMapper());
  gh.factory<_i72.PackageInfoDataSource>(
      () => _i72.PackageInfoDataSource(get<_i73.PackageInfo>()));
  gh.factory<_i74.PackageInfoRepositoryImpl>(
      () => _i74.PackageInfoRepositoryImpl(get<_i72.PackageInfoDataSource>()));
  gh.factory<_i75.PolygonIdCore>(() => _i75.PolygonIdCore());
  gh.factory<_i76.PolygonIdCoreCredential>(
      () => _i76.PolygonIdCoreCredential());
  gh.factory<_i77.PolygonIdCoreIden3comm>(() => _i77.PolygonIdCoreIden3comm());
  gh.factory<_i78.PolygonIdCoreIdentity>(() => _i78.PolygonIdCoreIdentity());
  gh.factory<_i79.PolygonIdCoreProof>(() => _i79.PolygonIdCoreProof());
  gh.factory<_i80.PoseidonHashMapper>(
      () => _i80.PoseidonHashMapper(get<_i52.HexMapper>()));
  gh.factory<_i81.PrivateKeyMapper>(() => _i81.PrivateKeyMapper());
  gh.factory<_i82.ProofCircuitDataSource>(() => _i82.ProofCircuitDataSource());
  gh.lazySingleton<_i83.ProofGenerationStepsStreamManager>(
      () => _i83.ProofGenerationStepsStreamManager());
  gh.factory<_i84.ProofMapper>(() => _i84.ProofMapper(
        get<_i51.HashMapper>(),
        get<_i68.NodeAuxMapper>(),
      ));
  gh.factory<_i85.ProofRequestFiltersMapper>(
      () => _i85.ProofRequestFiltersMapper());
  gh.factory<_i86.ProveUseCase>(
      () => _i86.ProveUseCase(get<_i10.ProofRepository>()));
  gh.factory<_i87.ProverLib>(() => _i87.ProverLib());
  gh.factory<_i88.ProverLibWrapper>(() => _i88.ProverLibWrapper());
  gh.factory<_i89.QMapper>(() => _i89.QMapper());
  gh.factory<_i90.RPCDataSource>(
      () => _i90.RPCDataSource(get<_i91.Web3Client>()));
  gh.factory<_i92.RemoteClaimDataSource>(
      () => _i92.RemoteClaimDataSource(get<_i93.Client>()));
  gh.factory<_i94.RemoteIden3commDataSource>(
      () => _i94.RemoteIden3commDataSource(get<_i93.Client>()));
  gh.factory<_i95.RemoteIdentityDataSource>(
      () => _i95.RemoteIdentityDataSource());
  gh.factory<_i96.RemoveAllClaimsUseCase>(
      () => _i96.RemoveAllClaimsUseCase(get<_i30.CredentialRepository>()));
  gh.factory<_i97.RemoveClaimsUseCase>(
      () => _i97.RemoveClaimsUseCase(get<_i30.CredentialRepository>()));
  gh.factory<_i98.RemoveIdentityStateUseCase>(
      () => _i98.RemoveIdentityStateUseCase(get<_i42.SMTRepository>()));
  gh.factory<_i99.RevocationStatusMapper>(() => _i99.RevocationStatusMapper());
  gh.factory<_i100.RhsNodeTypeMapper>(() => _i100.RhsNodeTypeMapper());
  gh.factory<_i101.SaveClaimsUseCase>(
      () => _i101.SaveClaimsUseCase(get<_i30.CredentialRepository>()));
  gh.factory<_i102.SetEnvUseCase>(
      () => _i102.SetEnvUseCase(get<_i33.ConfigRepository>()));
  gh.factory<_i103.SignMessageUseCase>(
      () => _i103.SignMessageUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i104.StateIdentifierMapper>(() => _i104.StateIdentifierMapper());
  gh.factory<_i13.StorageClaimDataSource>(
      () => _i13.StorageClaimDataSource(get<_i13.ClaimStoreRefWrapper>()));
  gh.factory<_i16.StorageConnectionDataSource>(() =>
      _i16.StorageConnectionDataSource(get<_i16.ConnectionStoreRefWrapper>()));
  gh.factory<_i57.StorageIdentityDataSource>(
      () => _i57.StorageIdentityDataSource(
            get<_i14.Database>(),
            get<_i57.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i62.StorageKeyValueDataSource>(
      () => _i62.StorageKeyValueDataSource(
            get<_i14.Database>(),
            get<_i62.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i56.StorageSMTDataSource>(
      () => _i56.StorageSMTDataSource(get<_i56.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i105.TreeStateMapper>(() => _i105.TreeStateMapper());
  gh.factory<_i106.TreeTypeMapper>(() => _i106.TreeTypeMapper());
  gh.factory<_i107.UpdateClaimUseCase>(
      () => _i107.UpdateClaimUseCase(get<_i30.CredentialRepository>()));
  gh.factory<_i108.WalletLibWrapper>(() => _i108.WalletLibWrapper());
  gh.factory<_i109.WitnessAuthV2Lib>(() => _i109.WitnessAuthV2Lib());
  gh.factory<_i110.WitnessIsolatesWrapper>(
      () => _i110.WitnessIsolatesWrapper());
  gh.factory<_i111.WitnessMTPV2Lib>(() => _i111.WitnessMTPV2Lib());
  gh.factory<_i112.WitnessMTPV2OnchainLib>(
      () => _i112.WitnessMTPV2OnchainLib());
  gh.factory<_i113.WitnessSigV2Lib>(() => _i113.WitnessSigV2Lib());
  gh.factory<_i114.WitnessSigV2OnchainLib>(
      () => _i114.WitnessSigV2OnchainLib());
  gh.factory<_i115.AuthProofMapper>(() => _i115.AuthProofMapper(
        get<_i51.HashMapper>(),
        get<_i68.NodeAuxMapper>(),
      ));
  gh.factory<_i116.ClaimMapper>(() => _i116.ClaimMapper(
        get<_i12.ClaimStateMapper>(),
        get<_i11.ClaimInfoMapper>(),
      ));
  gh.factory<_i117.ConfigRepositoryImpl>(() => _i117.ConfigRepositoryImpl(
        get<_i62.StorageKeyValueDataSource>(),
        get<_i21.EnvMapper>(),
      ));
  gh.factory<_i118.CreateIdentityStateUseCase>(
      () => _i118.CreateIdentityStateUseCase(
            get<_i23.IdentityRepository>(),
            get<_i42.SMTRepository>(),
            get<_i39.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factory<_i119.FetchIdentityStateUseCase>(
      () => _i119.FetchIdentityStateUseCase(
            get<_i23.IdentityRepository>(),
            get<_i32.GetEnvUseCase>(),
            get<_i31.GetDidUseCase>(),
          ));
  gh.factory<_i120.GenerateNonRevProofUseCase>(
      () => _i120.GenerateNonRevProofUseCase(
            get<_i23.IdentityRepository>(),
            get<_i30.CredentialRepository>(),
            get<_i119.FetchIdentityStateUseCase>(),
          ));
  gh.factory<_i121.GetClaimRevocationStatusUseCase>(
      () => _i121.GetClaimRevocationStatusUseCase(
            get<_i30.CredentialRepository>(),
            get<_i23.IdentityRepository>(),
            get<_i120.GenerateNonRevProofUseCase>(),
          ));
  gh.factory<_i122.GetFiltersUseCase>(() => _i122.GetFiltersUseCase(
        get<_i50.Iden3commCredentialRepository>(),
        get<_i59.IsProofCircuitSupportedUseCase>(),
        get<_i47.GetProofRequestsUseCase>(),
      ));
  gh.factory<_i123.GetGenesisStateUseCase>(() => _i123.GetGenesisStateUseCase(
        get<_i23.IdentityRepository>(),
        get<_i42.SMTRepository>(),
        get<_i39.GetIdentityAuthClaimUseCase>(),
      ));
  gh.factory<_i124.GistProofMapper>(
      () => _i124.GistProofMapper(get<_i51.HashMapper>()));
  gh.factory<_i125.GistProofMapper>(
      () => _i125.GistProofMapper(get<_i84.ProofMapper>()));
  gh.factory<_i126.Iden3commCredentialRepositoryImpl>(
      () => _i126.Iden3commCredentialRepositoryImpl(
            get<_i94.RemoteIden3commDataSource>(),
            get<_i85.ProofRequestFiltersMapper>(),
            get<_i116.ClaimMapper>(),
          ));
  gh.factory<_i127.LibPolygonIdCoreCredentialDataSource>(() =>
      _i127.LibPolygonIdCoreCredentialDataSource(
          get<_i76.PolygonIdCoreCredential>()));
  gh.factory<_i128.LibPolygonIdCoreIden3commDataSource>(() =>
      _i128.LibPolygonIdCoreIden3commDataSource(
          get<_i77.PolygonIdCoreIden3comm>()));
  gh.factory<_i129.LibPolygonIdCoreIdentityDataSource>(() =>
      _i129.LibPolygonIdCoreIdentityDataSource(
          get<_i78.PolygonIdCoreIdentity>()));
  gh.factory<_i130.LibPolygonIdCoreWrapper>(
      () => _i130.LibPolygonIdCoreWrapper(get<_i79.PolygonIdCoreProof>()));
  gh.factory<_i131.LocalClaimDataSource>(() => _i131.LocalClaimDataSource(
      get<_i127.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i132.NodeMapper>(() => _i132.NodeMapper(
        get<_i71.NodeTypeMapper>(),
        get<_i70.NodeTypeEntityMapper>(),
        get<_i69.NodeTypeDTOMapper>(),
        get<_i51.HashMapper>(),
      ));
  gh.factory<_i88.ProverLibDataSource>(
      () => _i88.ProverLibDataSource(get<_i88.ProverLibWrapper>()));
  gh.factory<_i133.RhsNodeMapper>(
      () => _i133.RhsNodeMapper(get<_i100.RhsNodeTypeMapper>()));
  gh.factory<_i134.SMTDataSource>(() => _i134.SMTDataSource(
        get<_i52.HexMapper>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i56.StorageSMTDataSource>(),
      ));
  gh.factory<_i135.SMTRepositoryImpl>(() => _i135.SMTRepositoryImpl(
        get<_i134.SMTDataSource>(),
        get<_i56.StorageSMTDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i132.NodeMapper>(),
        get<_i51.HashMapper>(),
        get<_i84.ProofMapper>(),
        get<_i106.TreeTypeMapper>(),
        get<_i105.TreeStateMapper>(),
      ));
  gh.factory<_i108.WalletDataSource>(
      () => _i108.WalletDataSource(get<_i108.WalletLibWrapper>()));
  gh.factory<_i110.WitnessDataSource>(
      () => _i110.WitnessDataSource(get<_i110.WitnessIsolatesWrapper>()));
  gh.factory<_i136.CredentialRepositoryImpl>(
      () => _i136.CredentialRepositoryImpl(
            get<_i92.RemoteClaimDataSource>(),
            get<_i13.StorageClaimDataSource>(),
            get<_i131.LocalClaimDataSource>(),
            get<_i116.ClaimMapper>(),
            get<_i26.FiltersMapper>(),
            get<_i53.IdFilterMapper>(),
          ));
  gh.factory<_i137.GetDidIdentifierUseCase>(() => _i137.GetDidIdentifierUseCase(
        get<_i23.IdentityRepository>(),
        get<_i123.GetGenesisStateUseCase>(),
      ));
  gh.factory<_i138.GetIdentityUseCase>(() => _i138.GetIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i31.GetDidUseCase>(),
        get<_i137.GetDidIdentifierUseCase>(),
      ));
  gh.factory<_i139.Iden3commRepositoryImpl>(() => _i139.Iden3commRepositoryImpl(
        get<_i94.RemoteIden3commDataSource>(),
        get<_i128.LibPolygonIdCoreIden3commDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i16.StorageConnectionDataSource>(),
        get<_i4.AuthResponseMapper>(),
        get<_i3.AuthInputsMapper>(),
        get<_i115.AuthProofMapper>(),
        get<_i124.GistProofMapper>(),
        get<_i89.QMapper>(),
        get<_i15.ConnectionMapper>(),
      ));
  gh.factory<_i140.IdentityRepositoryImpl>(() => _i140.IdentityRepositoryImpl(
        get<_i108.WalletDataSource>(),
        get<_i95.RemoteIdentityDataSource>(),
        get<_i57.StorageIdentityDataSource>(),
        get<_i90.RPCDataSource>(),
        get<_i65.LocalContractFilesDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i129.LibPolygonIdCoreIdentityDataSource>(),
        get<_i19.EncryptionDbDataSource>(),
        get<_i17.DestinationPathDataSource>(),
        get<_i52.HexMapper>(),
        get<_i81.PrivateKeyMapper>(),
        get<_i55.IdentityDTOMapper>(),
        get<_i133.RhsNodeMapper>(),
        get<_i104.StateIdentifierMapper>(),
        get<_i132.NodeMapper>(),
        get<_i20.EncryptionKeyMapper>(),
      ));
  gh.factory<_i130.LibPolygonIdCoreProofDataSource>(() =>
      _i130.LibPolygonIdCoreProofDataSource(
          get<_i130.LibPolygonIdCoreWrapper>()));
  gh.factory<_i141.ProofRepositoryImpl>(() => _i141.ProofRepositoryImpl(
        get<_i110.WitnessDataSource>(),
        get<_i88.ProverLibDataSource>(),
        get<_i130.LibPolygonIdCoreProofDataSource>(),
        get<_i67.LocalProofFilesDataSource>(),
        get<_i82.ProofCircuitDataSource>(),
        get<_i95.RemoteIdentityDataSource>(),
        get<_i65.LocalContractFilesDataSource>(),
        get<_i8.CircuitsDownloadDataSource>(),
        get<_i90.RPCDataSource>(),
        get<_i7.CircuitTypeMapper>(),
        get<_i61.JWZProofMapper>(),
        get<_i116.ClaimMapper>(),
        get<_i99.RevocationStatusMapper>(),
        get<_i60.JWZMapper>(),
        get<_i115.AuthProofMapper>(),
        get<_i125.GistProofMapper>(),
        get<_i124.GistProofMapper>(),
      ));
  gh.factory<_i142.CheckProfileAndDidCurrentEnvUseCase>(
      () => _i142.CheckProfileAndDidCurrentEnvUseCase(
            get<_i6.CheckProfileValidityUseCase>(),
            get<_i32.GetEnvUseCase>(),
            get<_i137.GetDidIdentifierUseCase>(),
          ));
  gh.factory<_i143.GenerateProofUseCase>(() => _i143.GenerateProofUseCase(
        get<_i23.IdentityRepository>(),
        get<_i42.SMTRepository>(),
        get<_i10.ProofRepository>(),
        get<_i86.ProveUseCase>(),
        get<_i138.GetIdentityUseCase>(),
        get<_i29.GetAuthClaimUseCase>(),
        get<_i35.GetGistProofUseCase>(),
        get<_i31.GetDidUseCase>(),
        get<_i103.SignMessageUseCase>(),
        get<_i41.GetLatestStateUseCase>(),
      ));
  gh.factory<_i144.GetAuthInputsUseCase>(() => _i144.GetAuthInputsUseCase(
        get<_i138.GetIdentityUseCase>(),
        get<_i29.GetAuthClaimUseCase>(),
        get<_i103.SignMessageUseCase>(),
        get<_i35.GetGistProofUseCase>(),
        get<_i41.GetLatestStateUseCase>(),
        get<_i28.Iden3commRepository>(),
        get<_i23.IdentityRepository>(),
        get<_i42.SMTRepository>(),
      ));
  gh.factory<_i145.GetAuthTokenUseCase>(() => _i145.GetAuthTokenUseCase(
        get<_i64.LoadCircuitUseCase>(),
        get<_i40.GetJWZUseCase>(),
        get<_i27.GetAuthChallengeUseCase>(),
        get<_i144.GetAuthInputsUseCase>(),
        get<_i86.ProveUseCase>(),
      ));
  gh.factory<_i146.GetCurrentEnvDidIdentifierUseCase>(
      () => _i146.GetCurrentEnvDidIdentifierUseCase(
            get<_i32.GetEnvUseCase>(),
            get<_i137.GetDidIdentifierUseCase>(),
          ));
  gh.factory<_i147.GetProfilesUseCase>(() => _i147.GetProfilesUseCase(
        get<_i138.GetIdentityUseCase>(),
        get<_i142.CheckProfileAndDidCurrentEnvUseCase>(),
      ));
  gh.factory<_i148.Proof>(() => _i148.Proof(
        get<_i143.GenerateProofUseCase>(),
        get<_i18.DownloadCircuitsUseCase>(),
        get<_i9.CircuitsFilesExistUseCase>(),
        get<_i83.ProofGenerationStepsStreamManager>(),
      ));
  gh.factory<_i149.BackupIdentityUseCase>(() => _i149.BackupIdentityUseCase(
        get<_i138.GetIdentityUseCase>(),
        get<_i22.ExportProfileUseCase>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i150.CheckIdentityValidityUseCase>(
      () => _i150.CheckIdentityValidityUseCase(
            get<_i45.GetPrivateKeyUseCase>(),
            get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factory<_i151.CreateIdentityUseCase>(() => _i151.CreateIdentityUseCase(
        get<_i48.GetPublicKeysUseCase>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i152.CreateProfilesUseCase>(() => _i152.CreateProfilesUseCase(
        get<_i48.GetPublicKeysUseCase>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i153.FetchAndSaveClaimsUseCase>(
      () => _i153.FetchAndSaveClaimsUseCase(
            get<_i50.Iden3commCredentialRepository>(),
            get<_i34.GetFetchRequestsUseCase>(),
            get<_i145.GetAuthTokenUseCase>(),
            get<_i101.SaveClaimsUseCase>(),
            get<_i121.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factory<_i154.GetClaimsUseCase>(() => _i154.GetClaimsUseCase(
        get<_i30.CredentialRepository>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
        get<_i138.GetIdentityUseCase>(),
      ));
  gh.factory<_i155.GetConnectionsUseCase>(() => _i155.GetConnectionsUseCase(
        get<_i28.Iden3commRepository>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
        get<_i138.GetIdentityUseCase>(),
      ));
  gh.factory<_i156.GetIden3commClaimsUseCase>(
      () => _i156.GetIden3commClaimsUseCase(
            get<_i50.Iden3commCredentialRepository>(),
            get<_i154.GetClaimsUseCase>(),
            get<_i121.GetClaimRevocationStatusUseCase>(),
            get<_i107.UpdateClaimUseCase>(),
            get<_i59.IsProofCircuitSupportedUseCase>(),
            get<_i47.GetProofRequestsUseCase>(),
          ));
  gh.factory<_i157.GetIden3commProofsUseCase>(
      () => _i157.GetIden3commProofsUseCase(
            get<_i10.ProofRepository>(),
            get<_i23.IdentityRepository>(),
            get<_i156.GetIden3commClaimsUseCase>(),
            get<_i143.GenerateProofUseCase>(),
            get<_i59.IsProofCircuitSupportedUseCase>(),
            get<_i47.GetProofRequestsUseCase>(),
            get<_i83.ProofGenerationStepsStreamManager>(),
          ));
  gh.factory<_i158.UpdateIdentityUseCase>(() => _i158.UpdateIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i151.CreateIdentityUseCase>(),
        get<_i138.GetIdentityUseCase>(),
      ));
  gh.factory<_i159.AddIdentityUseCase>(() => _i159.AddIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i151.CreateIdentityUseCase>(),
        get<_i118.CreateIdentityStateUseCase>(),
      ));
  gh.factory<_i160.AddNewIdentityUseCase>(() => _i160.AddNewIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i159.AddIdentityUseCase>(),
      ));
  gh.factory<_i161.AddProfileUseCase>(() => _i161.AddProfileUseCase(
        get<_i138.GetIdentityUseCase>(),
        get<_i158.UpdateIdentityUseCase>(),
        get<_i142.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i152.CreateProfilesUseCase>(),
        get<_i118.CreateIdentityStateUseCase>(),
      ));
  gh.factory<_i162.AuthenticateUseCase>(() => _i162.AuthenticateUseCase(
        get<_i28.Iden3commRepository>(),
        get<_i157.GetIden3commProofsUseCase>(),
        get<_i145.GetAuthTokenUseCase>(),
        get<_i32.GetEnvUseCase>(),
        get<_i43.GetPackageNameUseCase>(),
        get<_i142.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i83.ProofGenerationStepsStreamManager>(),
      ));
  gh.factory<_i163.Credential>(() => _i163.Credential(
        get<_i101.SaveClaimsUseCase>(),
        get<_i154.GetClaimsUseCase>(),
        get<_i97.RemoveClaimsUseCase>(),
        get<_i107.UpdateClaimUseCase>(),
      ));
  gh.factory<_i164.Iden3comm>(() => _i164.Iden3comm(
        get<_i153.FetchAndSaveClaimsUseCase>(),
        get<_i37.GetIden3MessageUseCase>(),
        get<_i162.AuthenticateUseCase>(),
        get<_i122.GetFiltersUseCase>(),
        get<_i156.GetIden3commClaimsUseCase>(),
        get<_i157.GetIden3commProofsUseCase>(),
        get<_i155.GetConnectionsUseCase>(),
      ));
  gh.factory<_i165.RemoveProfileUseCase>(() => _i165.RemoveProfileUseCase(
        get<_i138.GetIdentityUseCase>(),
        get<_i158.UpdateIdentityUseCase>(),
        get<_i142.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i152.CreateProfilesUseCase>(),
        get<_i98.RemoveIdentityStateUseCase>(),
        get<_i96.RemoveAllClaimsUseCase>(),
      ));
  gh.factory<_i166.RestoreIdentityUseCase>(() => _i166.RestoreIdentityUseCase(
        get<_i159.AddIdentityUseCase>(),
        get<_i138.GetIdentityUseCase>(),
        get<_i58.ImportProfileUseCase>(),
        get<_i146.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i167.RemoveIdentityUseCase>(() => _i167.RemoveIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i147.GetProfilesUseCase>(),
        get<_i165.RemoveProfileUseCase>(),
        get<_i98.RemoveIdentityStateUseCase>(),
        get<_i96.RemoveAllClaimsUseCase>(),
        get<_i142.CheckProfileAndDidCurrentEnvUseCase>(),
      ));
  gh.factory<_i168.Identity>(() => _i168.Identity(
        get<_i150.CheckIdentityValidityUseCase>(),
        get<_i45.GetPrivateKeyUseCase>(),
        get<_i160.AddNewIdentityUseCase>(),
        get<_i166.RestoreIdentityUseCase>(),
        get<_i149.BackupIdentityUseCase>(),
        get<_i138.GetIdentityUseCase>(),
        get<_i38.GetIdentitiesUseCase>(),
        get<_i167.RemoveIdentityUseCase>(),
        get<_i137.GetDidIdentifierUseCase>(),
        get<_i103.SignMessageUseCase>(),
        get<_i119.FetchIdentityStateUseCase>(),
        get<_i161.AddProfileUseCase>(),
        get<_i147.GetProfilesUseCase>(),
        get<_i165.RemoveProfileUseCase>(),
      ));
  return get;
}
