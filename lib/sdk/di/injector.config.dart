// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i15;

import 'package:archive/archive.dart' as _i80;
import 'package:dio/dio.dart' as _i14;
import 'package:encrypt/encrypt.dart' as _i16;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i38;
import 'package:package_info_plus/package_info_plus.dart' as _i43;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i70;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i19;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i20;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i21;
import '../../common/data/data_sources/package_info_datasource.dart' as _i44;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i91;
import '../../common/data/repositories/config_repository_impl.dart' as _i103;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i45;
import '../../common/domain/domain_logger.dart' as _i52;
import '../../common/domain/entities/env_entity.dart' as _i71;
import '../../common/domain/repositories/config_repository.dart' as _i112;
import '../../common/domain/repositories/package_info_repository.dart' as _i99;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i116;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i105;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i128;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i46;
import '../../credential/data/credential_repository_impl.dart' as _i104;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i92;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i96;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i61;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i85;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i84;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i29;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i64;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i113;
import '../../credential/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i156;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i114;
import '../../credential/domain/use_cases/get_claim_revocation_nonce_use_case.dart'
    as _i115;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i160;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i178;
import '../../credential/domain/use_cases/get_non_rev_proof_use_case.dart'
    as _i159;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i124;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i125;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i127;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i129;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i47;
import '../../iden3comm/data/data_sources/iden3_message_data_source.dart'
    as _i30;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i93;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i62;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i102;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i90;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i81;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/iden3_message_type_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/iden3comm_proof_mapper.dart' as _i87;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/jwz_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i57;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i86;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i108;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i109;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i107;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i120;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i121;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i186;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i166;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i177;
import '../../iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart'
    as _i167;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i130;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i168;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i169;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i157;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart'
    as _i179;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i180;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i181;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_jwz_use_case.dart' as _i131;
import '../../iden3comm/domain/use_cases/get_proof_query_context_use_case.dart'
    as _i117;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i25;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i118;
import '../../iden3comm/domain/use_cases/get_schemas_use_case.dart' as _i119;
import '../../iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i165;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i163;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i164;
import '../../iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i172;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i122;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i48;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i36;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i94;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i37;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i123;
import '../../identity/data/data_sources/smt_data_source.dart' as _i110;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i89;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i88;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i69;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i18;
import '../../identity/data/mappers/hash_mapper.dart' as _i27;
import '../../identity/data/mappers/hex_mapper.dart' as _i28;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i32;
import '../../identity/data/mappers/node_mapper.dart' as _i98;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i40;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i41;
import '../../identity/data/mappers/node_type_mapper.dart' as _i42;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i53;
import '../../identity/data/mappers/private_key_mapper.dart' as _i54;
import '../../identity/data/mappers/q_mapper.dart' as _i60;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i101;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i65;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i66;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i67;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i68;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i133;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i111;
import '../../identity/domain/repositories/identity_repository.dart' as _i136;
import '../../identity/domain/repositories/smt_repository.dart' as _i126;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i155;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i170;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i145;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i148;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i132;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i150;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i183;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i184;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i173;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i174;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i175;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i162;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i149;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i191;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i190;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i139;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i182;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i185;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i7;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i176;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i171;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i189;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i154;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i135;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i49;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i82;
import '../../proof/data/data_sources/circuits_files_data_source.dart' as _i83;
import '../../proof/data/data_sources/gist_mtproof_data_source.dart' as _i26;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i95;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i55;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i59;
import '../../proof/data/data_sources/witness_data_source.dart' as _i73;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i8;
import '../../proof/data/mappers/gist_mtproof_mapper.dart' as _i106;
import '../../proof/data/mappers/mtproof_mapper.dart' as _i97;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i39;
import '../../proof/data/mappers/zkproof_base_mapper.dart' as _i78;
import '../../proof/data/mappers/zkproof_mapper.dart' as _i79;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i134;
import '../../proof/domain/repositories/proof_repository.dart' as _i137;
import '../../proof/domain/use_cases/cancel_download_circuits_use_case.dart'
    as _i140;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i141;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i142;
