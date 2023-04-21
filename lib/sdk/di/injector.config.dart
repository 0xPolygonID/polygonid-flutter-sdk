// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i78;
import 'package:encrypt/encrypt.dart' as _i16;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i43;
import 'package:sembast/sembast.dart' as _i15;
import 'package:web3dart/web3dart.dart' as _i70;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i19;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i20;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i21;
import '../../common/data/data_sources/package_info_datasource.dart' as _i44;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i88;
import '../../common/data/repositories/config_repository_impl.dart' as _i99;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i45;
import '../../common/domain/entities/env_entity.dart' as _i71;
import '../../common/domain/repositories/config_repository.dart' as _i107;
import '../../common/domain/repositories/package_info_repository.dart' as _i95;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i110;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i101;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i120;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i46;
import '../../credential/data/credential_repository_impl.dart' as _i100;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i89;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i93;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i61;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i81;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i11;
import '../../credential/data/mappers/claim_mapper.dart' as _i80;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i29;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i64;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i108;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i109;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i146;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i167;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i116;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i117;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i119;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i121;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i47;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i90;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i7;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i62;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i98;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i87;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i79;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i82;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i57;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i84;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i103;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i104;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i102;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i112;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i113;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i174;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i154;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i166;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i122;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i156;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i157;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i147;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i168;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i169;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i25;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i26;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i111;
import '../../iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i153;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i151;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i152;
import '../../iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i161;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i114;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i48;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i14;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i36;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i91;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i37;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i115;
import '../../identity/data/data_sources/smt_data_source.dart' as _i105;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i86;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i85;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i69;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i18;
import '../../identity/data/mappers/hash_mapper.dart' as _i27;
import '../../identity/data/mappers/hex_mapper.dart' as _i28;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i31;
import '../../identity/data/mappers/node_mapper.dart' as _i94;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i40;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i41;
import '../../identity/data/mappers/node_type_mapper.dart' as _i42;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i52;
import '../../identity/data/mappers/private_key_mapper.dart' as _i53;
import '../../identity/data/mappers/q_mapper.dart' as _i60;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i97;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i65;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i66;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i67;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i68;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i124;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i106;
import '../../identity/domain/repositories/identity_repository.dart' as _i127;
import '../../identity/domain/repositories/smt_repository.dart' as _i118;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i144;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i133;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i145;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i149;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i134;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i148;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i137;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i123;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i140;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i171;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i172;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i162;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i163;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i164;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i136;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i150;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i139;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i179;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i178;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i130;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i170;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i173;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i8;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i159;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i177;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i126;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i49;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i10;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i92;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i38;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i54;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i59;
import '../../proof/data/data_sources/witness_data_source.dart' as _i73;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i9;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i83;
import '../../proof/data/mappers/jwz_mapper.dart' as _i34;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i35;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i39;
import '../../proof/data/mappers/proof_mapper.dart' as _i56;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i125;
import '../../proof/domain/repositories/proof_repository.dart' as _i128;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i131;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i132;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i155;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i135;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i138;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i141;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i142;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i129;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i55;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i50;
import '../../proof/libs/prover/prover.dart' as _i58;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i72;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i74;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i75;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i76;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i77;
import '../credential.dart' as _i175;
import '../iden3comm.dart' as _i176;
import '../identity.dart' as _i180;
import '../mappers/iden3_message_type_mapper.dart' as _i30;
import '../polygon_id_sdk.dart' as _i51;
import '../polygonid_flutter_channel.dart' as _i96;
import '../proof.dart' as _i160;
import 'injector.dart' as _i181; // ignore_for_file: unnecessary_lambdas

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
      () => _i7.ChannelPushNotificationDataSource());
  gh.factory<_i8.CheckProfileValidityUseCase>(
      () => _i8.CheckProfileValidityUseCase());
  gh.factory<_i9.CircuitTypeMapper>(() => _i9.CircuitTypeMapper());
  gh.factory<_i10.CircuitsDownloadDataSource>(
      () => _i10.CircuitsDownloadDataSource());
  gh.factory<_i11.ClaimInfoMapper>(() => _i11.ClaimInfoMapper());
  gh.factory<_i12.ClaimStateMapper>(() => _i12.ClaimStateMapper());
  gh.factory<_i13.Client>(() => networkModule.client);
  gh.factory<_i14.CreatePathWrapper>(() => _i14.CreatePathWrapper());
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
  gh.lazySingletonAsync<_i15.Database>(() => databaseModule.database());
  gh.factory<_i14.DestinationPathDataSource>(
      () => _i14.DestinationPathDataSource(get<_i14.CreatePathWrapper>()));
  gh.factoryParam<_i16.Encrypter, _i16.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i17.EncryptionDbDataSource>(() => _i17.EncryptionDbDataSource());
  gh.factory<_i18.EncryptionKeyMapper>(() => _i18.EncryptionKeyMapper());
  gh.factory<_i19.EnvMapper>(() => _i19.EnvMapper());
  gh.factory<_i20.FilterMapper>(() => _i20.FilterMapper());
  gh.factory<_i21.FiltersMapper>(
      () => _i21.FiltersMapper(get<_i20.FilterMapper>()));
  gh.factory<_i22.GetFetchRequestsUseCase>(
      () => _i22.GetFetchRequestsUseCase());
  gh.factory<_i23.GetIden3MessageTypeUseCase>(
      () => _i23.GetIden3MessageTypeUseCase());
  gh.factory<_i24.GetIden3MessageUseCase>(() =>
      _i24.GetIden3MessageUseCase(get<_i23.GetIden3MessageTypeUseCase>()));
  gh.factory<_i25.GetProofQueryUseCase>(() => _i25.GetProofQueryUseCase());
  gh.factory<_i26.GetProofRequestsUseCase>(
      () => _i26.GetProofRequestsUseCase(get<_i25.GetProofQueryUseCase>()));
  gh.factory<_i27.HashMapper>(() => _i27.HashMapper());
  gh.factory<_i28.HexMapper>(() => _i28.HexMapper());
  gh.factory<_i29.IdFilterMapper>(() => _i29.IdFilterMapper());
  gh.factory<_i30.Iden3MessageTypeMapper>(() => _i30.Iden3MessageTypeMapper());
  gh.factory<_i31.IdentityDTOMapper>(() => _i31.IdentityDTOMapper());
  gh.factory<_i32.InteractionIdFilterMapper>(
      () => _i32.InteractionIdFilterMapper());
  gh.factory<_i33.InteractionMapper>(() => _i33.InteractionMapper());
  gh.factory<_i34.JWZMapper>(() => _i34.JWZMapper());
  gh.factory<_i35.JWZProofMapper>(() => _i35.JWZProofMapper());
  gh.factory<_i36.LibBabyJubJubDataSource>(
      () => _i36.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i37.LocalContractFilesDataSource>(
      () => _i37.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i38.LocalProofFilesDataSource>(
      () => _i38.LocalProofFilesDataSource());
  gh.factory<Map<String, _i15.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.identityStateStore,
    instanceName: 'identityStateStore',
  );
  gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
  gh.factory<_i39.NodeAuxMapper>(() => _i39.NodeAuxMapper());
  gh.factory<_i40.NodeTypeDTOMapper>(() => _i40.NodeTypeDTOMapper());
  gh.factory<_i41.NodeTypeEntityMapper>(() => _i41.NodeTypeEntityMapper());
  gh.factory<_i42.NodeTypeMapper>(() => _i42.NodeTypeMapper());
  gh.lazySingletonAsync<_i43.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i44.PackageInfoDataSource>(() async =>
      _i44.PackageInfoDataSource(await get.getAsync<_i43.PackageInfo>()));
  gh.factoryAsync<_i45.PackageInfoRepositoryImpl>(() async =>
      _i45.PackageInfoRepositoryImpl(
          await get.getAsync<_i44.PackageInfoDataSource>()));
  gh.factory<_i46.PolygonIdCore>(() => _i46.PolygonIdCore());
  gh.factory<_i47.PolygonIdCoreCredential>(
      () => _i47.PolygonIdCoreCredential());
  gh.factory<_i48.PolygonIdCoreIden3comm>(() => _i48.PolygonIdCoreIden3comm());
  gh.factory<_i49.PolygonIdCoreIdentity>(() => _i49.PolygonIdCoreIdentity());
  gh.factory<_i50.PolygonIdCoreProof>(() => _i50.PolygonIdCoreProof());
  gh.factory<_i51.PolygonIdSdk>(() => channelModule.polygonIdSdk);
  gh.factory<_i52.PoseidonHashMapper>(
      () => _i52.PoseidonHashMapper(get<_i28.HexMapper>()));
  gh.factory<_i53.PrivateKeyMapper>(() => _i53.PrivateKeyMapper());
  gh.factory<_i54.ProofCircuitDataSource>(() => _i54.ProofCircuitDataSource());
  gh.lazySingleton<_i55.ProofGenerationStepsStreamManager>(
      () => _i55.ProofGenerationStepsStreamManager());
  gh.factory<_i56.ProofMapper>(() => _i56.ProofMapper(
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.factory<_i57.ProofRequestFiltersMapper>(
      () => _i57.ProofRequestFiltersMapper());
  gh.factory<_i58.ProverLib>(() => _i58.ProverLib());
  gh.factory<_i59.ProverLibWrapper>(() => _i59.ProverLibWrapper());
  gh.factory<_i60.QMapper>(() => _i60.QMapper());
  gh.factory<_i61.RemoteClaimDataSource>(
      () => _i61.RemoteClaimDataSource(get<_i13.Client>()));
  gh.factory<_i62.RemoteIden3commDataSource>(
      () => _i62.RemoteIden3commDataSource(get<_i13.Client>()));
  gh.factory<_i63.RemoteIdentityDataSource>(
      () => _i63.RemoteIdentityDataSource());
  gh.factory<_i64.RevocationStatusMapper>(() => _i64.RevocationStatusMapper());
  gh.factory<_i65.RhsNodeTypeMapper>(() => _i65.RhsNodeTypeMapper());
  gh.factoryParam<_i15.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i66.StateIdentifierMapper>(() => _i66.StateIdentifierMapper());
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i15.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i67.TreeStateMapper>(() => _i67.TreeStateMapper());
  gh.factory<_i68.TreeTypeMapper>(() => _i68.TreeTypeMapper());
  gh.factory<_i69.WalletLibWrapper>(() => _i69.WalletLibWrapper());
  gh.factoryParam<_i70.Web3Client, _i71.EnvEntity, dynamic>((
    env,
    _,
  ) =>
      networkModule.web3client(env));
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
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.factory<_i80.ClaimMapper>(() => _i80.ClaimMapper(
        get<_i12.ClaimStateMapper>(),
        get<_i11.ClaimInfoMapper>(),
      ));
  gh.factory<_i81.ClaimStoreRefWrapper>(() => _i81.ClaimStoreRefWrapper(
      get<_i15.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i82.GistProofMapper>(
      () => _i82.GistProofMapper(get<_i27.HashMapper>()));
  gh.factory<_i83.GistProofMapper>(
      () => _i83.GistProofMapper(get<_i56.ProofMapper>()));
  gh.factory<_i84.Iden3commCredentialRepositoryImpl>(
      () => _i84.Iden3commCredentialRepositoryImpl(
            get<_i62.RemoteIden3commDataSource>(),
            get<_i57.ProofRequestFiltersMapper>(),
            get<_i80.ClaimMapper>(),
          ));
  gh.factory<_i85.IdentitySMTStoreRefWrapper>(() =>
      _i85.IdentitySMTStoreRefWrapper(
          get<Map<String, _i15.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'identityStateStore')));
  gh.factory<_i86.IdentityStoreRefWrapper>(() => _i86.IdentityStoreRefWrapper(
      get<_i15.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i87.InteractionStoreRefWrapper>(() =>
      _i87.InteractionStoreRefWrapper(
          get<_i15.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i88.KeyValueStoreRefWrapper>(() => _i88.KeyValueStoreRefWrapper(
      get<_i15.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i89.LibPolygonIdCoreCredentialDataSource>(() =>
      _i89.LibPolygonIdCoreCredentialDataSource(
          get<_i47.PolygonIdCoreCredential>()));
  gh.factory<_i90.LibPolygonIdCoreIden3commDataSource>(() =>
      _i90.LibPolygonIdCoreIden3commDataSource(
          get<_i48.PolygonIdCoreIden3comm>()));
  gh.factory<_i91.LibPolygonIdCoreIdentityDataSource>(() =>
      _i91.LibPolygonIdCoreIdentityDataSource(
          get<_i49.PolygonIdCoreIdentity>()));
  gh.factory<_i92.LibPolygonIdCoreWrapper>(
      () => _i92.LibPolygonIdCoreWrapper(get<_i50.PolygonIdCoreProof>()));
  gh.factory<_i93.LocalClaimDataSource>(() => _i93.LocalClaimDataSource(
      get<_i89.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i94.NodeMapper>(() => _i94.NodeMapper(
        get<_i42.NodeTypeMapper>(),
        get<_i41.NodeTypeEntityMapper>(),
        get<_i40.NodeTypeDTOMapper>(),
        get<_i27.HashMapper>(),
      ));
  gh.factoryAsync<_i95.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i45.PackageInfoRepositoryImpl>()));
  gh.factory<_i96.PolygonIdFlutterChannel>(() => _i96.PolygonIdFlutterChannel(
        get<_i51.PolygonIdSdk>(),
        get<_i3.MethodChannel>(),
      ));
  gh.factory<_i59.ProverLibDataSource>(
      () => _i59.ProverLibDataSource(get<_i59.ProverLibWrapper>()));
  gh.factory<_i97.RhsNodeMapper>(
      () => _i97.RhsNodeMapper(get<_i65.RhsNodeTypeMapper>()));
  gh.factory<_i98.SecureInteractionStoreRefWrapper>(() =>
      _i98.SecureInteractionStoreRefWrapper(
          get<_i15.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i98.SecureStorageInteractionDataSource>(() =>
      _i98.SecureStorageInteractionDataSource(
          get<_i98.SecureInteractionStoreRefWrapper>()));
  gh.factory<_i81.StorageClaimDataSource>(
      () => _i81.StorageClaimDataSource(get<_i81.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i86.StorageIdentityDataSource>(
      () async => _i86.StorageIdentityDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i86.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i87.StorageInteractionDataSource>(
      () async => _i87.StorageInteractionDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i87.InteractionStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i88.StorageKeyValueDataSource>(
      () async => _i88.StorageKeyValueDataSource(
            await get.getAsync<_i15.Database>(),
            get<_i88.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i85.StorageSMTDataSource>(
      () => _i85.StorageSMTDataSource(get<_i85.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i69.WalletDataSource>(
      () => _i69.WalletDataSource(get<_i69.WalletLibWrapper>()));
  gh.factory<_i73.WitnessDataSource>(
      () => _i73.WitnessDataSource(get<_i73.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i99.ConfigRepositoryImpl>(
      () async => _i99.ConfigRepositoryImpl(
            await get.getAsync<_i88.StorageKeyValueDataSource>(),
            get<_i19.EnvMapper>(),
          ));
  gh.factory<_i100.CredentialRepositoryImpl>(
      () => _i100.CredentialRepositoryImpl(
            get<_i61.RemoteClaimDataSource>(),
            get<_i81.StorageClaimDataSource>(),
            get<_i93.LocalClaimDataSource>(),
            get<_i80.ClaimMapper>(),
            get<_i21.FiltersMapper>(),
            get<_i29.IdFilterMapper>(),
          ));
  gh.factoryAsync<_i101.GetPackageNameUseCase>(() async =>
      _i101.GetPackageNameUseCase(
          await get.getAsync<_i95.PackageInfoRepository>()));
  gh.factory<_i102.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i84.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i103.Iden3commRepositoryImpl>(() => _i103.Iden3commRepositoryImpl(
        get<_i62.RemoteIden3commDataSource>(),
        get<_i90.LibPolygonIdCoreIden3commDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i79.AuthProofMapper>(),
        get<_i82.GistProofMapper>(),
        get<_i60.QMapper>(),
      ));
  gh.factoryAsync<_i104.InteractionRepositoryImpl>(
      () async => _i104.InteractionRepositoryImpl(
            get<_i98.SecureStorageInteractionDataSource>(),
            await get.getAsync<_i87.StorageInteractionDataSource>(),
            get<_i33.InteractionMapper>(),
            get<_i21.FiltersMapper>(),
            get<_i32.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i92.LibPolygonIdCoreProofDataSource>(() =>
      _i92.LibPolygonIdCoreProofDataSource(
          get<_i92.LibPolygonIdCoreWrapper>()));
  gh.factory<_i105.SMTDataSource>(() => _i105.SMTDataSource(
        get<_i28.HexMapper>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i85.StorageSMTDataSource>(),
      ));
  gh.factory<_i106.SMTRepositoryImpl>(() => _i106.SMTRepositoryImpl(
        get<_i105.SMTDataSource>(),
        get<_i85.StorageSMTDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i94.NodeMapper>(),
        get<_i27.HashMapper>(),
        get<_i56.ProofMapper>(),
        get<_i68.TreeTypeMapper>(),
        get<_i67.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i107.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i99.ConfigRepositoryImpl>()));
  gh.factory<_i108.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i100.CredentialRepositoryImpl>()));
  gh.factory<_i109.GetAuthClaimUseCase>(
      () => _i109.GetAuthClaimUseCase(get<_i108.CredentialRepository>()));
  gh.factoryAsync<_i110.GetEnvUseCase>(() async =>
      _i110.GetEnvUseCase(await get.getAsync<_i107.ConfigRepository>()));
  gh.factory<_i111.GetVocabsUseCase>(
      () => _i111.GetVocabsUseCase(get<_i102.Iden3commCredentialRepository>()));
  gh.factory<_i112.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i103.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i113.InteractionRepository>(() async =>
      repositoriesModule.interactionRepository(
          await get.getAsync<_i104.InteractionRepositoryImpl>()));
  gh.factoryAsync<_i114.ListenAndStoreNotificationUseCase>(() async =>
      _i114.ListenAndStoreNotificationUseCase(
          await get.getAsync<_i113.InteractionRepository>()));
  gh.factoryAsync<_i115.RPCDataSource>(() async =>
      _i115.RPCDataSource(await get.getAsync<_i110.GetEnvUseCase>()));
  gh.factory<_i116.RemoveAllClaimsUseCase>(
      () => _i116.RemoveAllClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i117.RemoveClaimsUseCase>(
      () => _i117.RemoveClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i118.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i106.SMTRepositoryImpl>()));
  gh.factory<_i119.SaveClaimsUseCase>(
      () => _i119.SaveClaimsUseCase(get<_i108.CredentialRepository>()));
  gh.factoryAsync<_i120.SetEnvUseCase>(() async =>
      _i120.SetEnvUseCase(await get.getAsync<_i107.ConfigRepository>()));
  gh.factory<_i121.UpdateClaimUseCase>(
      () => _i121.UpdateClaimUseCase(get<_i108.CredentialRepository>()));
  gh.factory<_i122.GetAuthChallengeUseCase>(
      () => _i122.GetAuthChallengeUseCase(get<_i112.Iden3commRepository>()));
  gh.factory<_i123.GetLatestStateUseCase>(
      () => _i123.GetLatestStateUseCase(get<_i118.SMTRepository>()));
  gh.factoryAsync<_i124.IdentityRepositoryImpl>(
      () async => _i124.IdentityRepositoryImpl(
            get<_i69.WalletDataSource>(),
            get<_i63.RemoteIdentityDataSource>(),
            await get.getAsync<_i86.StorageIdentityDataSource>(),
            await get.getAsync<_i115.RPCDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i36.LibBabyJubJubDataSource>(),
            get<_i91.LibPolygonIdCoreIdentityDataSource>(),
            get<_i17.EncryptionDbDataSource>(),
            get<_i14.DestinationPathDataSource>(),
            get<_i28.HexMapper>(),
            get<_i53.PrivateKeyMapper>(),
            get<_i31.IdentityDTOMapper>(),
            get<_i97.RhsNodeMapper>(),
            get<_i66.StateIdentifierMapper>(),
            get<_i94.NodeMapper>(),
            get<_i18.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i125.ProofRepositoryImpl>(
      () async => _i125.ProofRepositoryImpl(
            get<_i73.WitnessDataSource>(),
            get<_i59.ProverLibDataSource>(),
            get<_i92.LibPolygonIdCoreProofDataSource>(),
            get<_i38.LocalProofFilesDataSource>(),
            get<_i54.ProofCircuitDataSource>(),
            get<_i63.RemoteIdentityDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i10.CircuitsDownloadDataSource>(),
            await get.getAsync<_i115.RPCDataSource>(),
            get<_i9.CircuitTypeMapper>(),
            get<_i35.JWZProofMapper>(),
            get<_i80.ClaimMapper>(),
            get<_i64.RevocationStatusMapper>(),
            get<_i34.JWZMapper>(),
            get<_i79.AuthProofMapper>(),
            get<_i83.GistProofMapper>(),
            get<_i82.GistProofMapper>(),
          ));
  gh.factory<_i126.RemoveIdentityStateUseCase>(
      () => _i126.RemoveIdentityStateUseCase(get<_i118.SMTRepository>()));
  gh.factoryAsync<_i127.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i124.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i128.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i125.ProofRepositoryImpl>()));
  gh.factoryAsync<_i129.ProveUseCase>(() async =>
      _i129.ProveUseCase(await get.getAsync<_i128.ProofRepository>()));
  gh.factoryAsync<_i130.SignMessageUseCase>(() async =>
      _i130.SignMessageUseCase(await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i131.CircuitsFilesExistUseCase>(() async =>
      _i131.CircuitsFilesExistUseCase(
          await get.getAsync<_i128.ProofRepository>()));
  gh.factoryAsync<_i132.DownloadCircuitsUseCase>(
      () async => _i132.DownloadCircuitsUseCase(
            await get.getAsync<_i128.ProofRepository>(),
            await get.getAsync<_i131.CircuitsFilesExistUseCase>(),
          ));
  gh.factoryAsync<_i133.FetchStateRootsUseCase>(() async =>
      _i133.FetchStateRootsUseCase(
          await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i134.GetDidUseCase>(() async =>
      _i134.GetDidUseCase(await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i135.GetGistProofUseCase>(
      () async => _i135.GetGistProofUseCase(
            await get.getAsync<_i128.ProofRepository>(),
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i134.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i136.GetIdentitiesUseCase>(() async =>
      _i136.GetIdentitiesUseCase(
          await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i137.GetIdentityAuthClaimUseCase>(
      () async => _i137.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i109.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i138.GetJWZUseCase>(() async =>
      _i138.GetJWZUseCase(await get.getAsync<_i128.ProofRepository>()));
  gh.factoryAsync<_i139.GetPrivateKeyUseCase>(() async =>
      _i139.GetPrivateKeyUseCase(
          await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i140.GetPublicKeysUseCase>(() async =>
      _i140.GetPublicKeysUseCase(
          await get.getAsync<_i127.IdentityRepository>()));
  gh.factoryAsync<_i141.IsProofCircuitSupportedUseCase>(() async =>
      _i141.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i128.ProofRepository>()));
  gh.factoryAsync<_i142.LoadCircuitUseCase>(() async =>
      _i142.LoadCircuitUseCase(await get.getAsync<_i128.ProofRepository>()));
  gh.factoryAsync<_i143.CreateIdentityStateUseCase>(
      () async => _i143.CreateIdentityStateUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i118.SMTRepository>(),
            await get.getAsync<_i137.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i144.FetchIdentityStateUseCase>(
      () async => _i144.FetchIdentityStateUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i134.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i145.GenerateNonRevProofUseCase>(
      () async => _i145.GenerateNonRevProofUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i108.CredentialRepository>(),
            await get.getAsync<_i144.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i146.GetClaimRevocationStatusUseCase>(
      () async => _i146.GetClaimRevocationStatusUseCase(
            get<_i108.CredentialRepository>(),
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i145.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i147.GetFiltersUseCase>(() async => _i147.GetFiltersUseCase(
        get<_i102.Iden3commCredentialRepository>(),
        await get.getAsync<_i141.IsProofCircuitSupportedUseCase>(),
        get<_i26.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i148.GetGenesisStateUseCase>(
      () async => _i148.GetGenesisStateUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i118.SMTRepository>(),
            await get.getAsync<_i137.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i149.GetDidIdentifierUseCase>(
      () async => _i149.GetDidIdentifierUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i148.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i150.GetIdentityUseCase>(
      () async => _i150.GetIdentityUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i134.GetDidUseCase>(),
            await get.getAsync<_i149.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i151.GetInteractionsUseCase>(
      () async => _i151.GetInteractionsUseCase(
            await get.getAsync<_i113.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i152.RemoveInteractionsUseCase>(
      () async => _i152.RemoveInteractionsUseCase(
            await get.getAsync<_i113.InteractionRepository>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i153.AddInteractionUseCase>(
      () async => _i153.AddInteractionUseCase(
            await get.getAsync<_i113.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i154.CheckProfileAndDidCurrentEnvUseCase(
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i149.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i155.GenerateProofUseCase>(
      () async => _i155.GenerateProofUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i118.SMTRepository>(),
            await get.getAsync<_i128.ProofRepository>(),
            await get.getAsync<_i129.ProveUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
            get<_i109.GetAuthClaimUseCase>(),
            await get.getAsync<_i135.GetGistProofUseCase>(),
            await get.getAsync<_i134.GetDidUseCase>(),
            await get.getAsync<_i130.SignMessageUseCase>(),
            get<_i123.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i156.GetAuthInputsUseCase>(
      () async => _i156.GetAuthInputsUseCase(
            await get.getAsync<_i150.GetIdentityUseCase>(),
            get<_i109.GetAuthClaimUseCase>(),
            await get.getAsync<_i130.SignMessageUseCase>(),
            await get.getAsync<_i135.GetGistProofUseCase>(),
            get<_i123.GetLatestStateUseCase>(),
            get<_i112.Iden3commRepository>(),
            await get.getAsync<_i127.IdentityRepository>(),
            get<_i118.SMTRepository>(),
          ));
  gh.factoryAsync<_i157.GetAuthTokenUseCase>(
      () async => _i157.GetAuthTokenUseCase(
            await get.getAsync<_i142.LoadCircuitUseCase>(),
            await get.getAsync<_i138.GetJWZUseCase>(),
            get<_i122.GetAuthChallengeUseCase>(),
            await get.getAsync<_i156.GetAuthInputsUseCase>(),
            await get.getAsync<_i129.ProveUseCase>(),
          ));
  gh.factoryAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i158.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i149.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i159.GetProfilesUseCase>(
      () async => _i159.GetProfilesUseCase(
            await get.getAsync<_i150.GetIdentityUseCase>(),
            await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i160.Proof>(() async => _i160.Proof(
        await get.getAsync<_i155.GenerateProofUseCase>(),
        await get.getAsync<_i132.DownloadCircuitsUseCase>(),
        await get.getAsync<_i131.CircuitsFilesExistUseCase>(),
        get<_i55.ProofGenerationStepsStreamManager>(),
      ));
  gh.factoryAsync<_i161.UpdateInteractionUseCase>(
      () async => _i161.UpdateInteractionUseCase(
            await get.getAsync<_i113.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
            await get.getAsync<_i153.AddInteractionUseCase>(),
          ));
  gh.factoryAsync<_i162.BackupIdentityUseCase>(
      () async => _i162.BackupIdentityUseCase(
            await get.getAsync<_i150.GetIdentityUseCase>(),
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i163.CheckIdentityValidityUseCase>(
      () async => _i163.CheckIdentityValidityUseCase(
            await get.getAsync<_i139.GetPrivateKeyUseCase>(),
            await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i164.CreateIdentityUseCase>(
      () async => _i164.CreateIdentityUseCase(
            await get.getAsync<_i140.GetPublicKeysUseCase>(),
            await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i165.CreateProfilesUseCase>(
      () async => _i165.CreateProfilesUseCase(
            await get.getAsync<_i140.GetPublicKeysUseCase>(),
            await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i166.FetchAndSaveClaimsUseCase>(
      () async => _i166.FetchAndSaveClaimsUseCase(
            get<_i102.Iden3commCredentialRepository>(),
            await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i149.GetDidIdentifierUseCase>(),
            get<_i22.GetFetchRequestsUseCase>(),
            await get.getAsync<_i157.GetAuthTokenUseCase>(),
            get<_i119.SaveClaimsUseCase>(),
            await get.getAsync<_i146.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i167.GetClaimsUseCase>(() async => _i167.GetClaimsUseCase(
        get<_i108.CredentialRepository>(),
        await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i150.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i168.GetIden3commClaimsUseCase>(
      () async => _i168.GetIden3commClaimsUseCase(
            get<_i102.Iden3commCredentialRepository>(),
            await get.getAsync<_i167.GetClaimsUseCase>(),
            await get.getAsync<_i146.GetClaimRevocationStatusUseCase>(),
            get<_i121.UpdateClaimUseCase>(),
            await get.getAsync<_i141.IsProofCircuitSupportedUseCase>(),
            get<_i26.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i169.GetIden3commProofsUseCase>(
      () async => _i169.GetIden3commProofsUseCase(
            await get.getAsync<_i128.ProofRepository>(),
            await get.getAsync<_i168.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i155.GenerateProofUseCase>(),
            await get.getAsync<_i141.IsProofCircuitSupportedUseCase>(),
            get<_i26.GetProofRequestsUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
            get<_i55.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i170.UpdateIdentityUseCase>(
      () async => _i170.UpdateIdentityUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i164.CreateIdentityUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i171.AddIdentityUseCase>(
      () async => _i171.AddIdentityUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i164.CreateIdentityUseCase>(),
            await get.getAsync<_i143.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i172.AddNewIdentityUseCase>(
      () async => _i172.AddNewIdentityUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i171.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i173.AddProfileUseCase>(() async => _i173.AddProfileUseCase(
        await get.getAsync<_i150.GetIdentityUseCase>(),
        await get.getAsync<_i170.UpdateIdentityUseCase>(),
        await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i165.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i174.AuthenticateUseCase>(
      () async => _i174.AuthenticateUseCase(
            get<_i112.Iden3commRepository>(),
            await get.getAsync<_i169.GetIden3commProofsUseCase>(),
            await get.getAsync<_i149.GetDidIdentifierUseCase>(),
            await get.getAsync<_i157.GetAuthTokenUseCase>(),
            await get.getAsync<_i110.GetEnvUseCase>(),
            await get.getAsync<_i101.GetPackageNameUseCase>(),
            await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i55.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i175.Credential>(() async => _i175.Credential(
        get<_i119.SaveClaimsUseCase>(),
        await get.getAsync<_i167.GetClaimsUseCase>(),
        get<_i117.RemoveClaimsUseCase>(),
        get<_i121.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i176.Iden3comm>(() async => _i176.Iden3comm(
        await get.getAsync<_i166.FetchAndSaveClaimsUseCase>(),
        get<_i24.GetIden3MessageUseCase>(),
        await get.getAsync<_i174.AuthenticateUseCase>(),
        await get.getAsync<_i147.GetFiltersUseCase>(),
        await get.getAsync<_i168.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i169.GetIden3commProofsUseCase>(),
        await get.getAsync<_i151.GetInteractionsUseCase>(),
        await get.getAsync<_i153.AddInteractionUseCase>(),
        await get.getAsync<_i152.RemoveInteractionsUseCase>(),
        await get.getAsync<_i161.UpdateInteractionUseCase>(),
      ));
  gh.factoryAsync<_i177.RemoveProfileUseCase>(
      () async => _i177.RemoveProfileUseCase(
            await get.getAsync<_i150.GetIdentityUseCase>(),
            await get.getAsync<_i170.UpdateIdentityUseCase>(),
            await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i165.CreateProfilesUseCase>(),
            get<_i126.RemoveIdentityStateUseCase>(),
            get<_i116.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i178.RestoreIdentityUseCase>(
      () async => _i178.RestoreIdentityUseCase(
            await get.getAsync<_i171.AddIdentityUseCase>(),
            await get.getAsync<_i150.GetIdentityUseCase>(),
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i158.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i179.RemoveIdentityUseCase>(
      () async => _i179.RemoveIdentityUseCase(
            await get.getAsync<_i127.IdentityRepository>(),
            await get.getAsync<_i159.GetProfilesUseCase>(),
            await get.getAsync<_i177.RemoveProfileUseCase>(),
            get<_i126.RemoveIdentityStateUseCase>(),
            get<_i116.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i154.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i180.Identity>(() async => _i180.Identity(
        await get.getAsync<_i163.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i139.GetPrivateKeyUseCase>(),
        await get.getAsync<_i172.AddNewIdentityUseCase>(),
        await get.getAsync<_i178.RestoreIdentityUseCase>(),
        await get.getAsync<_i162.BackupIdentityUseCase>(),
        await get.getAsync<_i150.GetIdentityUseCase>(),
        await get.getAsync<_i136.GetIdentitiesUseCase>(),
        await get.getAsync<_i179.RemoveIdentityUseCase>(),
        await get.getAsync<_i149.GetDidIdentifierUseCase>(),
        await get.getAsync<_i130.SignMessageUseCase>(),
        await get.getAsync<_i144.FetchIdentityStateUseCase>(),
        await get.getAsync<_i173.AddProfileUseCase>(),
        await get.getAsync<_i159.GetProfilesUseCase>(),
        await get.getAsync<_i177.RemoveProfileUseCase>(),
        await get.getAsync<_i134.GetDidUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i181.PlatformModule {}

class _$NetworkModule extends _i181.NetworkModule {}

class _$DatabaseModule extends _i181.DatabaseModule {}

class _$EncryptionModule extends _i181.EncryptionModule {}

class _$ChannelModule extends _i181.ChannelModule {}

class _$ZipDecoderModule extends _i181.ZipDecoderModule {}

class _$RepositoriesModule extends _i181.RepositoriesModule {}
