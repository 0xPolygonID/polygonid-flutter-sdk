// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i78;
import 'package:encrypt/encrypt.dart' as _i17;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i14;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i46;
import 'package:sembast/sembast.dart' as _i16;
import 'package:web3dart/web3dart.dart' as _i107;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i20;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i21;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i22;
import '../../common/data/data_sources/package_info_datasource.dart' as _i47;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i38;
import '../../common/data/repositories/config_repository_impl.dart' as _i82;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i48;
import '../../common/domain/repositories/config_repository.dart' as _i97;
import '../../common/domain/repositories/package_info_repository.dart' as _i94;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i99;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i100;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i106;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i49;
import '../../credential/data/credential_repository_impl.dart' as _i98;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i88;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i92;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i63;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i81;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i12;
import '../../credential/data/mappers/claim_mapper.dart' as _i80;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i30;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i66;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i108;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i109;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i144;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i165;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i115;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i116;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i118;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i119;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i50;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i89;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i7;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i64;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i96;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i35;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i79;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i83;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i59;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i85;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i102;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i103;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i101;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i111;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i112;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i172;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i152;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i164;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i120;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i154;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i155;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i145;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i166;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i167;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i25;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i26;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i27;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i110;
import '../../iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i151;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i149;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i150;
import '../../iden3comm/domain/use_cases/interaction/update_notification_use_case.dart'
    as _i159;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i113;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i51;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i15;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i18;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i39;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i90;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i40;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i65;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i114;
import '../../identity/data/data_sources/smt_data_source.dart' as _i104;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i87;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i86;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i71;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i19;
import '../../identity/data/mappers/hash_mapper.dart' as _i28;
import '../../identity/data/mappers/hex_mapper.dart' as _i29;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i32;
import '../../identity/data/mappers/node_mapper.dart' as _i93;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i43;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i44;
import '../../identity/data/mappers/node_type_mapper.dart' as _i45;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i54;
import '../../identity/data/mappers/private_key_mapper.dart' as _i55;
import '../../identity/data/mappers/q_mapper.dart' as _i62;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i95;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i67;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i68;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i69;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i70;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i122;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i105;
import '../../identity/domain/repositories/identity_repository.dart' as _i125;
import '../../identity/domain/repositories/smt_repository.dart' as _i117;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i131;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i156;
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
    as _i157;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i175;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i141;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i124;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i52;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i11;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i91;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i41;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i56;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i61;
