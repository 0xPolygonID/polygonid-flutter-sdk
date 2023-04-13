// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i68;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i96;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i76;
import 'package:sembast/sembast.dart' as _i16;
import 'package:web3dart/web3dart.dart' as _i94;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i21;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i24;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i25;
import '../../common/data/data_sources/package_info_datasource.dart' as _i75;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i62;
import '../../common/data/repositories/config_repository_impl.dart' as _i121;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i77;
import '../../common/domain/repositories/config_repository.dart' as _i32;
import '../../common/domain/repositories/package_info_repository.dart' as _i43;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i31;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i42;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i106;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i78;
import '../../credential/data/credential_repository_impl.dart' as _i141;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i132;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i136;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i95;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i15;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i13;
import '../../credential/data/mappers/claim_mapper.dart' as _i120;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i14;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i52;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i102;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i29;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i28;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i125;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i160;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i99;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i100;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i104;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i111;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i79;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i133;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i6;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i97;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i105;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i58;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i119;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i128;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/notification_mapper.dart' as _i74;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i88;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i130;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i144;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i131;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i49;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i27;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i65;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i167;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i147;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i159;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i26;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i149;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i150;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i33;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i126;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i161;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i162;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i35;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i36;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i45;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i46;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i48;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i152;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i64;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i80;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i19;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i134;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i67;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i98;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i93;
import '../../identity/data/data_sources/smt_data_source.dart' as _i139;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i56;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i55;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i112;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i20;
import '../../identity/data/mappers/hash_mapper.dart' as _i50;
import '../../identity/data/mappers/hex_mapper.dart' as _i51;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i54;
import '../../identity/data/mappers/node_mapper.dart' as _i137;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i71;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i72;
import '../../identity/data/mappers/node_type_mapper.dart' as _i73;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i83;
import '../../identity/data/mappers/private_key_mapper.dart' as _i84;
import '../../identity/data/mappers/q_mapper.dart' as _i92;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i138;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i103;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i108;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i109;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i110;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i145;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i140;
import '../../identity/domain/repositories/identity_repository.dart' as _i23;
import '../../identity/domain/repositories/smt_repository.dart' as _i41;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i123;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i22;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i124;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i151;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i30;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i127;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i38;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart' as _i40;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i47;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i164;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i155;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i156;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i157;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i37;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i44;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i172;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i171;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i107;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i163;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i166;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i8;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i153;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i170;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i122;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i101;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i81;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i10;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i135;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i69;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i85;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i91;
import '../../proof/data/data_sources/witness_data_source.dart' as _i114;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i9;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i129;
import '../../proof/data/mappers/jwz_mapper.dart' as _i60;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i61;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i70;
import '../../proof/data/mappers/proof_mapper.dart' as _i87;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i146;
import '../../proof/domain/repositories/proof_repository.dart' as _i12;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i11;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i18;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i148;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i34;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i39;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i59;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i66;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i89;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i86;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i82;
import '../../proof/libs/prover/prover.dart' as _i90;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i113;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i115;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i116;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i117;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i118;
import '../credential.dart' as _i168;
import '../iden3comm.dart' as _i169;
import '../identity.dart' as _i173;
import '../mappers/iden3_message_type_mapper.dart' as _i53;
import '../polygon_id_channel.dart' as _i7;
import '../proof.dart' as _i154; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i6.ChannelPushNotificationDataSource>(
      () => _i6.ChannelPushNotificationDataSource(get<_i7.PolygonIdChannel>()));
  gh.factory<_i8.CheckProfileValidityUseCase>(
      () => _i8.CheckProfileValidityUseCase());
  gh.factory<_i9.CircuitTypeMapper>(() => _i9.CircuitTypeMapper());
  gh.factory<_i10.CircuitsDownloadDataSource>(
      () => _i10.CircuitsDownloadDataSource());
  gh.factory<_i11.CircuitsFilesExistUseCase>(
      () => _i11.CircuitsFilesExistUseCase(get<_i12.ProofRepository>()));
  gh.factory<_i13.ClaimInfoMapper>(() => _i13.ClaimInfoMapper());
  gh.factory<_i14.ClaimStateMapper>(() => _i14.ClaimStateMapper());
  gh.factory<_i15.ClaimStoreRefWrapper>(() => _i15.ClaimStoreRefWrapper(
      get<_i16.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i17.CreatePathWrapper>(() => _i17.CreatePathWrapper());
  gh.factory<_i17.DestinationPathDataSource>(
      () => _i17.DestinationPathDataSource(get<_i17.CreatePathWrapper>()));
  gh.factory<_i18.DownloadCircuitsUseCase>(() => _i18.DownloadCircuitsUseCase(
        get<_i12.ProofRepository>(),
        get<_i11.CircuitsFilesExistUseCase>(),
      ));
  gh.factory<_i19.EncryptionDbDataSource>(() => _i19.EncryptionDbDataSource());
  gh.factory<_i20.EncryptionKeyMapper>(() => _i20.EncryptionKeyMapper());
  gh.factory<_i21.EnvMapper>(() => _i21.EnvMapper());
  gh.factory<_i22.FetchStateRootsUseCase>(
      () => _i22.FetchStateRootsUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i24.FilterMapper>(() => _i24.FilterMapper());
  gh.factory<_i25.FiltersMapper>(
      () => _i25.FiltersMapper(get<_i24.FilterMapper>()));
  gh.factory<_i26.GetAuthChallengeUseCase>(
      () => _i26.GetAuthChallengeUseCase(get<_i27.Iden3commRepository>()));
  gh.factory<_i28.GetAuthClaimUseCase>(
      () => _i28.GetAuthClaimUseCase(get<_i29.CredentialRepository>()));
  gh.factory<_i30.GetDidUseCase>(
      () => _i30.GetDidUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i31.GetEnvUseCase>(
      () => _i31.GetEnvUseCase(get<_i32.ConfigRepository>()));
  gh.factory<_i33.GetFetchRequestsUseCase>(
      () => _i33.GetFetchRequestsUseCase());
  gh.factory<_i34.GetGistProofUseCase>(() => _i34.GetGistProofUseCase(
        get<_i12.ProofRepository>(),
        get<_i23.IdentityRepository>(),
        get<_i31.GetEnvUseCase>(),
        get<_i30.GetDidUseCase>(),
      ));
  gh.factory<_i35.GetIden3MessageTypeUseCase>(
      () => _i35.GetIden3MessageTypeUseCase());
  gh.factory<_i36.GetIden3MessageUseCase>(() =>
      _i36.GetIden3MessageUseCase(get<_i35.GetIden3MessageTypeUseCase>()));
  gh.factory<_i37.GetIdentitiesUseCase>(
      () => _i37.GetIdentitiesUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i38.GetIdentityAuthClaimUseCase>(
      () => _i38.GetIdentityAuthClaimUseCase(
            get<_i23.IdentityRepository>(),
            get<_i28.GetAuthClaimUseCase>(),
          ));
  gh.factory<_i39.GetJWZUseCase>(
      () => _i39.GetJWZUseCase(get<_i12.ProofRepository>()));
  gh.factory<_i40.GetLatestStateUseCase>(
      () => _i40.GetLatestStateUseCase(get<_i41.SMTRepository>()));
  gh.factory<_i42.GetPackageNameUseCase>(
      () => _i42.GetPackageNameUseCase(get<_i43.PackageInfoRepository>()));
  gh.factory<_i44.GetPrivateKeyUseCase>(
      () => _i44.GetPrivateKeyUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i45.GetProofQueryUseCase>(() => _i45.GetProofQueryUseCase());
  gh.factory<_i46.GetProofRequestsUseCase>(
      () => _i46.GetProofRequestsUseCase(get<_i45.GetProofQueryUseCase>()));
  gh.factory<_i47.GetPublicKeysUseCase>(
      () => _i47.GetPublicKeysUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i48.GetVocabsUseCase>(
      () => _i48.GetVocabsUseCase(get<_i49.Iden3commCredentialRepository>()));
  gh.factory<_i50.HashMapper>(() => _i50.HashMapper());
  gh.factory<_i51.HexMapper>(() => _i51.HexMapper());
  gh.factory<_i52.IdFilterMapper>(() => _i52.IdFilterMapper());
  gh.factory<_i53.Iden3MessageTypeMapper>(() => _i53.Iden3MessageTypeMapper());
  gh.factory<_i54.IdentityDTOMapper>(() => _i54.IdentityDTOMapper());
  gh.factory<_i55.IdentitySMTStoreRefWrapper>(() =>
      _i55.IdentitySMTStoreRefWrapper(
          get<Map<String, _i16.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i56.IdentityStoreRefWrapper>(() => _i56.IdentityStoreRefWrapper(
      get<_i16.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i57.InteractionMapper>(() => _i57.InteractionMapper());
  gh.factory<_i58.InteractionStoreRefWrapper>(() =>
      _i58.InteractionStoreRefWrapper(
          get<_i16.StoreRef<int, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i59.IsProofCircuitSupportedUseCase>(
      () => _i59.IsProofCircuitSupportedUseCase(get<_i12.ProofRepository>()));
  gh.factory<_i60.JWZMapper>(() => _i60.JWZMapper());
  gh.factory<_i61.JWZProofMapper>(() => _i61.JWZProofMapper());
  gh.factory<_i62.KeyValueStoreRefWrapper>(() => _i62.KeyValueStoreRefWrapper(
      get<_i16.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i63.LibBabyJubJubDataSource>(
      () => _i63.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i64.ListenAndStoreNotificationUseCase>(() =>
      _i64.ListenAndStoreNotificationUseCase(
          get<_i65.InteractionRepository>()));
  gh.factory<_i66.LoadCircuitUseCase>(
      () => _i66.LoadCircuitUseCase(get<_i12.ProofRepository>()));
  gh.factory<_i67.LocalContractFilesDataSource>(
      () => _i67.LocalContractFilesDataSource(get<_i68.AssetBundle>()));
  gh.factory<_i69.LocalProofFilesDataSource>(
      () => _i69.LocalProofFilesDataSource());
  gh.factory<_i70.NodeAuxMapper>(() => _i70.NodeAuxMapper());
  gh.factory<_i71.NodeTypeDTOMapper>(() => _i71.NodeTypeDTOMapper());
  gh.factory<_i72.NodeTypeEntityMapper>(() => _i72.NodeTypeEntityMapper());
  gh.factory<_i73.NodeTypeMapper>(() => _i73.NodeTypeMapper());
  gh.factory<_i74.NotificationMapper>(() => _i74.NotificationMapper());
  gh.factory<_i75.PackageInfoDataSource>(
      () => _i75.PackageInfoDataSource(get<_i76.PackageInfo>()));
  gh.factory<_i77.PackageInfoRepositoryImpl>(
      () => _i77.PackageInfoRepositoryImpl(get<_i75.PackageInfoDataSource>()));
  gh.factory<_i78.PolygonIdCore>(() => _i78.PolygonIdCore());
  gh.factory<_i79.PolygonIdCoreCredential>(
      () => _i79.PolygonIdCoreCredential());
  gh.factory<_i80.PolygonIdCoreIden3comm>(() => _i80.PolygonIdCoreIden3comm());
  gh.factory<_i81.PolygonIdCoreIdentity>(() => _i81.PolygonIdCoreIdentity());
  gh.factory<_i82.PolygonIdCoreProof>(() => _i82.PolygonIdCoreProof());
  gh.factory<_i83.PoseidonHashMapper>(
      () => _i83.PoseidonHashMapper(get<_i51.HexMapper>()));
  gh.factory<_i84.PrivateKeyMapper>(() => _i84.PrivateKeyMapper());
  gh.factory<_i85.ProofCircuitDataSource>(() => _i85.ProofCircuitDataSource());
  gh.lazySingleton<_i86.ProofGenerationStepsStreamManager>(
      () => _i86.ProofGenerationStepsStreamManager());
  gh.factory<_i87.ProofMapper>(() => _i87.ProofMapper(
        get<_i50.HashMapper>(),
        get<_i70.NodeAuxMapper>(),
      ));
  gh.factory<_i88.ProofRequestFiltersMapper>(
      () => _i88.ProofRequestFiltersMapper());
  gh.factory<_i89.ProveUseCase>(
      () => _i89.ProveUseCase(get<_i12.ProofRepository>()));
  gh.factory<_i90.ProverLib>(() => _i90.ProverLib());
  gh.factory<_i91.ProverLibWrapper>(() => _i91.ProverLibWrapper());
  gh.factory<_i92.QMapper>(() => _i92.QMapper());
  gh.factory<_i93.RPCDataSource>(
      () => _i93.RPCDataSource(get<_i94.Web3Client>()));
  gh.factory<_i95.RemoteClaimDataSource>(
      () => _i95.RemoteClaimDataSource(get<_i96.Client>()));
  gh.factory<_i97.RemoteIden3commDataSource>(
      () => _i97.RemoteIden3commDataSource(get<_i96.Client>()));
  gh.factory<_i98.RemoteIdentityDataSource>(
      () => _i98.RemoteIdentityDataSource());
  gh.factory<_i99.RemoveAllClaimsUseCase>(
      () => _i99.RemoveAllClaimsUseCase(get<_i29.CredentialRepository>()));
  gh.factory<_i100.RemoveClaimsUseCase>(
      () => _i100.RemoveClaimsUseCase(get<_i29.CredentialRepository>()));
  gh.factory<_i101.RemoveIdentityStateUseCase>(
      () => _i101.RemoveIdentityStateUseCase(get<_i41.SMTRepository>()));
  gh.factory<_i102.RevocationStatusMapper>(
      () => _i102.RevocationStatusMapper());
  gh.factory<_i103.RhsNodeTypeMapper>(() => _i103.RhsNodeTypeMapper());
  gh.factory<_i104.SaveClaimsUseCase>(
      () => _i104.SaveClaimsUseCase(get<_i29.CredentialRepository>()));
  gh.factory<_i105.SecureInteractionStoreRefWrapper>(() =>
      _i105.SecureInteractionStoreRefWrapper(
          get<_i16.StoreRef<int, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i105.SecureStorageInteractionDataSource>(() =>
      _i105.SecureStorageInteractionDataSource(
          get<_i105.SecureInteractionStoreRefWrapper>()));
  gh.factory<_i106.SetEnvUseCase>(
      () => _i106.SetEnvUseCase(get<_i32.ConfigRepository>()));
  gh.factory<_i107.SignMessageUseCase>(
      () => _i107.SignMessageUseCase(get<_i23.IdentityRepository>()));
  gh.factory<_i108.StateIdentifierMapper>(() => _i108.StateIdentifierMapper());
  gh.factory<_i15.StorageClaimDataSource>(
      () => _i15.StorageClaimDataSource(get<_i15.ClaimStoreRefWrapper>()));
  gh.factory<_i56.StorageIdentityDataSource>(
      () => _i56.StorageIdentityDataSource(
            get<_i16.Database>(),
            get<_i56.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i58.StorageInteractionDataSource>(
      () => _i58.StorageInteractionDataSource(
            get<_i16.Database>(),
            get<_i58.InteractionStoreRefWrapper>(),
          ));
  gh.factory<_i62.StorageKeyValueDataSource>(
      () => _i62.StorageKeyValueDataSource(
            get<_i16.Database>(),
            get<_i62.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i55.StorageSMTDataSource>(
      () => _i55.StorageSMTDataSource(get<_i55.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i109.TreeStateMapper>(() => _i109.TreeStateMapper());
  gh.factory<_i110.TreeTypeMapper>(() => _i110.TreeTypeMapper());
  gh.factory<_i111.UpdateClaimUseCase>(
      () => _i111.UpdateClaimUseCase(get<_i29.CredentialRepository>()));
  gh.factory<_i112.WalletLibWrapper>(() => _i112.WalletLibWrapper());
  gh.factory<_i113.WitnessAuthV2Lib>(() => _i113.WitnessAuthV2Lib());
  gh.factory<_i114.WitnessIsolatesWrapper>(
      () => _i114.WitnessIsolatesWrapper());
  gh.factory<_i115.WitnessMTPV2Lib>(() => _i115.WitnessMTPV2Lib());
  gh.factory<_i116.WitnessMTPV2OnchainLib>(
      () => _i116.WitnessMTPV2OnchainLib());
  gh.factory<_i117.WitnessSigV2Lib>(() => _i117.WitnessSigV2Lib());
  gh.factory<_i118.WitnessSigV2OnchainLib>(
      () => _i118.WitnessSigV2OnchainLib());
  gh.factory<_i119.AuthProofMapper>(() => _i119.AuthProofMapper(
        get<_i50.HashMapper>(),
        get<_i70.NodeAuxMapper>(),
      ));
  gh.factory<_i120.ClaimMapper>(() => _i120.ClaimMapper(
        get<_i14.ClaimStateMapper>(),
        get<_i13.ClaimInfoMapper>(),
      ));
  gh.factory<_i121.ConfigRepositoryImpl>(() => _i121.ConfigRepositoryImpl(
        get<_i62.StorageKeyValueDataSource>(),
        get<_i21.EnvMapper>(),
      ));
  gh.factory<_i122.CreateIdentityStateUseCase>(
      () => _i122.CreateIdentityStateUseCase(
            get<_i23.IdentityRepository>(),
            get<_i41.SMTRepository>(),
            get<_i38.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factory<_i123.FetchIdentityStateUseCase>(
      () => _i123.FetchIdentityStateUseCase(
            get<_i23.IdentityRepository>(),
            get<_i31.GetEnvUseCase>(),
            get<_i30.GetDidUseCase>(),
          ));
  gh.factory<_i124.GenerateNonRevProofUseCase>(
      () => _i124.GenerateNonRevProofUseCase(
            get<_i23.IdentityRepository>(),
            get<_i29.CredentialRepository>(),
            get<_i123.FetchIdentityStateUseCase>(),
          ));
  gh.factory<_i125.GetClaimRevocationStatusUseCase>(
      () => _i125.GetClaimRevocationStatusUseCase(
            get<_i29.CredentialRepository>(),
            get<_i23.IdentityRepository>(),
            get<_i124.GenerateNonRevProofUseCase>(),
          ));
  gh.factory<_i126.GetFiltersUseCase>(() => _i126.GetFiltersUseCase(
        get<_i49.Iden3commCredentialRepository>(),
        get<_i59.IsProofCircuitSupportedUseCase>(),
        get<_i46.GetProofRequestsUseCase>(),
      ));
  gh.factory<_i127.GetGenesisStateUseCase>(() => _i127.GetGenesisStateUseCase(
        get<_i23.IdentityRepository>(),
        get<_i41.SMTRepository>(),
        get<_i38.GetIdentityAuthClaimUseCase>(),
      ));
  gh.factory<_i128.GistProofMapper>(
      () => _i128.GistProofMapper(get<_i50.HashMapper>()));
  gh.factory<_i129.GistProofMapper>(
      () => _i129.GistProofMapper(get<_i87.ProofMapper>()));
  gh.factory<_i130.Iden3commCredentialRepositoryImpl>(
      () => _i130.Iden3commCredentialRepositoryImpl(
            get<_i97.RemoteIden3commDataSource>(),
            get<_i88.ProofRequestFiltersMapper>(),
            get<_i120.ClaimMapper>(),
          ));
  gh.factory<_i131.InteractionRepositoryImpl>(
      () => _i131.InteractionRepositoryImpl(
            get<_i6.ChannelPushNotificationDataSource>(),
            get<_i105.SecureStorageInteractionDataSource>(),
            get<_i74.NotificationMapper>(),
            get<_i57.InteractionMapper>(),
            get<_i25.FiltersMapper>(),
          ));
  gh.factory<_i132.LibPolygonIdCoreCredentialDataSource>(() =>
      _i132.LibPolygonIdCoreCredentialDataSource(
          get<_i79.PolygonIdCoreCredential>()));
  gh.factory<_i133.LibPolygonIdCoreIden3commDataSource>(() =>
      _i133.LibPolygonIdCoreIden3commDataSource(
          get<_i80.PolygonIdCoreIden3comm>()));
  gh.factory<_i134.LibPolygonIdCoreIdentityDataSource>(() =>
      _i134.LibPolygonIdCoreIdentityDataSource(
          get<_i81.PolygonIdCoreIdentity>()));
  gh.factory<_i135.LibPolygonIdCoreWrapper>(
      () => _i135.LibPolygonIdCoreWrapper(get<_i82.PolygonIdCoreProof>()));
  gh.factory<_i136.LocalClaimDataSource>(() => _i136.LocalClaimDataSource(
      get<_i132.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i137.NodeMapper>(() => _i137.NodeMapper(
        get<_i73.NodeTypeMapper>(),
        get<_i72.NodeTypeEntityMapper>(),
        get<_i71.NodeTypeDTOMapper>(),
        get<_i50.HashMapper>(),
      ));
  gh.factory<_i91.ProverLibDataSource>(
      () => _i91.ProverLibDataSource(get<_i91.ProverLibWrapper>()));
  gh.factory<_i138.RhsNodeMapper>(
      () => _i138.RhsNodeMapper(get<_i103.RhsNodeTypeMapper>()));
  gh.factory<_i139.SMTDataSource>(() => _i139.SMTDataSource(
        get<_i51.HexMapper>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i55.StorageSMTDataSource>(),
      ));
  gh.factory<_i140.SMTRepositoryImpl>(() => _i140.SMTRepositoryImpl(
        get<_i139.SMTDataSource>(),
        get<_i55.StorageSMTDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i137.NodeMapper>(),
        get<_i50.HashMapper>(),
        get<_i87.ProofMapper>(),
        get<_i110.TreeTypeMapper>(),
        get<_i109.TreeStateMapper>(),
      ));
  gh.factory<_i112.WalletDataSource>(
      () => _i112.WalletDataSource(get<_i112.WalletLibWrapper>()));
  gh.factory<_i114.WitnessDataSource>(
      () => _i114.WitnessDataSource(get<_i114.WitnessIsolatesWrapper>()));
  gh.factory<_i141.CredentialRepositoryImpl>(
      () => _i141.CredentialRepositoryImpl(
            get<_i95.RemoteClaimDataSource>(),
            get<_i15.StorageClaimDataSource>(),
            get<_i136.LocalClaimDataSource>(),
            get<_i120.ClaimMapper>(),
            get<_i25.FiltersMapper>(),
            get<_i52.IdFilterMapper>(),
          ));
  gh.factory<_i142.GetDidIdentifierUseCase>(() => _i142.GetDidIdentifierUseCase(
        get<_i23.IdentityRepository>(),
        get<_i127.GetGenesisStateUseCase>(),
      ));
  gh.factory<_i143.GetIdentityUseCase>(() => _i143.GetIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i30.GetDidUseCase>(),
        get<_i142.GetDidIdentifierUseCase>(),
      ));
  gh.factory<_i144.Iden3commRepositoryImpl>(() => _i144.Iden3commRepositoryImpl(
        get<_i97.RemoteIden3commDataSource>(),
        get<_i133.LibPolygonIdCoreIden3commDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i4.AuthResponseMapper>(),
        get<_i3.AuthInputsMapper>(),
        get<_i119.AuthProofMapper>(),
        get<_i128.GistProofMapper>(),
        get<_i92.QMapper>(),
      ));
  gh.factory<_i145.IdentityRepositoryImpl>(() => _i145.IdentityRepositoryImpl(
        get<_i112.WalletDataSource>(),
        get<_i98.RemoteIdentityDataSource>(),
        get<_i56.StorageIdentityDataSource>(),
        get<_i93.RPCDataSource>(),
        get<_i67.LocalContractFilesDataSource>(),
        get<_i63.LibBabyJubJubDataSource>(),
        get<_i134.LibPolygonIdCoreIdentityDataSource>(),
        get<_i19.EncryptionDbDataSource>(),
        get<_i17.DestinationPathDataSource>(),
        get<_i51.HexMapper>(),
        get<_i84.PrivateKeyMapper>(),
        get<_i54.IdentityDTOMapper>(),
        get<_i138.RhsNodeMapper>(),
        get<_i108.StateIdentifierMapper>(),
        get<_i137.NodeMapper>(),
        get<_i20.EncryptionKeyMapper>(),
      ));
  gh.factory<_i135.LibPolygonIdCoreProofDataSource>(() =>
      _i135.LibPolygonIdCoreProofDataSource(
          get<_i135.LibPolygonIdCoreWrapper>()));
  gh.factory<_i146.ProofRepositoryImpl>(() => _i146.ProofRepositoryImpl(
        get<_i114.WitnessDataSource>(),
        get<_i91.ProverLibDataSource>(),
        get<_i135.LibPolygonIdCoreProofDataSource>(),
        get<_i69.LocalProofFilesDataSource>(),
        get<_i85.ProofCircuitDataSource>(),
        get<_i98.RemoteIdentityDataSource>(),
        get<_i67.LocalContractFilesDataSource>(),
        get<_i10.CircuitsDownloadDataSource>(),
        get<_i93.RPCDataSource>(),
        get<_i9.CircuitTypeMapper>(),
        get<_i61.JWZProofMapper>(),
        get<_i120.ClaimMapper>(),
        get<_i102.RevocationStatusMapper>(),
        get<_i60.JWZMapper>(),
        get<_i119.AuthProofMapper>(),
        get<_i129.GistProofMapper>(),
        get<_i128.GistProofMapper>(),
      ));
  gh.factory<_i147.CheckProfileAndDidCurrentEnvUseCase>(
      () => _i147.CheckProfileAndDidCurrentEnvUseCase(
            get<_i8.CheckProfileValidityUseCase>(),
            get<_i31.GetEnvUseCase>(),
            get<_i142.GetDidIdentifierUseCase>(),
          ));
  gh.factory<_i148.GenerateProofUseCase>(() => _i148.GenerateProofUseCase(
        get<_i23.IdentityRepository>(),
        get<_i41.SMTRepository>(),
        get<_i12.ProofRepository>(),
        get<_i89.ProveUseCase>(),
        get<_i143.GetIdentityUseCase>(),
        get<_i28.GetAuthClaimUseCase>(),
        get<_i34.GetGistProofUseCase>(),
        get<_i30.GetDidUseCase>(),
        get<_i107.SignMessageUseCase>(),
        get<_i40.GetLatestStateUseCase>(),
      ));
  gh.factory<_i149.GetAuthInputsUseCase>(() => _i149.GetAuthInputsUseCase(
        get<_i143.GetIdentityUseCase>(),
        get<_i28.GetAuthClaimUseCase>(),
        get<_i107.SignMessageUseCase>(),
        get<_i34.GetGistProofUseCase>(),
        get<_i40.GetLatestStateUseCase>(),
        get<_i27.Iden3commRepository>(),
        get<_i23.IdentityRepository>(),
        get<_i41.SMTRepository>(),
      ));
  gh.factory<_i150.GetAuthTokenUseCase>(() => _i150.GetAuthTokenUseCase(
        get<_i66.LoadCircuitUseCase>(),
        get<_i39.GetJWZUseCase>(),
        get<_i26.GetAuthChallengeUseCase>(),
        get<_i149.GetAuthInputsUseCase>(),
        get<_i89.ProveUseCase>(),
      ));
  gh.factory<_i151.GetCurrentEnvDidIdentifierUseCase>(
      () => _i151.GetCurrentEnvDidIdentifierUseCase(
            get<_i31.GetEnvUseCase>(),
            get<_i142.GetDidIdentifierUseCase>(),
          ));
  gh.factory<_i152.GetInteractionsUseCase>(() => _i152.GetInteractionsUseCase(
        get<_i27.Iden3commRepository>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
        get<_i143.GetIdentityUseCase>(),
      ));
  gh.factory<_i153.GetProfilesUseCase>(() => _i153.GetProfilesUseCase(
        get<_i143.GetIdentityUseCase>(),
        get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
      ));
  gh.factory<_i154.Proof>(() => _i154.Proof(
        get<_i148.GenerateProofUseCase>(),
        get<_i18.DownloadCircuitsUseCase>(),
        get<_i11.CircuitsFilesExistUseCase>(),
        get<_i86.ProofGenerationStepsStreamManager>(),
      ));
  gh.factory<_i155.BackupIdentityUseCase>(() => _i155.BackupIdentityUseCase(
        get<_i143.GetIdentityUseCase>(),
        get<_i23.IdentityRepository>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i156.CheckIdentityValidityUseCase>(
      () => _i156.CheckIdentityValidityUseCase(
            get<_i44.GetPrivateKeyUseCase>(),
            get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factory<_i157.CreateIdentityUseCase>(() => _i157.CreateIdentityUseCase(
        get<_i47.GetPublicKeysUseCase>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i158.CreateProfilesUseCase>(() => _i158.CreateProfilesUseCase(
        get<_i47.GetPublicKeysUseCase>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i159.FetchAndSaveClaimsUseCase>(
      () => _i159.FetchAndSaveClaimsUseCase(
            get<_i49.Iden3commCredentialRepository>(),
            get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i31.GetEnvUseCase>(),
            get<_i142.GetDidIdentifierUseCase>(),
            get<_i33.GetFetchRequestsUseCase>(),
            get<_i150.GetAuthTokenUseCase>(),
            get<_i104.SaveClaimsUseCase>(),
            get<_i125.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factory<_i160.GetClaimsUseCase>(() => _i160.GetClaimsUseCase(
        get<_i29.CredentialRepository>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
        get<_i143.GetIdentityUseCase>(),
      ));
  gh.factory<_i161.GetIden3commClaimsUseCase>(
      () => _i161.GetIden3commClaimsUseCase(
            get<_i49.Iden3commCredentialRepository>(),
            get<_i160.GetClaimsUseCase>(),
            get<_i125.GetClaimRevocationStatusUseCase>(),
            get<_i111.UpdateClaimUseCase>(),
            get<_i59.IsProofCircuitSupportedUseCase>(),
            get<_i46.GetProofRequestsUseCase>(),
          ));
  gh.factory<_i162.GetIden3commProofsUseCase>(
      () => _i162.GetIden3commProofsUseCase(
            get<_i12.ProofRepository>(),
            get<_i161.GetIden3commClaimsUseCase>(),
            get<_i148.GenerateProofUseCase>(),
            get<_i59.IsProofCircuitSupportedUseCase>(),
            get<_i46.GetProofRequestsUseCase>(),
            get<_i143.GetIdentityUseCase>(),
            get<_i86.ProofGenerationStepsStreamManager>(),
          ));
  gh.factory<_i163.UpdateIdentityUseCase>(() => _i163.UpdateIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i157.CreateIdentityUseCase>(),
        get<_i143.GetIdentityUseCase>(),
      ));
  gh.factory<_i164.AddIdentityUseCase>(() => _i164.AddIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i157.CreateIdentityUseCase>(),
        get<_i122.CreateIdentityStateUseCase>(),
      ));
  gh.factory<_i165.AddNewIdentityUseCase>(() => _i165.AddNewIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i164.AddIdentityUseCase>(),
      ));
  gh.factory<_i166.AddProfileUseCase>(() => _i166.AddProfileUseCase(
        get<_i143.GetIdentityUseCase>(),
        get<_i163.UpdateIdentityUseCase>(),
        get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i158.CreateProfilesUseCase>(),
      ));
  gh.factory<_i167.AuthenticateUseCase>(() => _i167.AuthenticateUseCase(
        get<_i27.Iden3commRepository>(),
        get<_i162.GetIden3commProofsUseCase>(),
        get<_i142.GetDidIdentifierUseCase>(),
        get<_i150.GetAuthTokenUseCase>(),
        get<_i31.GetEnvUseCase>(),
        get<_i42.GetPackageNameUseCase>(),
        get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i86.ProofGenerationStepsStreamManager>(),
      ));
  gh.factory<_i168.Credential>(() => _i168.Credential(
        get<_i104.SaveClaimsUseCase>(),
        get<_i160.GetClaimsUseCase>(),
        get<_i100.RemoveClaimsUseCase>(),
        get<_i111.UpdateClaimUseCase>(),
      ));
  gh.factory<_i169.Iden3comm>(() => _i169.Iden3comm(
        get<_i159.FetchAndSaveClaimsUseCase>(),
        get<_i36.GetIden3MessageUseCase>(),
        get<_i167.AuthenticateUseCase>(),
        get<_i126.GetFiltersUseCase>(),
        get<_i161.GetIden3commClaimsUseCase>(),
        get<_i162.GetIden3commProofsUseCase>(),
        get<dynamic>(),
      ));
  gh.factory<_i170.RemoveProfileUseCase>(() => _i170.RemoveProfileUseCase(
        get<_i143.GetIdentityUseCase>(),
        get<_i163.UpdateIdentityUseCase>(),
        get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
        get<_i158.CreateProfilesUseCase>(),
        get<_i101.RemoveIdentityStateUseCase>(),
        get<_i99.RemoveAllClaimsUseCase>(),
      ));
  gh.factory<_i171.RestoreIdentityUseCase>(() => _i171.RestoreIdentityUseCase(
        get<_i164.AddIdentityUseCase>(),
        get<_i143.GetIdentityUseCase>(),
        get<_i23.IdentityRepository>(),
        get<_i151.GetCurrentEnvDidIdentifierUseCase>(),
      ));
  gh.factory<_i172.RemoveIdentityUseCase>(() => _i172.RemoveIdentityUseCase(
        get<_i23.IdentityRepository>(),
        get<_i153.GetProfilesUseCase>(),
        get<_i170.RemoveProfileUseCase>(),
        get<_i101.RemoveIdentityStateUseCase>(),
        get<_i99.RemoveAllClaimsUseCase>(),
        get<_i147.CheckProfileAndDidCurrentEnvUseCase>(),
      ));
  gh.factory<_i173.Identity>(() => _i173.Identity(
        get<_i156.CheckIdentityValidityUseCase>(),
        get<_i44.GetPrivateKeyUseCase>(),
        get<_i165.AddNewIdentityUseCase>(),
        get<_i171.RestoreIdentityUseCase>(),
        get<_i155.BackupIdentityUseCase>(),
        get<_i143.GetIdentityUseCase>(),
        get<_i37.GetIdentitiesUseCase>(),
        get<_i172.RemoveIdentityUseCase>(),
        get<_i142.GetDidIdentifierUseCase>(),
        get<_i107.SignMessageUseCase>(),
        get<_i123.FetchIdentityStateUseCase>(),
        get<_i166.AddProfileUseCase>(),
        get<_i153.GetProfilesUseCase>(),
        get<_i170.RemoveProfileUseCase>(),
      ));
  return get;
}