import '../../proof/domain/use_cases/generate_zkproof_use_case.dart' as _i144;
import '../../proof/domain/use_cases/get_gist_mtproof_use_case.dart' as _i146;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i151;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i152;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i138;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i56;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i50;
import '../../proof/libs/prover/prover.dart' as _i58;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i72;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i74;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i75;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i76;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i77;
import '../credential.dart' as _i187;
import '../iden3comm.dart' as _i188;
import '../identity.dart' as _i192;
import '../polygon_id_sdk.dart' as _i51;
import '../polygonid_flutter_channel.dart' as _i100;
import '../proof.dart' as _i153;
import 'injector.dart' as _i193; // ignore_for_file: unnecessary_lambdas

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
  final filesManagerModule = _$FilesManagerModule();
  final encryptionModule = _$EncryptionModule();
  final loggerModule = _$LoggerModule();
  final channelModule = _$ChannelModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.CheckProfileValidityUseCase>(
      () => _i7.CheckProfileValidityUseCase());
  gh.factory<_i8.CircuitTypeMapper>(() => _i8.CircuitTypeMapper());
  gh.factory<_i9.ClaimInfoMapper>(() => _i9.ClaimInfoMapper());
  gh.factory<_i10.ClaimStateMapper>(() => _i10.ClaimStateMapper());
  gh.factory<_i11.Client>(() => networkModule.client);
  gh.factory<_i12.CreatePathWrapper>(() => _i12.CreatePathWrapper());
  gh.factoryParamAsync<_i13.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i13.Database>(() => databaseModule.database());
  gh.factory<_i12.DestinationPathDataSource>(
      () => _i12.DestinationPathDataSource(get<_i12.CreatePathWrapper>()));
  gh.factory<_i14.Dio>(() => networkModule.dio);
  gh.factoryAsync<_i15.Directory>(
      () => filesManagerModule.applicationDocumentsDirectory);
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
  gh.factory<_i26.GistMTProofDataSource>(() => _i26.GistMTProofDataSource());
  gh.factory<_i27.HashMapper>(() => _i27.HashMapper());
  gh.factory<_i28.HexMapper>(() => _i28.HexMapper());
  gh.factory<_i29.IdFilterMapper>(() => _i29.IdFilterMapper());
  gh.factory<_i30.Iden3MessageDataSource>(() => _i30.Iden3MessageDataSource());
  gh.factory<_i31.Iden3MessageTypeMapper>(() => _i31.Iden3MessageTypeMapper());
  gh.factory<_i32.IdentityDTOMapper>(() => _i32.IdentityDTOMapper());
  gh.factory<_i33.InteractionIdFilterMapper>(
      () => _i33.InteractionIdFilterMapper());
  gh.factory<_i34.InteractionMapper>(() => _i34.InteractionMapper());
  gh.factory<_i35.JWZMapper>(() => _i35.JWZMapper());
  gh.factory<_i36.LibBabyJubJubDataSource>(
      () => _i36.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i37.LocalContractFilesDataSource>(
      () => _i37.LocalContractFilesDataSource());
  gh.factory<_i38.Logger>(() => loggerModule.logger);
  gh.factory<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
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
  gh.factory<_i52.PolygonIdSdkLogger>(() => loggerModule.sdkLogger);
  gh.factory<_i53.PoseidonHashMapper>(
      () => _i53.PoseidonHashMapper(get<_i28.HexMapper>()));
  gh.factory<_i54.PrivateKeyMapper>(() => _i54.PrivateKeyMapper());
  gh.factory<_i55.ProofCircuitDataSource>(() => _i55.ProofCircuitDataSource());
  gh.lazySingleton<_i56.ProofGenerationStepsStreamManager>(
      () => _i56.ProofGenerationStepsStreamManager());
  gh.factory<_i57.ProofRequestFiltersMapper>(
      () => _i57.ProofRequestFiltersMapper());
  gh.factory<_i58.ProverLib>(() => _i58.ProverLib());
  gh.factory<_i59.ProverLibWrapper>(() => _i59.ProverLibWrapper());
  gh.factory<_i60.QMapper>(() => _i60.QMapper());
  gh.factory<_i61.RemoteClaimDataSource>(
      () => _i61.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i62.RemoteIden3commDataSource>(
      () => _i62.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i63.RemoteIdentityDataSource>(
      () => _i63.RemoteIdentityDataSource());
  gh.factory<_i64.RevocationStatusMapper>(() => _i64.RevocationStatusMapper());
  gh.factory<_i65.RhsNodeTypeMapper>(() => _i65.RhsNodeTypeMapper());
  gh.factoryParam<_i13.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i66.StateIdentifierMapper>(() => _i66.StateIdentifierMapper());
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i13.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
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
  gh.factory<_i78.ZKProofBaseMapper>(() => _i78.ZKProofBaseMapper());
  gh.factory<_i79.ZKProofMapper>(() => _i79.ZKProofMapper());
  gh.factory<_i80.ZipDecoder>(() => filesManagerModule.zipDecoder());
  gh.factory<_i81.AuthProofMapper>(() => _i81.AuthProofMapper(
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.lazySingleton<_i82.CircuitsDownloadDataSource>(
      () => _i82.CircuitsDownloadDataSource(get<_i14.Dio>()));
  gh.factoryAsync<_i83.CircuitsFilesDataSource>(() async =>
      _i83.CircuitsFilesDataSource(await get.getAsync<_i15.Directory>()));
  gh.factory<_i84.ClaimMapper>(() => _i84.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i85.ClaimStoreRefWrapper>(() => _i85.ClaimStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i86.Iden3commCredentialRepositoryImpl>(
      () => _i86.Iden3commCredentialRepositoryImpl(
            get<_i62.RemoteIden3commDataSource>(),
            get<_i57.ProofRequestFiltersMapper>(),
            get<_i84.ClaimMapper>(),
          ));
  gh.factory<_i87.Iden3commProofMapper>(
      () => _i87.Iden3commProofMapper(get<_i78.ZKProofBaseMapper>()));
  gh.factory<_i88.IdentitySMTStoreRefWrapper>(() =>
      _i88.IdentitySMTStoreRefWrapper(
          get<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'identityStateStore')));
  gh.factory<_i89.IdentityStoreRefWrapper>(() => _i89.IdentityStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i90.InteractionStoreRefWrapper>(() =>
      _i90.InteractionStoreRefWrapper(
          get<_i13.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i91.KeyValueStoreRefWrapper>(() => _i91.KeyValueStoreRefWrapper(
      get<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i92.LibPolygonIdCoreCredentialDataSource>(() =>
      _i92.LibPolygonIdCoreCredentialDataSource(
          get<_i47.PolygonIdCoreCredential>()));
  gh.factory<_i93.LibPolygonIdCoreIden3commDataSource>(() =>
      _i93.LibPolygonIdCoreIden3commDataSource(
          get<_i48.PolygonIdCoreIden3comm>()));
  gh.factory<_i94.LibPolygonIdCoreIdentityDataSource>(() =>
      _i94.LibPolygonIdCoreIdentityDataSource(
          get<_i49.PolygonIdCoreIdentity>()));
  gh.factory<_i95.LibPolygonIdCoreWrapper>(
      () => _i95.LibPolygonIdCoreWrapper(get<_i50.PolygonIdCoreProof>()));
  gh.factory<_i96.LocalClaimDataSource>(() => _i96.LocalClaimDataSource(
      get<_i92.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i97.MTProofMapper>(() => _i97.MTProofMapper(
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.factory<_i98.NodeMapper>(() => _i98.NodeMapper(
        get<_i42.NodeTypeMapper>(),
        get<_i41.NodeTypeEntityMapper>(),
        get<_i40.NodeTypeDTOMapper>(),
        get<_i27.HashMapper>(),
      ));
  gh.factoryAsync<_i99.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i45.PackageInfoRepositoryImpl>()));
  gh.factory<_i100.PolygonIdFlutterChannel>(() => _i100.PolygonIdFlutterChannel(
        get<_i51.PolygonIdSdk>(),
        get<_i3.MethodChannel>(),
      ));
  gh.factory<_i59.ProverLibDataSource>(
      () => _i59.ProverLibDataSource(get<_i59.ProverLibWrapper>()));
  gh.factory<_i101.RhsNodeMapper>(
      () => _i101.RhsNodeMapper(get<_i65.RhsNodeTypeMapper>()));
  gh.factory<_i102.SecureInteractionStoreRefWrapper>(() =>
      _i102.SecureInteractionStoreRefWrapper(
          get<_i13.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i102.SecureStorageInteractionDataSource>(() =>
      _i102.SecureStorageInteractionDataSource(
          get<_i102.SecureInteractionStoreRefWrapper>()));
  gh.factory<_i85.StorageClaimDataSource>(
      () => _i85.StorageClaimDataSource(get<_i85.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i89.StorageIdentityDataSource>(
      () async => _i89.StorageIdentityDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i89.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i90.StorageInteractionDataSource>(
      () async => _i90.StorageInteractionDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i90.InteractionStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i91.StorageKeyValueDataSource>(
      () async => _i91.StorageKeyValueDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i91.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i88.StorageSMTDataSource>(
      () => _i88.StorageSMTDataSource(get<_i88.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i69.WalletDataSource>(
      () => _i69.WalletDataSource(get<_i69.WalletLibWrapper>()));
  gh.factory<_i73.WitnessDataSource>(
      () => _i73.WitnessDataSource(get<_i73.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i103.ConfigRepositoryImpl>(
      () async => _i103.ConfigRepositoryImpl(
            await get.getAsync<_i91.StorageKeyValueDataSource>(),
            get<_i19.EnvMapper>(),
          ));
  gh.factory<_i104.CredentialRepositoryImpl>(
      () => _i104.CredentialRepositoryImpl(
            get<_i61.RemoteClaimDataSource>(),
            get<_i85.StorageClaimDataSource>(),
            get<_i96.LocalClaimDataSource>(),
            get<_i84.ClaimMapper>(),
            get<_i21.FiltersMapper>(),
            get<_i29.IdFilterMapper>(),
          ));
  gh.factoryAsync<_i105.GetPackageNameUseCase>(() async =>
      _i105.GetPackageNameUseCase(
          await get.getAsync<_i99.PackageInfoRepository>()));
  gh.factory<_i106.GistMTProofMapper>(() => _i106.GistMTProofMapper(
        get<_i97.MTProofMapper>(),
        get<_i27.HashMapper>(),
      ));
  gh.factory<_i107.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i86.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i108.Iden3commRepositoryImpl>(() => _i108.Iden3commRepositoryImpl(
        get<_i30.Iden3MessageDataSource>(),
        get<_i62.RemoteIden3commDataSource>(),
        get<_i93.LibPolygonIdCoreIden3commDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i81.AuthProofMapper>(),
        get<_i106.GistMTProofMapper>(),
        get<_i60.QMapper>(),
        get<_i35.JWZMapper>(),
        get<_i87.Iden3commProofMapper>(),
      ));
  gh.factoryAsync<_i109.InteractionRepositoryImpl>(
      () async => _i109.InteractionRepositoryImpl(
            get<_i102.SecureStorageInteractionDataSource>(),
            await get.getAsync<_i90.StorageInteractionDataSource>(),
            get<_i34.InteractionMapper>(),
            get<_i21.FiltersMapper>(),
            get<_i33.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i95.LibPolygonIdCoreProofDataSource>(() =>
      _i95.LibPolygonIdCoreProofDataSource(
          get<_i95.LibPolygonIdCoreWrapper>()));
  gh.factory<_i110.SMTDataSource>(() => _i110.SMTDataSource(
        get<_i28.HexMapper>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i88.StorageSMTDataSource>(),
      ));
  gh.factory<_i111.SMTRepositoryImpl>(() => _i111.SMTRepositoryImpl(
        get<_i110.SMTDataSource>(),
        get<_i88.StorageSMTDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i98.NodeMapper>(),
        get<_i27.HashMapper>(),
        get<_i97.MTProofMapper>(),
        get<_i68.TreeTypeMapper>(),
        get<_i67.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i112.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i103.ConfigRepositoryImpl>()));
  gh.factory<_i113.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i104.CredentialRepositoryImpl>()));
  gh.factory<_i114.GetAuthClaimUseCase>(
      () => _i114.GetAuthClaimUseCase(get<_i113.CredentialRepository>()));
  gh.factory<_i115.GetClaimRevocationNonceUseCase>(() =>
      _i115.GetClaimRevocationNonceUseCase(get<_i113.CredentialRepository>()));
  gh.factoryAsync<_i116.GetEnvUseCase>(() async =>
      _i116.GetEnvUseCase(await get.getAsync<_i112.ConfigRepository>()));
  gh.factory<_i117.GetProofQueryContextUseCase>(() =>
      _i117.GetProofQueryContextUseCase(
          get<_i107.Iden3commCredentialRepository>()));
  gh.factory<_i118.GetProofRequestsUseCase>(() => _i118.GetProofRequestsUseCase(
        get<_i117.GetProofQueryContextUseCase>(),
        get<_i25.GetProofQueryUseCase>(),
      ));
  gh.factory<_i119.GetSchemasUseCase>(() =>
      _i119.GetSchemasUseCase(get<_i107.Iden3commCredentialRepository>()));
  gh.factory<_i120.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i108.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i121.InteractionRepository>(() async =>
      repositoriesModule.interactionRepository(
          await get.getAsync<_i109.InteractionRepositoryImpl>()));
  gh.factoryAsync<_i122.ListenAndStoreNotificationUseCase>(() async =>
      _i122.ListenAndStoreNotificationUseCase(
          await get.getAsync<_i121.InteractionRepository>()));
  gh.factoryAsync<_i123.RPCDataSource>(() async =>
      _i123.RPCDataSource(await get.getAsync<_i116.GetEnvUseCase>()));
  gh.factory<_i124.RemoveAllClaimsUseCase>(
      () => _i124.RemoveAllClaimsUseCase(get<_i113.CredentialRepository>()));
  gh.factory<_i125.RemoveClaimsUseCase>(
      () => _i125.RemoveClaimsUseCase(get<_i113.CredentialRepository>()));
  gh.factory<_i126.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i111.SMTRepositoryImpl>()));
  gh.factory<_i127.SaveClaimsUseCase>(
      () => _i127.SaveClaimsUseCase(get<_i113.CredentialRepository>()));
  gh.factoryAsync<_i128.SetEnvUseCase>(() async =>
      _i128.SetEnvUseCase(await get.getAsync<_i112.ConfigRepository>()));
  gh.factory<_i129.UpdateClaimUseCase>(
      () => _i129.UpdateClaimUseCase(get<_i113.CredentialRepository>()));
  gh.factory<_i130.GetAuthChallengeUseCase>(
      () => _i130.GetAuthChallengeUseCase(get<_i120.Iden3commRepository>()));
  gh.factory<_i131.GetJWZUseCase>(
      () => _i131.GetJWZUseCase(get<_i120.Iden3commRepository>()));
  gh.factory<_i132.GetLatestStateUseCase>(
      () => _i132.GetLatestStateUseCase(get<_i126.SMTRepository>()));
  gh.factoryAsync<_i133.IdentityRepositoryImpl>(
      () async => _i133.IdentityRepositoryImpl(
            get<_i69.WalletDataSource>(),
            get<_i63.RemoteIdentityDataSource>(),
            await get.getAsync<_i89.StorageIdentityDataSource>(),
            await get.getAsync<_i123.RPCDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i36.LibBabyJubJubDataSource>(),
            get<_i94.LibPolygonIdCoreIdentityDataSource>(),
            get<_i17.EncryptionDbDataSource>(),
            get<_i12.DestinationPathDataSource>(),
            get<_i28.HexMapper>(),
            get<_i54.PrivateKeyMapper>(),
            get<_i32.IdentityDTOMapper>(),
            get<_i101.RhsNodeMapper>(),
            get<_i66.StateIdentifierMapper>(),
            get<_i98.NodeMapper>(),
            get<_i18.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i134.ProofRepositoryImpl>(
      () async => _i134.ProofRepositoryImpl(
            get<_i73.WitnessDataSource>(),
            get<_i59.ProverLibDataSource>(),
            get<_i95.LibPolygonIdCoreProofDataSource>(),
            get<_i26.GistMTProofDataSource>(),
            get<_i55.ProofCircuitDataSource>(),
            get<_i63.RemoteIdentityDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i82.CircuitsDownloadDataSource>(),
            await get.getAsync<_i123.RPCDataSource>(),
            get<_i8.CircuitTypeMapper>(),
            get<_i79.ZKProofMapper>(),
            get<_i84.ClaimMapper>(),
            get<_i64.RevocationStatusMapper>(),
            get<_i81.AuthProofMapper>(),
            get<_i106.GistMTProofMapper>(),
            await get.getAsync<_i83.CircuitsFilesDataSource>(),
          ));
  gh.factory<_i135.RemoveIdentityStateUseCase>(
      () => _i135.RemoveIdentityStateUseCase(get<_i126.SMTRepository>()));
  gh.factoryAsync<_i136.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i133.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i137.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i134.ProofRepositoryImpl>()));
  gh.factoryAsync<_i138.ProveUseCase>(() async =>
      _i138.ProveUseCase(await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i139.SignMessageUseCase>(() async =>
      _i139.SignMessageUseCase(await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i140.CancelDownloadCircuitsUseCase>(() async =>
      _i140.CancelDownloadCircuitsUseCase(
          await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i141.CircuitsFilesExistUseCase>(() async =>
      _i141.CircuitsFilesExistUseCase(
          await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i142.DownloadCircuitsUseCase>(() async =>
      _i142.DownloadCircuitsUseCase(
          await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i143.FetchStateRootsUseCase>(() async =>
      _i143.FetchStateRootsUseCase(
          await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i144.GenerateZKProofUseCase>(
      () async => _i144.GenerateZKProofUseCase(
            await get.getAsync<_i137.ProofRepository>(),
            await get.getAsync<_i138.ProveUseCase>(),
          ));
  gh.factoryAsync<_i145.GetDidUseCase>(() async =>
      _i145.GetDidUseCase(await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i146.GetGistMTProofUseCase>(
      () async => _i146.GetGistMTProofUseCase(
            await get.getAsync<_i137.ProofRepository>(),
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i145.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i147.GetIdentitiesUseCase>(() async =>
      _i147.GetIdentitiesUseCase(
          await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i148.GetIdentityAuthClaimUseCase>(
      () async => _i148.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i114.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i149.GetPrivateKeyUseCase>(() async =>
      _i149.GetPrivateKeyUseCase(
          await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i150.GetPublicKeysUseCase>(() async =>
      _i150.GetPublicKeysUseCase(
          await get.getAsync<_i136.IdentityRepository>()));
  gh.factoryAsync<_i151.IsProofCircuitSupportedUseCase>(() async =>
      _i151.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i152.LoadCircuitUseCase>(() async =>
      _i152.LoadCircuitUseCase(await get.getAsync<_i137.ProofRepository>()));
  gh.factoryAsync<_i153.Proof>(() async => _i153.Proof(
        await get.getAsync<_i144.GenerateZKProofUseCase>(),
        await get.getAsync<_i142.DownloadCircuitsUseCase>(),
        await get.getAsync<_i141.CircuitsFilesExistUseCase>(),
        get<_i56.ProofGenerationStepsStreamManager>(),
        await get.getAsync<_i140.CancelDownloadCircuitsUseCase>(),
      ));
  gh.factoryAsync<_i154.CreateIdentityStateUseCase>(
      () async => _i154.CreateIdentityStateUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i126.SMTRepository>(),
            await get.getAsync<_i148.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i155.FetchIdentityStateUseCase>(
      () async => _i155.FetchIdentityStateUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i145.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i156.GenerateNonRevProofUseCase>(
      () async => _i156.GenerateNonRevProofUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i113.CredentialRepository>(),
            await get.getAsync<_i155.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i157.GetFiltersUseCase>(() async => _i157.GetFiltersUseCase(
        get<_i107.Iden3commCredentialRepository>(),
        await get.getAsync<_i151.IsProofCircuitSupportedUseCase>(),
        get<_i118.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i158.GetGenesisStateUseCase>(
      () async => _i158.GetGenesisStateUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i126.SMTRepository>(),
            await get.getAsync<_i148.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i159.GetNonRevProofUseCase>(
      () async => _i159.GetNonRevProofUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i113.CredentialRepository>(),
            await get.getAsync<_i155.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i160.GetClaimRevocationStatusUseCase>(
      () async => _i160.GetClaimRevocationStatusUseCase(
            get<_i113.CredentialRepository>(),
            await get.getAsync<_i156.GenerateNonRevProofUseCase>(),
            await get.getAsync<_i159.GetNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i161.GetDidIdentifierUseCase>(
      () async => _i161.GetDidIdentifierUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i158.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i162.GetIdentityUseCase>(
      () async => _i162.GetIdentityUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i145.GetDidUseCase>(),
            await get.getAsync<_i161.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i163.GetInteractionsUseCase>(
      () async => _i163.GetInteractionsUseCase(
            await get.getAsync<_i121.InteractionRepository>(),
            get<_i7.CheckProfileValidityUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i164.RemoveInteractionsUseCase>(
      () async => _i164.RemoveInteractionsUseCase(
            await get.getAsync<_i121.InteractionRepository>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i165.AddInteractionUseCase>(
      () async => _i165.AddInteractionUseCase(
            await get.getAsync<_i121.InteractionRepository>(),
            get<_i7.CheckProfileValidityUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i166.CheckProfileAndDidCurrentEnvUseCase(
            get<_i7.CheckProfileValidityUseCase>(),
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i161.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i167.GenerateIden3commProofUseCase>(
      () async => _i167.GenerateIden3commProofUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i126.SMTRepository>(),
            await get.getAsync<_i137.ProofRepository>(),
            await get.getAsync<_i138.ProveUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
            get<_i114.GetAuthClaimUseCase>(),
            await get.getAsync<_i146.GetGistMTProofUseCase>(),
            await get.getAsync<_i145.GetDidUseCase>(),
            await get.getAsync<_i139.SignMessageUseCase>(),
            get<_i132.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i168.GetAuthInputsUseCase>(
      () async => _i168.GetAuthInputsUseCase(
            await get.getAsync<_i162.GetIdentityUseCase>(),
            get<_i114.GetAuthClaimUseCase>(),
            await get.getAsync<_i139.SignMessageUseCase>(),
            await get.getAsync<_i146.GetGistMTProofUseCase>(),
            get<_i132.GetLatestStateUseCase>(),
            get<_i120.Iden3commRepository>(),
            await get.getAsync<_i136.IdentityRepository>(),
            get<_i126.SMTRepository>(),
          ));
  gh.factoryAsync<_i169.GetAuthTokenUseCase>(
      () async => _i169.GetAuthTokenUseCase(
            await get.getAsync<_i152.LoadCircuitUseCase>(),
            get<_i131.GetJWZUseCase>(),
            get<_i130.GetAuthChallengeUseCase>(),
            await get.getAsync<_i168.GetAuthInputsUseCase>(),
            await get.getAsync<_i138.ProveUseCase>(),
          ));
  gh.factoryAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i170.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i161.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i171.GetProfilesUseCase>(
      () async => _i171.GetProfilesUseCase(
            await get.getAsync<_i162.GetIdentityUseCase>(),
            await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i172.UpdateInteractionUseCase>(
      () async => _i172.UpdateInteractionUseCase(
            await get.getAsync<_i121.InteractionRepository>(),
            get<_i7.CheckProfileValidityUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
            await get.getAsync<_i165.AddInteractionUseCase>(),
          ));
  gh.factoryAsync<_i173.BackupIdentityUseCase>(
      () async => _i173.BackupIdentityUseCase(
            await get.getAsync<_i162.GetIdentityUseCase>(),
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i174.CheckIdentityValidityUseCase>(
      () async => _i174.CheckIdentityValidityUseCase(
            await get.getAsync<_i149.GetPrivateKeyUseCase>(),
            await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i175.CreateIdentityUseCase>(
      () async => _i175.CreateIdentityUseCase(
            await get.getAsync<_i150.GetPublicKeysUseCase>(),
            await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i176.CreateProfilesUseCase>(
      () async => _i176.CreateProfilesUseCase(
            await get.getAsync<_i150.GetPublicKeysUseCase>(),
            await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i177.FetchAndSaveClaimsUseCase>(
      () async => _i177.FetchAndSaveClaimsUseCase(
            get<_i107.Iden3commCredentialRepository>(),
            await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i161.GetDidIdentifierUseCase>(),
            get<_i22.GetFetchRequestsUseCase>(),
            await get.getAsync<_i169.GetAuthTokenUseCase>(),
            get<_i127.SaveClaimsUseCase>(),
            await get.getAsync<_i160.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i178.GetClaimsUseCase>(() async => _i178.GetClaimsUseCase(
        get<_i113.CredentialRepository>(),
        await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i162.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i179.GetIden3commClaimsRevNonceUseCase>(
      () async => _i179.GetIden3commClaimsRevNonceUseCase(
            get<_i107.Iden3commCredentialRepository>(),
            await get.getAsync<_i178.GetClaimsUseCase>(),
            get<_i115.GetClaimRevocationNonceUseCase>(),
            await get.getAsync<_i151.IsProofCircuitSupportedUseCase>(),
            get<_i118.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i180.GetIden3commClaimsUseCase>(
      () async => _i180.GetIden3commClaimsUseCase(
            get<_i107.Iden3commCredentialRepository>(),
            await get.getAsync<_i178.GetClaimsUseCase>(),
            await get.getAsync<_i160.GetClaimRevocationStatusUseCase>(),
            get<_i115.GetClaimRevocationNonceUseCase>(),
            get<_i129.UpdateClaimUseCase>(),
            await get.getAsync<_i151.IsProofCircuitSupportedUseCase>(),
            get<_i118.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i181.GetIden3commProofsUseCase>(
      () async => _i181.GetIden3commProofsUseCase(
            await get.getAsync<_i137.ProofRepository>(),
            await get.getAsync<_i180.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i167.GenerateIden3commProofUseCase>(),
            await get.getAsync<_i151.IsProofCircuitSupportedUseCase>(),
            get<_i118.GetProofRequestsUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
            get<_i56.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i182.UpdateIdentityUseCase>(
      () async => _i182.UpdateIdentityUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i175.CreateIdentityUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i183.AddIdentityUseCase>(
      () async => _i183.AddIdentityUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i175.CreateIdentityUseCase>(),
            await get.getAsync<_i154.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i184.AddNewIdentityUseCase>(
      () async => _i184.AddNewIdentityUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i183.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i185.AddProfileUseCase>(() async => _i185.AddProfileUseCase(
        await get.getAsync<_i162.GetIdentityUseCase>(),
        await get.getAsync<_i182.UpdateIdentityUseCase>(),
        await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i176.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i186.AuthenticateUseCase>(
      () async => _i186.AuthenticateUseCase(
            get<_i120.Iden3commRepository>(),
            await get.getAsync<_i181.GetIden3commProofsUseCase>(),
            await get.getAsync<_i161.GetDidIdentifierUseCase>(),
            await get.getAsync<_i169.GetAuthTokenUseCase>(),
            await get.getAsync<_i116.GetEnvUseCase>(),
            await get.getAsync<_i105.GetPackageNameUseCase>(),
            await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i56.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i187.Credential>(() async => _i187.Credential(
        get<_i127.SaveClaimsUseCase>(),
        await get.getAsync<_i178.GetClaimsUseCase>(),
        get<_i125.RemoveClaimsUseCase>(),
        await get.getAsync<_i160.GetClaimRevocationStatusUseCase>(),
        get<_i129.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i188.Iden3comm>(() async => _i188.Iden3comm(
        await get.getAsync<_i177.FetchAndSaveClaimsUseCase>(),
        get<_i24.GetIden3MessageUseCase>(),
        get<_i119.GetSchemasUseCase>(),
        await get.getAsync<_i186.AuthenticateUseCase>(),
        await get.getAsync<_i157.GetFiltersUseCase>(),
        await get.getAsync<_i180.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i179.GetIden3commClaimsRevNonceUseCase>(),
        await get.getAsync<_i181.GetIden3commProofsUseCase>(),
        await get.getAsync<_i163.GetInteractionsUseCase>(),
        await get.getAsync<_i165.AddInteractionUseCase>(),
        await get.getAsync<_i164.RemoveInteractionsUseCase>(),
        await get.getAsync<_i172.UpdateInteractionUseCase>(),
      ));
  gh.factoryAsync<_i189.RemoveProfileUseCase>(
      () async => _i189.RemoveProfileUseCase(
            await get.getAsync<_i162.GetIdentityUseCase>(),
            await get.getAsync<_i182.UpdateIdentityUseCase>(),
            await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i176.CreateProfilesUseCase>(),
            get<_i135.RemoveIdentityStateUseCase>(),
            get<_i124.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i190.RestoreIdentityUseCase>(
      () async => _i190.RestoreIdentityUseCase(
            await get.getAsync<_i183.AddIdentityUseCase>(),
            await get.getAsync<_i162.GetIdentityUseCase>(),
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i170.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i191.RemoveIdentityUseCase>(
      () async => _i191.RemoveIdentityUseCase(
            await get.getAsync<_i136.IdentityRepository>(),
            await get.getAsync<_i171.GetProfilesUseCase>(),
            await get.getAsync<_i189.RemoveProfileUseCase>(),
            get<_i135.RemoveIdentityStateUseCase>(),
            get<_i124.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i166.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i192.Identity>(() async => _i192.Identity(
        await get.getAsync<_i174.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i149.GetPrivateKeyUseCase>(),
        await get.getAsync<_i184.AddNewIdentityUseCase>(),
        await get.getAsync<_i190.RestoreIdentityUseCase>(),
        await get.getAsync<_i173.BackupIdentityUseCase>(),
        await get.getAsync<_i162.GetIdentityUseCase>(),
        await get.getAsync<_i147.GetIdentitiesUseCase>(),
        await get.getAsync<_i191.RemoveIdentityUseCase>(),
        await get.getAsync<_i161.GetDidIdentifierUseCase>(),
        await get.getAsync<_i139.SignMessageUseCase>(),
        await get.getAsync<_i155.FetchIdentityStateUseCase>(),
        await get.getAsync<_i185.AddProfileUseCase>(),
        await get.getAsync<_i171.GetProfilesUseCase>(),
        await get.getAsync<_i189.RemoveProfileUseCase>(),
        await get.getAsync<_i145.GetDidUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i193.PlatformModule {}

class _$NetworkModule extends _i193.NetworkModule {}

class _$DatabaseModule extends _i193.DatabaseModule {}

class _$FilesManagerModule extends _i193.FilesManagerModule {}

class _$EncryptionModule extends _i193.EncryptionModule {}

class _$LoggerModule extends _i193.LoggerModule {}

class _$ChannelModule extends _i193.ChannelModule {}

class _$RepositoriesModule extends _i193.RepositoriesModule {}
