// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i82;
import 'package:encrypt/encrypt.dart' as _i18;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i16;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i49;
import 'package:sembast/sembast.dart' as _i15;
import 'package:web3dart/web3dart.dart' as _i109;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i21;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i22;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i23;
import '../../common/data/data_sources/package_info_datasource.dart' as _i50;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i39;
import '../../common/data/repositories/config_repository_impl.dart' as _i85;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i51;
import '../../common/domain/repositories/config_repository.dart' as _i100;
import '../../common/domain/repositories/package_info_repository.dart' as _i98;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i102;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i103;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i108;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i52;
import '../../credential/data/credential_repository_impl.dart' as _i101;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i92;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i96;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i66;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i14;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i12;
import '../../credential/data/mappers/claim_mapper.dart' as _i84;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i31;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i69;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i110;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i111;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i144;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i165;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i115;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i116;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i118;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i119;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i53;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i93;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i7;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i67;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i71;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i36;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i83;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i87;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i62;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i88;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i105;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i91;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i104;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i113;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i42;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i172;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i149;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i164;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i120;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i151;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i152;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i145;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i166;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i167;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i25;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i26;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i27;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i28;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i112;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i154;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i157;
import '../../iden3comm/domain/use_cases/interaction/save_interaction_use_case.dart'
    as _i158;
import '../../iden3comm/domain/use_cases/interaction/update_notification_use_case.dart'
    as _i159;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i41;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i54;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i19;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i40;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i94;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i43;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i68;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i114;