import '../../proof/data/data_sources/witness_data_source.dart' as _i73;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i10;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i84;
import '../../proof/data/mappers/jwz_mapper.dart' as _i36;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i37;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i42;
import '../../proof/data/mappers/proof_mapper.dart' as _i58;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i123;
import '../../proof/domain/repositories/proof_repository.dart' as _i126;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i129;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i130;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i153;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i133;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i136;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i139;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i140;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i127;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i57;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i53;
import '../../proof/libs/prover/prover.dart' as _i60;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i72;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i74;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i75;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i76;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i77;
import '../credential.dart' as _i173;
import '../iden3comm.dart' as _i174;
import '../identity.dart' as _i178;
import '../mappers/iden3_message_type_mapper.dart' as _i31;
import '../polygon_id_channel.dart' as _i8;
import '../proof.dart' as _i158;
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
  gh.factory<_i14.Client>(() => networkModule.client);
  gh.factory<_i15.CreatePathWrapper>(() => _i15.CreatePathWrapper());
  gh.lazySingletonAsync<_i16.Database>(() => databaseModule.database());
  gh.factoryParamAsync<_i16.Database, String?, String?>(
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
  gh.factory<_i15.DestinationPathDataSource>(
      () => _i15.DestinationPathDataSource(get<_i15.CreatePathWrapper>()));
  gh.factoryParam<_i17.Encrypter, _i17.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i18.EncryptionDbDataSource>(() => _i18.EncryptionDbDataSource());
  gh.factory<_i19.EncryptionKeyMapper>(() => _i19.EncryptionKeyMapper());
  gh.factory<_i20.EnvMapper>(() => _i20.EnvMapper());
  gh.factory<_i21.FilterMapper>(() => _i21.FilterMapper());
  gh.factory<_i22.FiltersMapper>(
      () => _i22.FiltersMapper(get<_i21.FilterMapper>()));
  gh.factory<_i23.GetFetchRequestsUseCase>(
      () => _i23.GetFetchRequestsUseCase());
  gh.factory<_i24.GetIden3MessageTypeUseCase>(
      () => _i24.GetIden3MessageTypeUseCase());
  gh.factory<_i25.GetIden3MessageUseCase>(() =>
      _i25.GetIden3MessageUseCase(get<_i24.GetIden3MessageTypeUseCase>()));
  gh.factory<_i26.GetProofQueryUseCase>(() => _i26.GetProofQueryUseCase());
  gh.factory<_i27.GetProofRequestsUseCase>(
      () => _i27.GetProofRequestsUseCase(get<_i26.GetProofQueryUseCase>()));
  gh.factory<_i28.HashMapper>(() => _i28.HashMapper());
  gh.factory<_i29.HexMapper>(() => _i29.HexMapper());
  gh.factory<_i30.IdFilterMapper>(() => _i30.IdFilterMapper());
  gh.factory<_i31.Iden3MessageTypeMapper>(() => _i31.Iden3MessageTypeMapper());
  gh.factory<_i32.IdentityDTOMapper>(() => _i32.IdentityDTOMapper());
  gh.factory<_i33.InteractionIdFilterMapper>(
      () => _i33.InteractionIdFilterMapper());
  gh.factory<_i34.InteractionMapper>(() => _i34.InteractionMapper());
  gh.factory<_i35.InteractionStoreRefWrapper>(() =>
      _i35.InteractionStoreRefWrapper(
          get<_i16.StoreRef<int, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i36.JWZMapper>(() => _i36.JWZMapper());
  gh.factory<_i37.JWZProofMapper>(() => _i37.JWZProofMapper());
  gh.factory<_i38.KeyValueStoreRefWrapper>(() => _i38.KeyValueStoreRefWrapper(
      get<_i16.StoreRef<String, Object?>>(instanceName: 'keyValueStore')));
  gh.factory<_i39.LibBabyJubJubDataSource>(
      () => _i39.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i40.LocalContractFilesDataSource>(
      () => _i40.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i41.LocalProofFilesDataSource>(
      () => _i41.LocalProofFilesDataSource());
  gh.factory<Map<String, _i16.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.identityStateStore,
    instanceName: 'identityStateStore',
  );
  gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
  gh.factory<_i42.NodeAuxMapper>(() => _i42.NodeAuxMapper());
  gh.factory<_i43.NodeTypeDTOMapper>(() => _i43.NodeTypeDTOMapper());
  gh.factory<_i44.NodeTypeEntityMapper>(() => _i44.NodeTypeEntityMapper());
  gh.factory<_i45.NodeTypeMapper>(() => _i45.NodeTypeMapper());
  gh.lazySingletonAsync<_i46.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i47.PackageInfoDataSource>(() async =>
      _i47.PackageInfoDataSource(await get.getAsync<_i46.PackageInfo>()));
  gh.factoryAsync<_i48.PackageInfoRepositoryImpl>(() async =>
      _i48.PackageInfoRepositoryImpl(
          await get.getAsync<_i47.PackageInfoDataSource>()));
  gh.factory<_i49.PolygonIdCore>(() => _i49.PolygonIdCore());
  gh.factory<_i50.PolygonIdCoreCredential>(
      () => _i50.PolygonIdCoreCredential());
  gh.factory<_i51.PolygonIdCoreIden3comm>(() => _i51.PolygonIdCoreIden3comm());
  gh.factory<_i52.PolygonIdCoreIdentity>(() => _i52.PolygonIdCoreIdentity());
  gh.factory<_i53.PolygonIdCoreProof>(() => _i53.PolygonIdCoreProof());
  gh.factory<_i54.PoseidonHashMapper>(
      () => _i54.PoseidonHashMapper(get<_i29.HexMapper>()));
  gh.factory<_i55.PrivateKeyMapper>(() => _i55.PrivateKeyMapper());
  gh.factory<_i56.ProofCircuitDataSource>(() => _i56.ProofCircuitDataSource());
  gh.lazySingleton<_i57.ProofGenerationStepsStreamManager>(
      () => _i57.ProofGenerationStepsStreamManager());
  gh.factory<_i58.ProofMapper>(() => _i58.ProofMapper(
        get<_i28.HashMapper>(),
        get<_i42.NodeAuxMapper>(),
      ));
  gh.factory<_i59.ProofRequestFiltersMapper>(
      () => _i59.ProofRequestFiltersMapper());
  gh.factory<_i60.ProverLib>(() => _i60.ProverLib());
  gh.factory<_i61.ProverLibWrapper>(() => _i61.ProverLibWrapper());
  gh.factory<_i62.QMapper>(() => _i62.QMapper());
  gh.factory<_i63.RemoteClaimDataSource>(
      () => _i63.RemoteClaimDataSource(get<_i14.Client>()));
  gh.factory<_i64.RemoteIden3commDataSource>(
      () => _i64.RemoteIden3commDataSource(get<_i14.Client>()));
  gh.factory<_i65.RemoteIdentityDataSource>(
      () => _i65.RemoteIdentityDataSource());
  gh.factory<_i66.RevocationStatusMapper>(() => _i66.RevocationStatusMapper());
  gh.factory<_i67.RhsNodeTypeMapper>(() => _i67.RhsNodeTypeMapper());
  gh.factoryParam<_i16.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i68.StateIdentifierMapper>(() => _i68.StateIdentifierMapper());
  gh.factoryAsync<_i35.StorageInteractionDataSource>(
      () async => _i35.StorageInteractionDataSource(
            await get.getAsync<_i16.Database>(),
            get<_i35.InteractionStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i38.StorageKeyValueDataSource>(
      () async => _i38.StorageKeyValueDataSource(
            await get.getAsync<_i16.Database>(),
            get<_i38.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i16.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
  );
  gh.factory<_i16.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i16.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i16.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i69.TreeStateMapper>(() => _i69.TreeStateMapper());
  gh.factory<_i70.TreeTypeMapper>(() => _i70.TreeTypeMapper());
  gh.factory<_i71.WalletLibWrapper>(() => _i71.WalletLibWrapper());
  gh.factory<_i72.WitnessAuthV2Lib>(() => _i72.WitnessAuthV2Lib());
  gh.factory<_i73.WitnessIsolatesWrapper>(() => _i73.WitnessIsolatesWrapper());
  gh.factory<_i74.WitnessMTPV2Lib>(() => _i74.WitnessMTPV2Lib());
  gh.factory<_i75.WitnessMTPV2OnchainLib>(() => _i75.WitnessMTPV2OnchainLib());
  gh.factory<_i76.WitnessSigV2Lib>(() => _i76.WitnessSigV2Lib());
  gh.factory<_i77.WitnessSigV2OnchainLib>(() => _i77.WitnessSigV2OnchainLib());
  gh.factory<_i78.ZipDecoder>(
    () => zipDecoderModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i79.AuthProofMapper>(() => _i79.AuthProofMapper(
        get<_i28.HashMapper>(),
        get<_i42.NodeAuxMapper>(),
      ));
  gh.factory<_i80.ClaimMapper>(() => _i80.ClaimMapper(
        get<_i13.ClaimStateMapper>(),
        get<_i12.ClaimInfoMapper>(),
      ));
  gh.factory<_i81.ClaimStoreRefWrapper>(() => _i81.ClaimStoreRefWrapper(
      get<_i16.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factoryAsync<_i82.ConfigRepositoryImpl>(
      () async => _i82.ConfigRepositoryImpl(
            await get.getAsync<_i38.StorageKeyValueDataSource>(),
            get<_i20.EnvMapper>(),
          ));
  gh.factory<_i83.GistProofMapper>(
      () => _i83.GistProofMapper(get<_i28.HashMapper>()));
  gh.factory<_i84.GistProofMapper>(
      () => _i84.GistProofMapper(get<_i58.ProofMapper>()));
  gh.factory<_i85.Iden3commCredentialRepositoryImpl>(
      () => _i85.Iden3commCredentialRepositoryImpl(
            get<_i64.RemoteIden3commDataSource>(),
            get<_i59.ProofRequestFiltersMapper>(),
            get<_i80.ClaimMapper>(),
          ));
  gh.factory<_i86.IdentitySMTStoreRefWrapper>(() =>
      _i86.IdentitySMTStoreRefWrapper(
          get<Map<String, _i16.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'identityStateStore')));
  gh.factory<_i87.IdentityStoreRefWrapper>(() => _i87.IdentityStoreRefWrapper(
      get<_i16.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i88.LibPolygonIdCoreCredentialDataSource>(() =>
      _i88.LibPolygonIdCoreCredentialDataSource(
          get<_i50.PolygonIdCoreCredential>()));
  gh.factory<_i89.LibPolygonIdCoreIden3commDataSource>(() =>
      _i89.LibPolygonIdCoreIden3commDataSource(
          get<_i51.PolygonIdCoreIden3comm>()));
  gh.factory<_i90.LibPolygonIdCoreIdentityDataSource>(() =>
      _i90.LibPolygonIdCoreIdentityDataSource(
          get<_i52.PolygonIdCoreIdentity>()));
  gh.factory<_i91.LibPolygonIdCoreWrapper>(
      () => _i91.LibPolygonIdCoreWrapper(get<_i53.PolygonIdCoreProof>()));
  gh.factory<_i92.LocalClaimDataSource>(() => _i92.LocalClaimDataSource(
      get<_i88.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i93.NodeMapper>(() => _i93.NodeMapper(
        get<_i45.NodeTypeMapper>(),
        get<_i44.NodeTypeEntityMapper>(),
        get<_i43.NodeTypeDTOMapper>(),
        get<_i28.HashMapper>(),
      ));
  gh.factoryAsync<_i94.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i48.PackageInfoRepositoryImpl>()));
  gh.factory<_i61.ProverLibDataSource>(
      () => _i61.ProverLibDataSource(get<_i61.ProverLibWrapper>()));
  gh.factory<_i95.RhsNodeMapper>(
      () => _i95.RhsNodeMapper(get<_i67.RhsNodeTypeMapper>()));
  gh.factory<_i96.SecureInteractionStoreRefWrapper>(() =>
      _i96.SecureInteractionStoreRefWrapper(
          get<_i16.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i96.SecureStorageInteractionDataSource>(() =>
      _i96.SecureStorageInteractionDataSource(
          get<_i96.SecureInteractionStoreRefWrapper>()));
  gh.factory<_i81.StorageClaimDataSource>(
      () => _i81.StorageClaimDataSource(get<_i81.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i87.StorageIdentityDataSource>(
      () async => _i87.StorageIdentityDataSource(
            await get.getAsync<_i16.Database>(),
            get<_i87.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i86.StorageSMTDataSource>(
      () => _i86.StorageSMTDataSource(get<_i86.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i71.WalletDataSource>(
      () => _i71.WalletDataSource(get<_i71.WalletLibWrapper>()));
  gh.factory<_i73.WitnessDataSource>(
      () => _i73.WitnessDataSource(get<_i73.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i97.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i82.ConfigRepositoryImpl>()));
  gh.factory<_i98.CredentialRepositoryImpl>(() => _i98.CredentialRepositoryImpl(
        get<_i63.RemoteClaimDataSource>(),
        get<_i81.StorageClaimDataSource>(),
        get<_i92.LocalClaimDataSource>(),
        get<_i80.ClaimMapper>(),
        get<_i22.FiltersMapper>(),
        get<_i30.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i99.GetEnvUseCase>(() async =>
      _i99.GetEnvUseCase(await get.getAsync<_i97.ConfigRepository>()));
  gh.factoryAsync<_i100.GetPackageNameUseCase>(() async =>
      _i100.GetPackageNameUseCase(
          await get.getAsync<_i94.PackageInfoRepository>()));
  gh.factory<_i101.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i85.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i102.Iden3commRepositoryImpl>(() => _i102.Iden3commRepositoryImpl(
        get<_i64.RemoteIden3commDataSource>(),
        get<_i89.LibPolygonIdCoreIden3commDataSource>(),
        get<_i39.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i79.AuthProofMapper>(),
        get<_i83.GistProofMapper>(),
        get<_i62.QMapper>(),
      ));
  gh.factory<_i103.InteractionRepositoryImpl>(
      () => _i103.InteractionRepositoryImpl(
            get<_i96.SecureStorageInteractionDataSource>(),
            get<_i34.InteractionMapper>(),
            get<_i22.FiltersMapper>(),
            get<_i33.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i91.LibPolygonIdCoreProofDataSource>(() =>
      _i91.LibPolygonIdCoreProofDataSource(
          get<_i91.LibPolygonIdCoreWrapper>()));
  gh.factory<_i104.SMTDataSource>(() => _i104.SMTDataSource(
        get<_i29.HexMapper>(),
        get<_i39.LibBabyJubJubDataSource>(),
        get<_i86.StorageSMTDataSource>(),
      ));
  gh.factory<_i105.SMTRepositoryImpl>(() => _i105.SMTRepositoryImpl(
        get<_i104.SMTDataSource>(),
        get<_i86.StorageSMTDataSource>(),
        get<_i39.LibBabyJubJubDataSource>(),
        get<_i93.NodeMapper>(),
        get<_i28.HashMapper>(),
        get<_i58.ProofMapper>(),
        get<_i70.TreeTypeMapper>(),
        get<_i69.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i106.SetEnvUseCase>(() async =>
      _i106.SetEnvUseCase(await get.getAsync<_i97.ConfigRepository>()));
  gh.factoryAsync<_i107.Web3Client>(() async =>
      networkModule.web3Client(await get.getAsync<_i99.GetEnvUseCase>()));
  gh.factory<_i108.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i98.CredentialRepositoryImpl>()));
  gh.factory<_i109.GetAuthClaimUseCase>(
      () => _i109.GetAuthClaimUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i110.GetVocabsUseCase>(
      () => _i110.GetVocabsUseCase(get<_i101.Iden3commCredentialRepository>()));
  gh.factory<_i111.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i102.Iden3commRepositoryImpl>()));
  gh.factory<_i112.InteractionRepository>(() => repositoriesModule
      .interactionRepository(get<_i103.InteractionRepositoryImpl>()));
  gh.factory<_i113.ListenAndStoreNotificationUseCase>(() =>
      _i113.ListenAndStoreNotificationUseCase(
          get<_i112.InteractionRepository>()));
  gh.factoryAsync<_i114.RPCDataSource>(
      () async => _i114.RPCDataSource(await get.getAsync<_i107.Web3Client>()));
  gh.factory<_i115.RemoveAllClaimsUseCase>(
      () => _i115.RemoveAllClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i116.RemoveClaimsUseCase>(
      () => _i116.RemoveClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i117.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i105.SMTRepositoryImpl>()));
  gh.factory<_i118.SaveClaimsUseCase>(
      () => _i118.SaveClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i119.UpdateClaimUseCase>(
      () => _i119.UpdateClaimUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i120.GetAuthChallengeUseCase>(
      () => _i120.GetAuthChallengeUseCase(get<_i111.Iden3commRepository>()));
  gh.factory<_i121.GetLatestStateUseCase>(
      () => _i121.GetLatestStateUseCase(get<_i117.SMTRepository>()));
  gh.factoryAsync<_i122.IdentityRepositoryImpl>(
      () async => _i122.IdentityRepositoryImpl(
            get<_i71.WalletDataSource>(),
            get<_i65.RemoteIdentityDataSource>(),
            await get.getAsync<_i87.StorageIdentityDataSource>(),
            await get.getAsync<_i114.RPCDataSource>(),
            get<_i40.LocalContractFilesDataSource>(),
            get<_i39.LibBabyJubJubDataSource>(),
            get<_i90.LibPolygonIdCoreIdentityDataSource>(),
            get<_i18.EncryptionDbDataSource>(),
            get<_i15.DestinationPathDataSource>(),
            get<_i29.HexMapper>(),
            get<_i55.PrivateKeyMapper>(),
            get<_i32.IdentityDTOMapper>(),
            get<_i95.RhsNodeMapper>(),
            get<_i68.StateIdentifierMapper>(),
            get<_i93.NodeMapper>(),
            get<_i19.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i123.ProofRepositoryImpl>(
      () async => _i123.ProofRepositoryImpl(
            get<_i73.WitnessDataSource>(),
            get<_i61.ProverLibDataSource>(),
            get<_i91.LibPolygonIdCoreProofDataSource>(),
            get<_i41.LocalProofFilesDataSource>(),
            get<_i56.ProofCircuitDataSource>(),
            get<_i65.RemoteIdentityDataSource>(),
            get<_i40.LocalContractFilesDataSource>(),
            get<_i11.CircuitsDownloadDataSource>(),
            await get.getAsync<_i114.RPCDataSource>(),
            get<_i10.CircuitTypeMapper>(),
            get<_i37.JWZProofMapper>(),
            get<_i80.ClaimMapper>(),
            get<_i66.RevocationStatusMapper>(),
            get<_i36.JWZMapper>(),
            get<_i79.AuthProofMapper>(),
            get<_i84.GistProofMapper>(),
            get<_i83.GistProofMapper>(),
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
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i134.GetIdentitiesUseCase>(() async =>
      _i134.GetIdentitiesUseCase(
          await get.getAsync<_i125.IdentityRepository>()));
  gh.factoryAsync<_i135.GetIdentityAuthClaimUseCase>(
      () async => _i135.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i109.GetAuthClaimUseCase>(),
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
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i143.GenerateNonRevProofUseCase>(
      () async => _i143.GenerateNonRevProofUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i108.CredentialRepository>(),
            await get.getAsync<_i142.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i144.GetClaimRevocationStatusUseCase>(
      () async => _i144.GetClaimRevocationStatusUseCase(
            get<_i108.CredentialRepository>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i143.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i145.GetFiltersUseCase>(() async => _i145.GetFiltersUseCase(
        get<_i101.Iden3commCredentialRepository>(),
        await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
        get<_i27.GetProofRequestsUseCase>(),
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
  gh.factoryAsync<_i149.GetInteractionsUseCase>(
      () async => _i149.GetInteractionsUseCase(
            get<_i112.InteractionRepository>(),
            get<_i9.CheckProfileValidityUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i150.RemoveInteractionsUseCase>(
      () async => _i150.RemoveInteractionsUseCase(
            get<_i112.InteractionRepository>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i151.AddInteractionUseCase>(
      () async => _i151.AddInteractionUseCase(
            get<_i112.InteractionRepository>(),
            get<_i9.CheckProfileValidityUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i152.CheckProfileAndDidCurrentEnvUseCase(
            get<_i9.CheckProfileValidityUseCase>(),
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i153.GenerateProofUseCase>(
      () async => _i153.GenerateProofUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i127.ProveUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i109.GetAuthClaimUseCase>(),
            await get.getAsync<_i133.GetGistProofUseCase>(),
            await get.getAsync<_i132.GetDidUseCase>(),
            await get.getAsync<_i128.SignMessageUseCase>(),
            get<_i121.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i154.GetAuthInputsUseCase>(
      () async => _i154.GetAuthInputsUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i109.GetAuthClaimUseCase>(),
            await get.getAsync<_i128.SignMessageUseCase>(),
            await get.getAsync<_i133.GetGistProofUseCase>(),
            get<_i121.GetLatestStateUseCase>(),
            get<_i111.Iden3commRepository>(),
            await get.getAsync<_i125.IdentityRepository>(),
            get<_i117.SMTRepository>(),
          ));
  gh.factoryAsync<_i155.GetAuthTokenUseCase>(
      () async => _i155.GetAuthTokenUseCase(
            await get.getAsync<_i140.LoadCircuitUseCase>(),
            await get.getAsync<_i136.GetJWZUseCase>(),
            get<_i120.GetAuthChallengeUseCase>(),
            await get.getAsync<_i154.GetAuthInputsUseCase>(),
            await get.getAsync<_i127.ProveUseCase>(),
          ));
  gh.factoryAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i156.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i157.GetProfilesUseCase>(
      () async => _i157.GetProfilesUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i158.Proof>(() async => _i158.Proof(
        await get.getAsync<_i153.GenerateProofUseCase>(),
        await get.getAsync<_i130.DownloadCircuitsUseCase>(),
        await get.getAsync<_i129.CircuitsFilesExistUseCase>(),
        get<_i57.ProofGenerationStepsStreamManager>(),
      ));
  gh.factoryAsync<_i159.UpdateNotificationUseCase>(
      () async => _i159.UpdateNotificationUseCase(
            get<_i112.InteractionRepository>(),
            await get.getAsync<_i151.AddInteractionUseCase>(),
          ));
  gh.factoryAsync<_i160.BackupIdentityUseCase>(
      () async => _i160.BackupIdentityUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i161.CheckIdentityValidityUseCase>(
      () async => _i161.CheckIdentityValidityUseCase(
            await get.getAsync<_i137.GetPrivateKeyUseCase>(),
            await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i162.CreateIdentityUseCase>(
      () async => _i162.CreateIdentityUseCase(
            await get.getAsync<_i138.GetPublicKeysUseCase>(),
            await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i163.CreateProfilesUseCase>(
      () async => _i163.CreateProfilesUseCase(
            await get.getAsync<_i138.GetPublicKeysUseCase>(),
            await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i164.FetchAndSaveClaimsUseCase>(
      () async => _i164.FetchAndSaveClaimsUseCase(
            get<_i101.Iden3commCredentialRepository>(),
            await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
            get<_i23.GetFetchRequestsUseCase>(),
            await get.getAsync<_i155.GetAuthTokenUseCase>(),
            get<_i118.SaveClaimsUseCase>(),
            await get.getAsync<_i144.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i165.GetClaimsUseCase>(() async => _i165.GetClaimsUseCase(
        get<_i108.CredentialRepository>(),
        await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i148.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i166.GetIden3commClaimsUseCase>(
      () async => _i166.GetIden3commClaimsUseCase(
            get<_i101.Iden3commCredentialRepository>(),
            await get.getAsync<_i165.GetClaimsUseCase>(),
            await get.getAsync<_i144.GetClaimRevocationStatusUseCase>(),
            get<_i119.UpdateClaimUseCase>(),
            await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
            get<_i27.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i167.GetIden3commProofsUseCase>(
      () async => _i167.GetIden3commProofsUseCase(
            await get.getAsync<_i126.ProofRepository>(),
            await get.getAsync<_i166.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i153.GenerateProofUseCase>(),
            await get.getAsync<_i139.IsProofCircuitSupportedUseCase>(),
            get<_i27.GetProofRequestsUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            get<_i57.ProofGenerationStepsStreamManager>(),
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
        await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i163.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i172.AuthenticateUseCase>(
      () async => _i172.AuthenticateUseCase(
            get<_i111.Iden3commRepository>(),
            await get.getAsync<_i167.GetIden3commProofsUseCase>(),
            await get.getAsync<_i147.GetDidIdentifierUseCase>(),
            await get.getAsync<_i155.GetAuthTokenUseCase>(),
            await get.getAsync<_i99.GetEnvUseCase>(),
            await get.getAsync<_i100.GetPackageNameUseCase>(),
            await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i57.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i173.Credential>(() async => _i173.Credential(
        get<_i118.SaveClaimsUseCase>(),
        await get.getAsync<_i165.GetClaimsUseCase>(),
        get<_i116.RemoveClaimsUseCase>(),
        get<_i119.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i174.Iden3comm>(() async => _i174.Iden3comm(
        await get.getAsync<_i164.FetchAndSaveClaimsUseCase>(),
        get<_i25.GetIden3MessageUseCase>(),
        await get.getAsync<_i172.AuthenticateUseCase>(),
        await get.getAsync<_i145.GetFiltersUseCase>(),
        await get.getAsync<_i166.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i167.GetIden3commProofsUseCase>(),
        await get.getAsync<_i149.GetInteractionsUseCase>(),
        await get.getAsync<_i151.AddInteractionUseCase>(),
        await get.getAsync<_i150.RemoveInteractionsUseCase>(),
        await get.getAsync<_i159.UpdateNotificationUseCase>(),
      ));
  gh.factoryAsync<_i175.RemoveProfileUseCase>(
      () async => _i175.RemoveProfileUseCase(
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i168.UpdateIdentityUseCase>(),
            await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i163.CreateProfilesUseCase>(),
            get<_i124.RemoveIdentityStateUseCase>(),
            get<_i115.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i176.RestoreIdentityUseCase>(
      () async => _i176.RestoreIdentityUseCase(
            await get.getAsync<_i169.AddIdentityUseCase>(),
            await get.getAsync<_i148.GetIdentityUseCase>(),
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i156.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i177.RemoveIdentityUseCase>(
      () async => _i177.RemoveIdentityUseCase(
            await get.getAsync<_i125.IdentityRepository>(),
            await get.getAsync<_i157.GetProfilesUseCase>(),
            await get.getAsync<_i175.RemoveProfileUseCase>(),
            get<_i124.RemoveIdentityStateUseCase>(),
            get<_i115.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i152.CheckProfileAndDidCurrentEnvUseCase>(),
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
        await get.getAsync<_i157.GetProfilesUseCase>(),
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