import '../../identity/data/data_sources/smt_data_source.dart' as _i106;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i90;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i89;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i75;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i20;
import '../../identity/data/mappers/hash_mapper.dart' as _i29;
import '../../identity/data/mappers/hex_mapper.dart' as _i30;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i33;
import '../../identity/data/mappers/node_mapper.dart' as _i97;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i46;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i47;
import '../../identity/data/mappers/node_type_mapper.dart' as _i48;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i57;
import '../../identity/data/mappers/private_key_mapper.dart' as _i58;
import '../../identity/data/mappers/q_mapper.dart' as _i65;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i99;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i70;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i72;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i73;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i74;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i122;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i107;
import '../../identity/domain/repositories/identity_repository.dart' as _i125;
import '../../identity/domain/repositories/smt_repository.dart' as _i117;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i131;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i153;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i132;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i146;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i135;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i121;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i138;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i169;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i170;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i160;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i162;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i134;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i148;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i137;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i177;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i176;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i128;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i168;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i171;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i9;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i163;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i155;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i175;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i141;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i124;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i55;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i11;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i95;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i44;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i59;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i64;
import '../../proof/data/data_sources/witness_data_source.dart' as _i77;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i10;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i86;
import '../../proof/data/mappers/jwz_mapper.dart' as _i37;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i38;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i45;
import '../../proof/data/mappers/proof_mapper.dart' as _i61;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i123;
import '../../proof/domain/repositories/proof_repository.dart' as _i126;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i129;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i130;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i150;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i133;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i136;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i139;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i140;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i127;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i60;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i56;
import '../../proof/libs/prover/prover.dart' as _i63;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i76;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i78;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i79;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i80;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i81;
import '../credential.dart' as _i173;
import '../iden3comm.dart' as _i174;
import '../identity.dart' as _i178;
import '../mappers/iden3_message_type_mapper.dart' as _i32;
import '../polygon_id_channel.dart' as _i8;
import '../proof.dart' as _i156;
import 'injector.dart' as _i179; // ignore_for_file: unnecessary_lambdas

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
  final platformModule = _$PlatformModule();
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final encryptionModule = _$EncryptionModule();
  final channelModule = _$ChannelModule();
  final zipDecoderModule = _$ZipDecoderModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.ChannelPushNotificationDataSource>(
      () => _i7.ChannelPushNotificationDataSource(get<_i8.PolygonIdChannel>()));
  gh.factory<_i9.CheckProfileValidityUseCase>(
      () => _i9.CheckProfileValidityUseCase());
  gh.factory<_i10.CircuitTypeMapper>(() => _i10.CircuitTypeMapper());
  gh.factory<_i11.CircuitsDownloadDataSource>(
      () => _i11.CircuitsDownloadDataSource());
  gh.factory<_i12.ClaimInfoMapper>(() => _i12.ClaimInfoMapper());
  gh.factory<_i13.ClaimStateMapper>(() => _i13.ClaimStateMapper());
  gh.factory<_i14.ClaimStoreRefWrapper>(() => _i14.ClaimStoreRefWrapper(
      get<_i15.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i16.Client>(() => networkModule.client);
  gh.factory<_i17.CreatePathWrapper>(() => _i17.CreatePathWrapper());
  gh.lazySingletonAsync<_i15.Database>(() => databaseModule.database());
  gh.factoryParamAsync<_i15.Database, String?, String?>(
    (
      identifier,
      privateKey,
    ) =>
        databaseModule.identityDatabase(
      identifier,
      privateKey,
    ),
    instanceName: 'polygonIdSdkIdentity',
  );
  gh.factory<_i17.DestinationPathDataSource>(
      () => _i17.DestinationPathDataSource(get<_i17.CreatePathWrapper>()));
  gh.factoryParam<_i18.Encrypter, _i18.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i19.EncryptionDbDataSource>(() => _i19.EncryptionDbDataSource());
  gh.factory<_i20.EncryptionKeyMapper>(() => _i20.EncryptionKeyMapper());
  gh.factory<_i21.EnvMapper>(() => _i21.EnvMapper());
  gh.factory<_i22.FilterMapper>(() => _i22.FilterMapper());
  gh.factory<_i23.FiltersMapper>(
      () => _i23.FiltersMapper(get<_i22.FilterMapper>()));
  gh.factory<_i24.GetFetchRequestsUseCase>(
      () => _i24.GetFetchRequestsUseCase());
  gh.factory<_i25.GetIden3MessageTypeUseCase>(
      () => _i25.GetIden3MessageTypeUseCase());
  gh.factory<_i26.GetIden3MessageUseCase>(() =>
      _i26.GetIden3MessageUseCase(get<_i25.GetIden3MessageTypeUseCase>()));
  gh.factory<_i27.GetProofQueryUseCase>(() => _i27.GetProofQueryUseCase());
  gh.factory<_i28.GetProofRequestsUseCase>(
      () => _i28.GetProofRequestsUseCase(get<_i27.GetProofQueryUseCase>()));
  gh.factory<_i29.HashMapper>(() => _i29.HashMapper());
  gh.factory<_i30.HexMapper>(() => _i30.HexMapper());
  gh.factory<_i31.IdFilterMapper>(() => _i31.IdFilterMapper());
  gh.factory<_i32.Iden3MessageTypeMapper>(() => _i32.Iden3MessageTypeMapper());
  gh.factory<_i33.IdentityDTOMapper>(() => _i33.IdentityDTOMapper());
  gh.factory<_i34.InteractionIdFilterMapper>(
      () => _i34.InteractionIdFilterMapper());
  gh.factory<_i35.InteractionMapper>(() => _i35.InteractionMapper());
  gh.factory<_i36.InteractionStoreRefWrapper>(() =>
      _i36.InteractionStoreRefWrapper(
          get<_i15.StoreRef<int, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i37.JWZMapper>(() => _i37.JWZMapper());
  gh.factory<_i38.JWZProofMapper>(() => _i38.JWZProofMapper());
  gh.factory<_i39.KeyValueStoreRefWrapper>(() => _i39.KeyValueStoreRefWrapper(
      get<_i15.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i40.LibBabyJubJubDataSource>(
      () => _i40.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i41.ListenAndStoreNotificationUseCase>(() =>
      _i41.ListenAndStoreNotificationUseCase(
          get<_i42.InteractionRepository>()));
  gh.factory<_i43.LocalContractFilesDataSource>(
      () => _i43.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i44.LocalProofFilesDataSource>(
      () => _i44.LocalProofFilesDataSource());
  gh.factory<Map<String, _i15.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
  gh.factory<_i45.NodeAuxMapper>(() => _i45.NodeAuxMapper());
  gh.factory<_i46.NodeTypeDTOMapper>(() => _i46.NodeTypeDTOMapper());
  gh.factory<_i47.NodeTypeEntityMapper>(() => _i47.NodeTypeEntityMapper());
  gh.factory<_i48.NodeTypeMapper>(() => _i48.NodeTypeMapper());
  gh.lazySingletonAsync<_i49.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i50.PackageInfoDataSource>(() async =>
      _i50.PackageInfoDataSource(await get.getAsync<_i49.PackageInfo>()));
  gh.factoryAsync<_i51.PackageInfoRepositoryImpl>(() async =>
      _i51.PackageInfoRepositoryImpl(
          await get.getAsync<_i50.PackageInfoDataSource>()));
  gh.factory<_i52.PolygonIdCore>(() => _i52.PolygonIdCore());
  gh.factory<_i53.PolygonIdCoreCredential>(
      () => _i53.PolygonIdCoreCredential());
  gh.factory<_i54.PolygonIdCoreIden3comm>(() => _i54.PolygonIdCoreIden3comm());
  gh.factory<_i55.PolygonIdCoreIdentity>(() => _i55.PolygonIdCoreIdentity());
  gh.factory<_i56.PolygonIdCoreProof>(() => _i56.PolygonIdCoreProof());
  gh.factory<_i57.PoseidonHashMapper>(
      () => _i57.PoseidonHashMapper(get<_i30.HexMapper>()));
  gh.factory<_i58.PrivateKeyMapper>(() => _i58.PrivateKeyMapper());
  gh.factory<_i59.ProofCircuitDataSource>(() => _i59.ProofCircuitDataSource());
  gh.lazySingleton<_i60.ProofGenerationStepsStreamManager>(
      () => _i60.ProofGenerationStepsStreamManager());
  gh.factory<_i61.ProofMapper>(() => _i61.ProofMapper(
        get<_i29.HashMapper>(),
        get<_i45.NodeAuxMapper>(),
      ));
  gh.factory<_i62.ProofRequestFiltersMapper>(
      () => _i62.ProofRequestFiltersMapper());
  gh.factory<_i63.ProverLib>(() => _i63.ProverLib());
  gh.factory<_i64.ProverLibWrapper>(() => _i64.ProverLibWrapper());
  gh.factory<_i65.QMapper>(() => _i65.QMapper());
  gh.factory<_i66.RemoteClaimDataSource>(
      () => _i66.RemoteClaimDataSource(get<_i16.Client>()));
  gh.factory<_i67.RemoteIden3commDataSource>(
      () => _i67.RemoteIden3commDataSource(get<_i16.Client>()));
  gh.factory<_i68.RemoteIdentityDataSource>(
      () => _i68.RemoteIdentityDataSource());
  gh.factory<_i69.RevocationStatusMapper>(() => _i69.RevocationStatusMapper());
  gh.factory<_i70.RhsNodeTypeMapper>(() => _i70.RhsNodeTypeMapper());
  gh.factory<_i71.SecureInteractionStoreRefWrapper>(() =>
      _i71.SecureInteractionStoreRefWrapper(
          get<_i15.StoreRef<int, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i71.SecureStorageInteractionDataSource>(() =>
      _i71.SecureStorageInteractionDataSource(
          get<_i71.SecureInteractionStoreRefWrapper>()));
  gh.factoryParam<_i15.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i72.StateIdentifierMapper>(() => _i72.StateIdentifierMapper());
  gh.factory<_i14.StorageClaimDataSource>(
      () => _i14.StorageClaimDataSource(get<_i14.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i36.StorageInteractionDataSource>(
      () async => _i36.StorageInteractionDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i36.InteractionStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i39.StorageKeyValueDataSource>(
      () async => _i39.StorageKeyValueDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i39.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i15.StoreRef<String, Map<String, dynamic>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, dynamic>>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i15.StoreRef<int, Map<String, dynamic>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
  );
  gh.factory<_i73.TreeStateMapper>(() => _i73.TreeStateMapper());
  gh.factory<_i74.TreeTypeMapper>(() => _i74.TreeTypeMapper());
  gh.factory<_i75.WalletLibWrapper>(() => _i75.WalletLibWrapper());
  gh.factory<_i76.WitnessAuthV2Lib>(() => _i76.WitnessAuthV2Lib());
  gh.factory<_i77.WitnessIsolatesWrapper>(() => _i77.WitnessIsolatesWrapper());
  gh.factory<_i78.WitnessMTPV2Lib>(() => _i78.WitnessMTPV2Lib());
  gh.factory<_i79.WitnessMTPV2OnchainLib>(() => _i79.WitnessMTPV2OnchainLib());
  gh.factory<_i80.WitnessSigV2Lib>(() => _i80.WitnessSigV2Lib());
  gh.factory<_i81.WitnessSigV2OnchainLib>(() => _i81.WitnessSigV2OnchainLib());
  gh.factory<_i82.ZipDecoder>(
    () => zipDecoderModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i83.AuthProofMapper>(() => _i83.AuthProofMapper(
        get<_i29.HashMapper>(),
        get<_i45.NodeAuxMapper>(),
      ));
  gh.factory<_i84.ClaimMapper>(() => _i84.ClaimMapper(
        get<_i13.ClaimStateMapper>(),
        get<_i12.ClaimInfoMapper>(),
      ));
  gh.factoryAsync<_i85.ConfigRepositoryImpl>(
      () async => _i85.ConfigRepositoryImpl(
            await get.getAsync<_i39.StorageKeyValueDataSource>(),
            get<_i21.EnvMapper>(),
          ));
  gh.factory<_i86.GistProofMapper>(
      () => _i86.GistProofMapper(get<_i61.ProofMapper>()));
  gh.factory<_i87.GistProofMapper>(
      () => _i87.GistProofMapper(get<_i29.HashMapper>()));
  gh.factory<_i88.Iden3commCredentialRepositoryImpl>(
      () => _i88.Iden3commCredentialRepositoryImpl(
            get<_i67.RemoteIden3commDataSource>(),
            get<_i62.ProofRequestFiltersMapper>(),
            get<_i84.ClaimMapper>(),
          ));
  gh.factory<_i89.IdentitySMTStoreRefWrapper>(() =>
      _i89.IdentitySMTStoreRefWrapper(
          get<Map<String, _i15.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i90.IdentityStoreRefWrapper>(() => _i90.IdentityStoreRefWrapper(
      get<_i15.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i91.InteractionRepositoryImpl>(
      () => _i91.InteractionRepositoryImpl(
            get<_i7.ChannelPushNotificationDataSource>(),
            get<_i71.SecureStorageInteractionDataSource>(),
            get<_i35.InteractionMapper>(),
            get<_i23.FiltersMapper>(),
            get<_i34.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i92.LibPolygonIdCoreCredentialDataSource>(() =>
      _i92.LibPolygonIdCoreCredentialDataSource(
          get<_i53.PolygonIdCoreCredential>()));
  gh.factory<_i93.LibPolygonIdCoreIden3commDataSource>(() =>
      _i93.LibPolygonIdCoreIden3commDataSource(
          get<_i54.PolygonIdCoreIden3comm>()));
  gh.factory<_i94.LibPolygonIdCoreIdentityDataSource>(() =>
      _i94.LibPolygonIdCoreIdentityDataSource(
          get<_i55.PolygonIdCoreIdentity>()));
  gh.factory<_i95.LibPolygonIdCoreWrapper>(
      () => _i95.LibPolygonIdCoreWrapper(get<_i56.PolygonIdCoreProof>()));
  gh.factory<_i96.LocalClaimDataSource>(() => _i96.LocalClaimDataSource(
      get<_i92.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i97.NodeMapper>(() => _i97.NodeMapper(
        get<_i48.NodeTypeMapper>(),
        get<_i47.NodeTypeEntityMapper>(),
        get<_i46.NodeTypeDTOMapper>(),
        get<_i29.HashMapper>(),
      ));
  gh.factoryAsync<_i98.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i51.PackageInfoRepositoryImpl>()));
  gh.factory<_i64.ProverLibDataSource>(
      () => _i64.ProverLibDataSource(get<_i64.ProverLibWrapper>()));
  gh.factory<_i99.RhsNodeMapper>(
      () => _i99.RhsNodeMapper(get<_i70.RhsNodeTypeMapper>()));
  gh.factoryAsync<_i90.StorageIdentityDataSource>(
      () async => _i90.StorageIdentityDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i90.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i89.StorageSMTDataSource>(
      () => _i89.StorageSMTDataSource(get<_i89.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i75.WalletDataSource>(
      () => _i75.WalletDataSource(get<_i75.WalletLibWrapper>()));
  gh.factory<_i77.WitnessDataSource>(
      () => _i77.WitnessDataSource(get<_i77.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i100.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i85.ConfigRepositoryImpl>()));
  gh.factory<_i101.CredentialRepositoryImpl>(
      () => _i101.CredentialRepositoryImpl(
            get<_i66.RemoteClaimDataSource>(),
            get<_i14.StorageClaimDataSource>(),
            get<_i96.LocalClaimDataSource>(),
            get<_i84.ClaimMapper>(),
            get<_i23.FiltersMapper>(),
            get<_i31.IdFilterMapper>(),
          ));
  gh.factoryAsync<_i102.GetEnvUseCase>(() async =>
      _i102.GetEnvUseCase(await get.getAsync<_i100.ConfigRepository>()));
  gh.factoryAsync<_i103.GetPackageNameUseCase>(() async =>
      _i103.GetPackageNameUseCase(
          await get.getAsync<_i98.PackageInfoRepository>()));
  gh.factory<_i104.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i88.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i105.Iden3commRepositoryImpl>(() => _i105.Iden3commRepositoryImpl(
        get<_i67.RemoteIden3commDataSource>(),
        get<_i93.LibPolygonIdCoreIden3commDataSource>(),
        get<_i40.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i83.AuthProofMapper>(),
        get<_i87.GistProofMapper>(),
        get<_i65.QMapper>(),
      ));
  gh.factory<_i95.LibPolygonIdCoreProofDataSource>(() =>
      _i95.LibPolygonIdCoreProofDataSource(
          get<_i95.LibPolygonIdCoreWrapper>()));
  gh.factory<_i106.SMTDataSource>(() => _i106.SMTDataSource(
        get<_i30.HexMapper>(),
        get<_i40.LibBabyJubJubDataSource>(),
        get<_i89.StorageSMTDataSource>(),
      ));
  gh.factory<_i107.SMTRepositoryImpl>(() => _i107.SMTRepositoryImpl(
        get<_i106.SMTDataSource>(),
        get<_i89.StorageSMTDataSource>(),
        get<_i40.LibBabyJubJubDataSource>(),
        get<_i97.NodeMapper>(),
        get<_i29.HashMapper>(),
        get<_i61.ProofMapper>(),
        get<_i74.TreeTypeMapper>(),
        get<_i73.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i108.SetEnvUseCase>(() async =>
      _i108.SetEnvUseCase(await get.getAsync<_i100.ConfigRepository>()));
  gh.factoryAsync<_i109.Web3Client>(() async =>
      networkModule.web3Client(await get.getAsync<_i102.GetEnvUseCase>()));
  gh.factory<_i110.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i101.CredentialRepositoryImpl>()));
  gh.factory<_i111.GetAuthClaimUseCase>(
      () => _i111.GetAuthClaimUseCase(get<_i110.CredentialRepository>()));
  gh.factory<_i112.GetVocabsUseCase>(
      () => _i112.GetVocabsUseCase(get<_i104.Iden3commCredentialRepository>()));
  gh.factory<_i113.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i105.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i114.RPCDataSource>(
      () async => _i114.RPCDataSource(await get.getAsync<_i109.Web3Client>()));
  gh.factory<_i115.RemoveAllClaimsUseCase>(
      () => _i115.RemoveAllClaimsUseCase(get<_i110.CredentialRepository>()));
  gh.factory<_i116.RemoveClaimsUseCase>(
      () => _i116.RemoveClaimsUseCase(get<_i110.CredentialRepository>()));
  gh.factory<_i117.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i107.SMTRepositoryImpl>()));
  gh.factory<_i118.SaveClaimsUseCase>(
      () => _i118.SaveClaimsUseCase(get<_i110.CredentialRepository>()));
  gh.factory<_i119.UpdateClaimUseCase>(
      () => _i119.UpdateClaimUseCase(get<_i110.CredentialRepository>()));
  gh.factory<_i120.GetAuthChallengeUseCase>(
      () => _i120.GetAuthChallengeUseCase(get<_i113.Iden3commRepository>()));
  gh.factory<_i121.GetLatestStateUseCase>(
      () => _i121.GetLatestStateUseCase(get<_i117.SMTRepository>()));
  gh.factoryAsync<_i122.IdentityRepositoryImpl>(
      () async => _i122.IdentityRepositoryImpl(
            get<_i75.WalletDataSource>(),
            get<_i68.RemoteIdentityDataSource>(),
            await get.getAsync<_i90.StorageIdentityDataSource>(),
            await get.getAsync<_i114.RPCDataSource>(),
            get<_i43.LocalContractFilesDataSource>(),
            get<_i40.LibBabyJubJubDataSource>(),
            get<_i94.LibPolygonIdCoreIdentityDataSource>(),
            get<_i19.EncryptionDbDataSource>(),
            get<_i17.DestinationPathDataSource>(),
            get<_i30.HexMapper>(),
            get<_i58.PrivateKeyMapper>(),
            get<_i33.IdentityDTOMapper>(),
            get<_i99.RhsNodeMapper>(),
            get<_i72.StateIdentifierMapper>(),
            get<_i97.NodeMapper>(),
            get<_i20.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i123.ProofRepositoryImpl>(
      () async => _i123.ProofRepositoryImpl(
            get<_i77.WitnessDataSource>(),
            get<_i64.ProverLibDataSource>(),
            get<_i95.LibPolygonIdCoreProofDataSource>(),
            get<_i44.LocalProofFilesDataSource>(),
            get<_i59.ProofCircuitDataSource>(),
            get<_i68.RemoteIdentityDataSource>(),
            get<_i43.LocalContractFilesDataSource>(),
            get<_i11.CircuitsDownloadDataSource>(),
            await get.getAsync<_i114.RPCDataSource>(),
            get<_i10.CircuitTypeMapper>(),
            get<_i38.JWZProofMapper>(),
            get<_i84.ClaimMapper>(),
            get<_i69.RevocationStatusMapper>(),
            get<_i37.JWZMapper>(),
            get<_i83.AuthProofMapper>(),
            get<_i86.GistProofMapper>(),
            get<_i87.GistProofMapper>(),
          ));
  gh.factory<_i124.RemoveIdentityStateUseCase>(
      () => _i124.RemoveIdentityStateUseCase(get<_i117.SMTRepository>()));
  gh.factoryAsync<_i125.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i122.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i126.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i123.ProofRepositoryImpl>()));
  gh.factoryAsync<_i127.ProveUseCase>(() async =>
      _i127.ProveUseCase(await get.getAsync<_i126.ProofRepository>()));
  gh.factoryAsync<_i128.SignMessageUseCase>(() async =>
      _i128.SignMessageUseCase(await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i129.CircuitsFilesExistUseCase>(() async =>
      _i129.CircuitsFilesExistUseCase(
          await get.getAsync<_i126.ProofRepository>()));
  gh.factoryAsync<_i130.DownloadCircuitsUseCase>(
      () async => _i130.DownloadCircuitsUseCase(
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i129.CircuitsFilesExistUseCase>(),
          ));
  gh.factoryAsync<_i131.FetchStateRootsUseCase>(() async =>
      _i131.FetchStateRootsUseCase(
          await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i132.GetDidUseCase>(() async =>
      _i132.GetDidUseCase(await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i133.GetGistProofUseCase>(
      () async => _i133.GetGistProofUseCase(
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i134.GetIdentitiesUseCase>(() async =>
      _i134.GetIdentitiesUseCase(
          await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i135.GetIdentityAuthClaimUseCase>(
      () async => _i135.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i111.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i136.GetJWZUseCase>(() async =>
      _i136.GetJWZUseCase(await get.getAsync<_i126.ProofRepository>()));
  gh.factoryAsync<_i137.GetPrivateKeyUseCase>(() async =>
      _i137.GetPrivateKeyUseCase(
          await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i138.GetPublicKeysUseCase>(() async =>
      _i138.GetPublicKeysUseCase(
          await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i139.IsProofCircuitSupportedUseCase>(() async =>
      _i139.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i126.ProofRepository>()));
  gh.factoryAsync<_i140.LoadCircuitUseCase>(() async =>
      _i140.LoadCircuitUseCase(await get.getAsync<_i126.ProofRepository>()));
  gh.factoryAsync<_i141.CreateIdentityStateUseCase>(
      () async => _i141.CreateIdentityStateUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
            await get.getAsync<_i135.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i142.FetchIdentityStateUseCase>(
      () async => _i142.FetchIdentityStateUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i143.GenerateNonRevProofUseCase>(
      () async => _i143.GenerateNonRevProofUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i110.CredentialRepository>(),
            await get.getAsync<_i142.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i144.GetClaimRevocationStatusUseCase>(
      () async => _i144.GetClaimRevocationStatusUseCase(
            get<_i110.CredentialRepository>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i143.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i145.GetFiltersUseCase>(() async => _i145.GetFiltersUseCase(
        get<_i104.Iden3commCredentialRepository>(),
        await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
        get<_i28.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i146.GetGenesisStateUseCase>(
      () async => _i146.GetGenesisStateUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
            await get.getAsync<_i135.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i147.GetDidIdentifierUseCase>(
      () async => _i147.GetDidIdentifierUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i146.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i148.GetIdentityUseCase>(
      () async => _i148.GetIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i132.GetDidUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i149.CheckProfileAndDidCurrentEnvUseCase(
            get<_i9.CheckProfileValidityUseCase>(),
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i150.GenerateProofUseCase>(
      () async => _i150.GenerateProofUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i127.ProveUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i111.GetAuthClaimUseCase>(),
            await get.getAsync<_i133.GetGistProofUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
            await get.getAsync<_i128.SignMessageUseCase>(),
            get<_i121.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i151.GetAuthInputsUseCase>(
      () async => _i151.GetAuthInputsUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i111.GetAuthClaimUseCase>(),
            await get.getAsync<_i128.SignMessageUseCase>(),
            await get.getAsync<_i133.GetGistProofUseCase>(),
            get<_i121.GetLatestStateUseCase>(),
            get<_i113.Iden3commRepository>(),
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
          ));
  gh.factoryAsync<_i152.GetAuthTokenUseCase>(
      () async => _i152.GetAuthTokenUseCase(
            await get.getAsync<_i140.LoadCircuitUseCase>(),
            await get.getAsync<_i136.GetJWZUseCase>(),
            get<_i120.GetAuthChallengeUseCase>(),
            await get.getAsync<_i151.GetAuthInputsUseCase>(),
            await get.getAsync<_i127.ProveUseCase>(),
          ));
  gh.factoryAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i153.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i154.GetInteractionsUseCase>(
      () async => _i154.GetInteractionsUseCase(
            get<_i42.InteractionRepository>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i155.GetProfilesUseCase>(
      () async => _i155.GetProfilesUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i156.Proof>(() async => _i156.Proof(
        await get.getAsync<_i150.GenerateProofUseCase>(),
        await get.getAsync<_i130.DownloadCircuitsUseCase>(),
        await get.getAsync<_i129.CircuitsFilesExistUseCase>(),
        get<_i60.ProofGenerationStepsStreamManager>(),
      ));
  gh.factoryAsync<_i157.RemoveInteractionsUseCase>(
      () async => _i157.RemoveInteractionsUseCase(
            get<_i42.InteractionRepository>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i158.SaveInteractionUseCase>(
      () async => _i158.SaveInteractionUseCase(
            get<_i42.InteractionRepository>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i159.UpdateNotificationUseCase>(
      () async => _i159.UpdateNotificationUseCase(
            get<_i42.InteractionRepository>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i158.SaveInteractionUseCase>(),
          ));
  gh.factoryAsync<_i160.BackupIdentityUseCase>(
      () async => _i160.BackupIdentityUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i161.CheckIdentityValidityUseCase>(
      () async => _i161.CheckIdentityValidityUseCase(
            await get.getAsync<_i137.GetPrivateKeyUseCase>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i162.CreateIdentityUseCase>(
      () async => _i162.CreateIdentityUseCase(
            await get.getAsync<_i138.GetPublicKeysUseCase>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i163.CreateProfilesUseCase>(
      () async => _i163.CreateProfilesUseCase(
            await get.getAsync<_i138.GetPublicKeysUseCase>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i164.FetchAndSaveClaimsUseCase>(
      () async => _i164.FetchAndSaveClaimsUseCase(
            get<_i104.Iden3commCredentialRepository>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
            get<_i24.GetFetchRequestsUseCase>(),
            await get.getAsync<_i152.GetAuthTokenUseCase>(),
            get<_i118.SaveClaimsUseCase>(),
            await get.getAsync<_i144.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i165.GetClaimsUseCase>(() async => _i165.GetClaimsUseCase(
        get<_i110.CredentialRepository>(),
        await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i148.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i166.GetIden3commClaimsUseCase>(
      () async => _i166.GetIden3commClaimsUseCase(
            get<_i104.Iden3commCredentialRepository>(),
            await get.getAsync<_i165.GetClaimsUseCase>(),
            await get.getAsync<_i144.GetClaimRevocationStatusUseCase>(),
            get<_i119.UpdateClaimUseCase>(),
            await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
            get<_i28.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i167.GetIden3commProofsUseCase>(
      () async => _i167.GetIden3commProofsUseCase(
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i166.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i150.GenerateProofUseCase>(),
            await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
            get<_i28.GetProofRequestsUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i60.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i168.UpdateIdentityUseCase>(
      () async => _i168.UpdateIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i162.CreateIdentityUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i169.AddIdentityUseCase>(
      () async => _i169.AddIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i162.CreateIdentityUseCase>(),
            await get.getAsync<_i141.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i170.AddNewIdentityUseCase>(
      () async => _i170.AddNewIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i169.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i171.AddProfileUseCase>(() async => _i171.AddProfileUseCase(
        await get.getAsync<_i148.GetIdentityUseCase>(),
        await get.getAsync<_i168.UpdateIdentityUseCase>(),
        await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i163.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i172.AuthenticateUseCase>(
      () async => _i172.AuthenticateUseCase(
            get<_i113.Iden3commRepository>(),
            await get.getAsync<_i167.GetIden3commProofsUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
            await get.getAsync<_i152.GetAuthTokenUseCase>(),
            await get.getAsync<_i102.GetEnvUseCase>(),
            await get.getAsync<_i103.GetPackageNameUseCase>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i60.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i173.Credential>(() async => _i173.Credential(
        get<_i118.SaveClaimsUseCase>(),
        await get.getAsync<_i165.GetClaimsUseCase>(),
        get<_i116.RemoveClaimsUseCase>(),
        get<_i119.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i174.Iden3comm>(() async => _i174.Iden3comm(
        await get.getAsync<_i164.FetchAndSaveClaimsUseCase>(),
        get<_i26.GetIden3MessageUseCase>(),
        await get.getAsync<_i172.AuthenticateUseCase>(),
        await get.getAsync<_i145.GetFiltersUseCase>(),
        await get.getAsync<_i166.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i167.GetIden3commProofsUseCase>(),
        await get.getAsync<_i154.GetInteractionsUseCase>(),
        await get.getAsync<_i158.SaveInteractionUseCase>(),
        await get.getAsync<_i157.RemoveInteractionsUseCase>(),
        await get.getAsync<_i159.UpdateNotificationUseCase>(),
      ));
  gh.factoryAsync<_i175.RemoveProfileUseCase>(
      () async => _i175.RemoveProfileUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i168.UpdateIdentityUseCase>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i163.CreateProfilesUseCase>(),
            get<_i124.RemoveIdentityStateUseCase>(),
            get<_i115.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i176.RestoreIdentityUseCase>(
      () async => _i176.RestoreIdentityUseCase(
            await get.getAsync<_i169.AddIdentityUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i153.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i177.RemoveIdentityUseCase>(
      () async => _i177.RemoveIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i155.GetProfilesUseCase>(),
            await get.getAsync<_i175.RemoveProfileUseCase>(),
            get<_i124.RemoveIdentityStateUseCase>(),
            get<_i115.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i149.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i178.Identity>(() async => _i178.Identity(
        await get.getAsync<_i161.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i137.GetPrivateKeyUseCase>(),
        await get.getAsync<_i170.AddNewIdentityUseCase>(),
        await get.getAsync<_i176.RestoreIdentityUseCase>(),
        await get.getAsync<_i160.BackupIdentityUseCase>(),
        await get.getAsync<_i148.GetIdentityUseCase>(),
        await get.getAsync<_i134.GetIdentitiesUseCase>(),
        await get.getAsync<_i177.RemoveIdentityUseCase>(),
        await get.getAsync<_i147.GetDidIdentifierUseCase>(),
        await get.getAsync<_i128.SignMessageUseCase>(),
        await get.getAsync<_i142.FetchIdentityStateUseCase>(),
        await get.getAsync<_i171.AddProfileUseCase>(),
        await get.getAsync<_i155.GetProfilesUseCase>(),
        await get.getAsync<_i175.RemoveProfileUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i179.PlatformModule {}

class _$NetworkModule extends _i179.NetworkModule {}

class _$DatabaseModule extends _i179.DatabaseModule {}

class _$EncryptionModule extends _i179.EncryptionModule {}

class _$ChannelModule extends _i179.ChannelModule {}

class _$ZipDecoderModule extends _i179.ZipDecoderModule {}

class _$RepositoriesModule extends _i179.RepositoriesModule {}
