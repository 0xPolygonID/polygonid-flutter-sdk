// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i16;

import 'package:archive/archive.dart' as _i77;
import 'package:encrypt/encrypt.dart' as _i17;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i43;
import 'package:sembast/sembast.dart' as _i15;
import 'package:web3dart/web3dart.dart' as _i69;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i20;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i21;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i22;
import '../../common/data/data_sources/package_info_datasource.dart' as _i44;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i88;
import '../../common/data/repositories/config_repository_impl.dart' as _i98;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i45;
import '../../common/domain/entities/env_entity.dart' as _i70;
import '../../common/domain/repositories/config_repository.dart' as _i106;
import '../../common/domain/repositories/package_info_repository.dart' as _i95;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i109;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i100;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i122;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i46;
import '../../credential/data/credential_repository_impl.dart' as _i99;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i89;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i93;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i60;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i81;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i11;
import '../../credential/data/mappers/claim_mapper.dart' as _i80;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i29;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i63;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i107;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i108;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i149;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i170;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i118;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i119;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i121;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i123;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i47;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i90;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i7;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i61;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i97;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i87;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i78;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i83;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i56;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i84;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i102;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i103;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i101;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i114;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i115;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i177;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i157;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i169;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i124;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i159;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i160;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i150;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i171;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i172;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i25;
import '../../iden3comm/domain/use_cases/get_proof_query_context_use_case.dart'
    as _i110;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i26;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i111;
import '../../iden3comm/domain/use_cases/get_schemas_use_case.dart' as _i112;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i113;
import '../../iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i156;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i154;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i155;
import '../../iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i164;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i116;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i48;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i14;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i18;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i36;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i91;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i37;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i62;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i117;
import '../../identity/data/data_sources/smt_data_source.dart' as _i104;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i86;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i85;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i68;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i19;
import '../../identity/data/mappers/hash_mapper.dart' as _i27;
import '../../identity/data/mappers/hex_mapper.dart' as _i28;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i31;
import '../../identity/data/mappers/node_mapper.dart' as _i94;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i40;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i41;
import '../../identity/data/mappers/node_type_mapper.dart' as _i42;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i51;
import '../../identity/data/mappers/private_key_mapper.dart' as _i52;
import '../../identity/data/mappers/q_mapper.dart' as _i59;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i96;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i64;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i65;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i66;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i67;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i126;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i105;
import '../../identity/domain/repositories/identity_repository.dart' as _i129;
import '../../identity/domain/repositories/smt_repository.dart' as _i120;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i136;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i148;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i152;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i137;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i151;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i140;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i125;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i143;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i174;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i175;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i166;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i167;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i139;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i153;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i182;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i181;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i132;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i173;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i176;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i8;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i168;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i162;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i180;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i146;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i128;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i49;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i10;
import '../../proof/data/data_sources/circuits_files_data_source.dart' as _i79;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i92;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i38;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i53;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i58;
import '../../proof/data/data_sources/witness_data_source.dart' as _i72;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i9;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i82;
import '../../proof/data/mappers/jwz_mapper.dart' as _i34;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i35;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i39;
import '../../proof/data/mappers/proof_mapper.dart' as _i55;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i127;
import '../../proof/domain/repositories/proof_repository.dart' as _i130;
import '../../proof/domain/use_cases/cancel_download_circuits_use_case.dart'
    as _i133;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i134;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i135;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i158;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i138;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i141;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i144;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i145;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i131;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i54;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i50;
import '../../proof/libs/prover/prover.dart' as _i57;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i71;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i73;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i74;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i75;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i76;
import '../credential.dart' as _i178;
import '../iden3comm.dart' as _i179;
import '../identity.dart' as _i183;
import '../mappers/iden3_message_type_mapper.dart' as _i30;
import '../proof.dart' as _i163;
import 'injector.dart' as _i184; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initSDKGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
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
  final channelModule = _$ChannelModule();
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
  gh.factory<_i14.DestinationPathDataSource>(
      () => _i14.DestinationPathDataSource(get<_i14.CreatePathWrapper>()));
  await gh.lazySingletonAsync<_i16.Directory>(
    () => filesManagerModule.applicationDocumentsDirectory,
    preResolve: true,
  );
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
  gh.factory<_i51.PoseidonHashMapper>(
      () => _i51.PoseidonHashMapper(get<_i28.HexMapper>()));
  gh.factory<_i52.PrivateKeyMapper>(() => _i52.PrivateKeyMapper());
  gh.factory<_i53.ProofCircuitDataSource>(() => _i53.ProofCircuitDataSource());
  gh.lazySingleton<_i54.ProofGenerationStepsStreamManager>(
      () => _i54.ProofGenerationStepsStreamManager());
  gh.factory<_i55.ProofMapper>(() => _i55.ProofMapper(
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.factory<_i56.ProofRequestFiltersMapper>(
      () => _i56.ProofRequestFiltersMapper());
  gh.factory<_i57.ProverLib>(() => _i57.ProverLib());
  gh.factory<_i58.ProverLibWrapper>(() => _i58.ProverLibWrapper());
  gh.factory<_i59.QMapper>(() => _i59.QMapper());
  gh.factory<_i60.RemoteClaimDataSource>(
      () => _i60.RemoteClaimDataSource(get<_i13.Client>()));
  gh.factory<_i61.RemoteIden3commDataSource>(
      () => _i61.RemoteIden3commDataSource(get<_i13.Client>()));
  gh.factory<_i62.RemoteIdentityDataSource>(
      () => _i62.RemoteIdentityDataSource());
  gh.factory<_i63.RevocationStatusMapper>(() => _i63.RevocationStatusMapper());
  gh.factory<_i64.RhsNodeTypeMapper>(() => _i64.RhsNodeTypeMapper());
  gh.factoryParam<_i15.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i65.StateIdentifierMapper>(() => _i65.StateIdentifierMapper());
  gh.factory<_i15.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i15.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
  );
  gh.factory<_i66.TreeStateMapper>(() => _i66.TreeStateMapper());
  gh.factory<_i67.TreeTypeMapper>(() => _i67.TreeTypeMapper());
  gh.factory<_i68.WalletLibWrapper>(() => _i68.WalletLibWrapper());
  gh.factoryParam<_i69.Web3Client, _i70.EnvEntity, dynamic>((
    env,
    _,
  ) =>
      networkModule.web3client(env));
  gh.factory<_i71.WitnessAuthV2Lib>(() => _i71.WitnessAuthV2Lib());
  gh.factory<_i72.WitnessIsolatesWrapper>(() => _i72.WitnessIsolatesWrapper());
  gh.factory<_i73.WitnessMTPV2Lib>(() => _i73.WitnessMTPV2Lib());
  gh.factory<_i74.WitnessMTPV2OnchainLib>(() => _i74.WitnessMTPV2OnchainLib());
  gh.factory<_i75.WitnessSigV2Lib>(() => _i75.WitnessSigV2Lib());
  gh.factory<_i76.WitnessSigV2OnchainLib>(() => _i76.WitnessSigV2OnchainLib());
  gh.factory<_i77.ZipDecoder>(
    () => filesManagerModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i78.AuthProofMapper>(() => _i78.AuthProofMapper(
        get<_i27.HashMapper>(),
        get<_i39.NodeAuxMapper>(),
      ));
  gh.factory<_i79.CircuitsFilesDataSource>(
      () => _i79.CircuitsFilesDataSource(get<_i16.Directory>()));
  gh.factory<_i80.ClaimMapper>(() => _i80.ClaimMapper(
        get<_i12.ClaimStateMapper>(),
        get<_i11.ClaimInfoMapper>(),
      ));
  gh.factory<_i81.ClaimStoreRefWrapper>(() => _i81.ClaimStoreRefWrapper(
      get<_i15.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i82.GistProofMapper>(
      () => _i82.GistProofMapper(get<_i55.ProofMapper>()));
  gh.factory<_i83.GistProofMapper>(
      () => _i83.GistProofMapper(get<_i27.HashMapper>()));
  gh.factory<_i84.Iden3commCredentialRepositoryImpl>(
      () => _i84.Iden3commCredentialRepositoryImpl(
            get<_i61.RemoteIden3commDataSource>(),
            get<_i56.ProofRequestFiltersMapper>(),
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
  gh.factory<_i58.ProverLibDataSource>(
      () => _i58.ProverLibDataSource(get<_i58.ProverLibWrapper>()));
  gh.factory<_i96.RhsNodeMapper>(
      () => _i96.RhsNodeMapper(get<_i64.RhsNodeTypeMapper>()));
  gh.factory<_i97.SecureInteractionStoreRefWrapper>(() =>
      _i97.SecureInteractionStoreRefWrapper(
          get<_i15.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i97.SecureStorageInteractionDataSource>(() =>
      _i97.SecureStorageInteractionDataSource(
          get<_i97.SecureInteractionStoreRefWrapper>()));
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
  gh.factory<_i68.WalletDataSource>(
      () => _i68.WalletDataSource(get<_i68.WalletLibWrapper>()));
  gh.factory<_i72.WitnessDataSource>(
      () => _i72.WitnessDataSource(get<_i72.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i98.ConfigRepositoryImpl>(
      () async => _i98.ConfigRepositoryImpl(
            await get.getAsync<_i88.StorageKeyValueDataSource>(),
            get<_i20.EnvMapper>(),
          ));
  gh.factory<_i99.CredentialRepositoryImpl>(() => _i99.CredentialRepositoryImpl(
        get<_i60.RemoteClaimDataSource>(),
        get<_i81.StorageClaimDataSource>(),
        get<_i93.LocalClaimDataSource>(),
        get<_i80.ClaimMapper>(),
        get<_i22.FiltersMapper>(),
        get<_i29.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i100.GetPackageNameUseCase>(() async =>
      _i100.GetPackageNameUseCase(
          await get.getAsync<_i95.PackageInfoRepository>()));
  gh.factory<_i101.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i84.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i102.Iden3commRepositoryImpl>(() => _i102.Iden3commRepositoryImpl(
        get<_i61.RemoteIden3commDataSource>(),
        get<_i90.LibPolygonIdCoreIden3commDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i78.AuthProofMapper>(),
        get<_i83.GistProofMapper>(),
        get<_i59.QMapper>(),
      ));
  gh.factoryAsync<_i103.InteractionRepositoryImpl>(
      () async => _i103.InteractionRepositoryImpl(
            get<_i97.SecureStorageInteractionDataSource>(),
            await get.getAsync<_i87.StorageInteractionDataSource>(),
            get<_i33.InteractionMapper>(),
            get<_i22.FiltersMapper>(),
            get<_i32.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i92.LibPolygonIdCoreProofDataSource>(() =>
      _i92.LibPolygonIdCoreProofDataSource(
          get<_i92.LibPolygonIdCoreWrapper>()));
  gh.factory<_i104.SMTDataSource>(() => _i104.SMTDataSource(
        get<_i28.HexMapper>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i85.StorageSMTDataSource>(),
      ));
  gh.factory<_i105.SMTRepositoryImpl>(() => _i105.SMTRepositoryImpl(
        get<_i104.SMTDataSource>(),
        get<_i85.StorageSMTDataSource>(),
        get<_i36.LibBabyJubJubDataSource>(),
        get<_i94.NodeMapper>(),
        get<_i27.HashMapper>(),
        get<_i55.ProofMapper>(),
        get<_i67.TreeTypeMapper>(),
        get<_i66.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i106.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i98.ConfigRepositoryImpl>()));
  gh.factory<_i107.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i99.CredentialRepositoryImpl>()));
  gh.factory<_i108.GetAuthClaimUseCase>(
      () => _i108.GetAuthClaimUseCase(get<_i107.CredentialRepository>()));
  gh.factoryAsync<_i109.GetEnvUseCase>(() async =>
      _i109.GetEnvUseCase(await get.getAsync<_i106.ConfigRepository>()));
  gh.factory<_i110.GetProofQueryContextUseCase>(() =>
      _i110.GetProofQueryContextUseCase(
          get<_i101.Iden3commCredentialRepository>()));
  gh.factory<_i111.GetProofRequestsUseCase>(() => _i111.GetProofRequestsUseCase(
        get<_i110.GetProofQueryContextUseCase>(),
        get<_i26.GetProofQueryUseCase>(),
      ));
  gh.factory<_i112.GetSchemasUseCase>(() =>
      _i112.GetSchemasUseCase(get<_i101.Iden3commCredentialRepository>()));
  gh.factory<_i113.GetVocabsUseCase>(
      () => _i113.GetVocabsUseCase(get<_i101.Iden3commCredentialRepository>()));
  gh.factory<_i114.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i102.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i115.InteractionRepository>(() async =>
      repositoriesModule.interactionRepository(
          await get.getAsync<_i103.InteractionRepositoryImpl>()));
  gh.factoryAsync<_i116.ListenAndStoreNotificationUseCase>(() async =>
      _i116.ListenAndStoreNotificationUseCase(
          await get.getAsync<_i115.InteractionRepository>()));
  gh.factoryAsync<_i117.RPCDataSource>(() async =>
      _i117.RPCDataSource(await get.getAsync<_i109.GetEnvUseCase>()));
  gh.factory<_i118.RemoveAllClaimsUseCase>(
      () => _i118.RemoveAllClaimsUseCase(get<_i107.CredentialRepository>()));
  gh.factory<_i119.RemoveClaimsUseCase>(
      () => _i119.RemoveClaimsUseCase(get<_i107.CredentialRepository>()));
  gh.factory<_i120.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i105.SMTRepositoryImpl>()));
  gh.factory<_i121.SaveClaimsUseCase>(
      () => _i121.SaveClaimsUseCase(get<_i107.CredentialRepository>()));
  gh.factoryAsync<_i122.SetEnvUseCase>(() async =>
      _i122.SetEnvUseCase(await get.getAsync<_i106.ConfigRepository>()));
  gh.factory<_i123.UpdateClaimUseCase>(
      () => _i123.UpdateClaimUseCase(get<_i107.CredentialRepository>()));
  gh.factory<_i124.GetAuthChallengeUseCase>(
      () => _i124.GetAuthChallengeUseCase(get<_i114.Iden3commRepository>()));
  gh.factory<_i125.GetLatestStateUseCase>(
      () => _i125.GetLatestStateUseCase(get<_i120.SMTRepository>()));
  gh.factoryAsync<_i126.IdentityRepositoryImpl>(
      () async => _i126.IdentityRepositoryImpl(
            get<_i68.WalletDataSource>(),
            get<_i62.RemoteIdentityDataSource>(),
            await get.getAsync<_i86.StorageIdentityDataSource>(),
            await get.getAsync<_i117.RPCDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i36.LibBabyJubJubDataSource>(),
            get<_i91.LibPolygonIdCoreIdentityDataSource>(),
            get<_i18.EncryptionDbDataSource>(),
            get<_i14.DestinationPathDataSource>(),
            get<_i28.HexMapper>(),
            get<_i52.PrivateKeyMapper>(),
            get<_i31.IdentityDTOMapper>(),
            get<_i96.RhsNodeMapper>(),
            get<_i65.StateIdentifierMapper>(),
            get<_i94.NodeMapper>(),
            get<_i19.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i127.ProofRepositoryImpl>(
      () async => _i127.ProofRepositoryImpl(
            get<_i72.WitnessDataSource>(),
            get<_i58.ProverLibDataSource>(),
            get<_i92.LibPolygonIdCoreProofDataSource>(),
            get<_i38.LocalProofFilesDataSource>(),
            get<_i53.ProofCircuitDataSource>(),
            get<_i62.RemoteIdentityDataSource>(),
            get<_i37.LocalContractFilesDataSource>(),
            get<_i10.CircuitsDownloadDataSource>(),
            await get.getAsync<_i117.RPCDataSource>(),
            get<_i9.CircuitTypeMapper>(),
            get<_i35.JWZProofMapper>(),
            get<_i80.ClaimMapper>(),
            get<_i63.RevocationStatusMapper>(),
            get<_i34.JWZMapper>(),
            get<_i78.AuthProofMapper>(),
            get<_i82.GistProofMapper>(),
            get<_i83.GistProofMapper>(),
            get<_i79.CircuitsFilesDataSource>(),
          ));
  gh.factory<_i128.RemoveIdentityStateUseCase>(
      () => _i128.RemoveIdentityStateUseCase(get<_i120.SMTRepository>()));
  gh.factoryAsync<_i129.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i126.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i130.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i127.ProofRepositoryImpl>()));
  gh.factoryAsync<_i131.ProveUseCase>(() async =>
      _i131.ProveUseCase(await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i132.SignMessageUseCase>(() async =>
      _i132.SignMessageUseCase(await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i133.CancelDownloadCircuitsUseCase>(() async =>
      _i133.CancelDownloadCircuitsUseCase(
          await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i134.CircuitsFilesExistUseCase>(() async =>
      _i134.CircuitsFilesExistUseCase(
          await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i135.DownloadCircuitsUseCase>(() async =>
      _i135.DownloadCircuitsUseCase(
          await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i136.FetchStateRootsUseCase>(() async =>
      _i136.FetchStateRootsUseCase(
          await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i137.GetDidUseCase>(() async =>
      _i137.GetDidUseCase(await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i138.GetGistProofUseCase>(
      () async => _i138.GetGistProofUseCase(
            await get.getAsync<_i130.ProofRepository>(),
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i137.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i139.GetIdentitiesUseCase>(() async =>
      _i139.GetIdentitiesUseCase(
          await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i140.GetIdentityAuthClaimUseCase>(
      () async => _i140.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i108.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i141.GetJWZUseCase>(() async =>
      _i141.GetJWZUseCase(await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i142.GetPrivateKeyUseCase>(() async =>
      _i142.GetPrivateKeyUseCase(
          await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i143.GetPublicKeysUseCase>(() async =>
      _i143.GetPublicKeysUseCase(
          await get.getAsync<_i129.IdentityRepository>()));
  gh.factoryAsync<_i144.IsProofCircuitSupportedUseCase>(() async =>
      _i144.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i145.LoadCircuitUseCase>(() async =>
      _i145.LoadCircuitUseCase(await get.getAsync<_i130.ProofRepository>()));
  gh.factoryAsync<_i146.CreateIdentityStateUseCase>(
      () async => _i146.CreateIdentityStateUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i120.SMTRepository>(),
            await get.getAsync<_i140.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i147.FetchIdentityStateUseCase>(
      () async => _i147.FetchIdentityStateUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i137.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i148.GenerateNonRevProofUseCase>(
      () async => _i148.GenerateNonRevProofUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i107.CredentialRepository>(),
            await get.getAsync<_i147.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i149.GetClaimRevocationStatusUseCase>(
      () async => _i149.GetClaimRevocationStatusUseCase(
            get<_i107.CredentialRepository>(),
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i148.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i150.GetFiltersUseCase>(() async => _i150.GetFiltersUseCase(
        get<_i101.Iden3commCredentialRepository>(),
        await get.getAsync<_i144.IsProofCircuitSupportedUseCase>(),
        get<_i111.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i151.GetGenesisStateUseCase>(
      () async => _i151.GetGenesisStateUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i120.SMTRepository>(),
            await get.getAsync<_i140.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i152.GetDidIdentifierUseCase>(
      () async => _i152.GetDidIdentifierUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i151.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i153.GetIdentityUseCase>(
      () async => _i153.GetIdentityUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i137.GetDidUseCase>(),
            await get.getAsync<_i152.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i154.GetInteractionsUseCase>(
      () async => _i154.GetInteractionsUseCase(
            await get.getAsync<_i115.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i155.RemoveInteractionsUseCase>(
      () async => _i155.RemoveInteractionsUseCase(
            await get.getAsync<_i115.InteractionRepository>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i156.AddInteractionUseCase>(
      () async => _i156.AddInteractionUseCase(
            await get.getAsync<_i115.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i157.CheckProfileAndDidCurrentEnvUseCase(
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i152.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i158.GenerateProofUseCase>(
      () async => _i158.GenerateProofUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i120.SMTRepository>(),
            await get.getAsync<_i130.ProofRepository>(),
            await get.getAsync<_i131.ProveUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
            get<_i108.GetAuthClaimUseCase>(),
            await get.getAsync<_i138.GetGistProofUseCase>(),
            await get.getAsync<_i137.GetDidUseCase>(),
            await get.getAsync<_i132.SignMessageUseCase>(),
            get<_i125.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i159.GetAuthInputsUseCase>(
      () async => _i159.GetAuthInputsUseCase(
            await get.getAsync<_i153.GetIdentityUseCase>(),
            get<_i108.GetAuthClaimUseCase>(),
            await get.getAsync<_i132.SignMessageUseCase>(),
            await get.getAsync<_i138.GetGistProofUseCase>(),
            get<_i125.GetLatestStateUseCase>(),
            get<_i114.Iden3commRepository>(),
            await get.getAsync<_i129.IdentityRepository>(),
            get<_i120.SMTRepository>(),
          ));
  gh.factoryAsync<_i160.GetAuthTokenUseCase>(
      () async => _i160.GetAuthTokenUseCase(
            await get.getAsync<_i145.LoadCircuitUseCase>(),
            await get.getAsync<_i141.GetJWZUseCase>(),
            get<_i124.GetAuthChallengeUseCase>(),
            await get.getAsync<_i159.GetAuthInputsUseCase>(),
            await get.getAsync<_i131.ProveUseCase>(),
          ));
  gh.factoryAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i161.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i152.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i162.GetProfilesUseCase>(
      () async => _i162.GetProfilesUseCase(
            await get.getAsync<_i153.GetIdentityUseCase>(),
            await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i163.Proof>(() async => _i163.Proof(
        await get.getAsync<_i158.GenerateProofUseCase>(),
        await get.getAsync<_i135.DownloadCircuitsUseCase>(),
        await get.getAsync<_i134.CircuitsFilesExistUseCase>(),
        get<_i54.ProofGenerationStepsStreamManager>(),
        await get.getAsync<_i133.CancelDownloadCircuitsUseCase>(),
      ));
  gh.factoryAsync<_i164.UpdateInteractionUseCase>(
      () async => _i164.UpdateInteractionUseCase(
            await get.getAsync<_i115.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
            await get.getAsync<_i156.AddInteractionUseCase>(),
          ));
  gh.factoryAsync<_i165.BackupIdentityUseCase>(
      () async => _i165.BackupIdentityUseCase(
            await get.getAsync<_i153.GetIdentityUseCase>(),
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i166.CheckIdentityValidityUseCase>(
      () async => _i166.CheckIdentityValidityUseCase(
            await get.getAsync<_i142.GetPrivateKeyUseCase>(),
            await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i167.CreateIdentityUseCase>(
      () async => _i167.CreateIdentityUseCase(
            await get.getAsync<_i143.GetPublicKeysUseCase>(),
            await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i168.CreateProfilesUseCase>(
      () async => _i168.CreateProfilesUseCase(
            await get.getAsync<_i143.GetPublicKeysUseCase>(),
            await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i169.FetchAndSaveClaimsUseCase>(
      () async => _i169.FetchAndSaveClaimsUseCase(
            get<_i101.Iden3commCredentialRepository>(),
            await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i152.GetDidIdentifierUseCase>(),
            get<_i23.GetFetchRequestsUseCase>(),
            await get.getAsync<_i160.GetAuthTokenUseCase>(),
            get<_i121.SaveClaimsUseCase>(),
            await get.getAsync<_i149.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i170.GetClaimsUseCase>(() async => _i170.GetClaimsUseCase(
        get<_i107.CredentialRepository>(),
        await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i153.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i171.GetIden3commClaimsUseCase>(
      () async => _i171.GetIden3commClaimsUseCase(
            get<_i101.Iden3commCredentialRepository>(),
            await get.getAsync<_i170.GetClaimsUseCase>(),
            await get.getAsync<_i149.GetClaimRevocationStatusUseCase>(),
            get<_i123.UpdateClaimUseCase>(),
            await get.getAsync<_i144.IsProofCircuitSupportedUseCase>(),
            get<_i111.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i172.GetIden3commProofsUseCase>(
      () async => _i172.GetIden3commProofsUseCase(
            await get.getAsync<_i130.ProofRepository>(),
            await get.getAsync<_i171.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i158.GenerateProofUseCase>(),
            await get.getAsync<_i144.IsProofCircuitSupportedUseCase>(),
            get<_i111.GetProofRequestsUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
            get<_i54.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i173.UpdateIdentityUseCase>(
      () async => _i173.UpdateIdentityUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i167.CreateIdentityUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i174.AddIdentityUseCase>(
      () async => _i174.AddIdentityUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i167.CreateIdentityUseCase>(),
            await get.getAsync<_i146.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i175.AddNewIdentityUseCase>(
      () async => _i175.AddNewIdentityUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i174.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i176.AddProfileUseCase>(() async => _i176.AddProfileUseCase(
        await get.getAsync<_i153.GetIdentityUseCase>(),
        await get.getAsync<_i173.UpdateIdentityUseCase>(),
        await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i168.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i177.AuthenticateUseCase>(
      () async => _i177.AuthenticateUseCase(
            get<_i114.Iden3commRepository>(),
            await get.getAsync<_i172.GetIden3commProofsUseCase>(),
            await get.getAsync<_i152.GetDidIdentifierUseCase>(),
            await get.getAsync<_i160.GetAuthTokenUseCase>(),
            await get.getAsync<_i109.GetEnvUseCase>(),
            await get.getAsync<_i100.GetPackageNameUseCase>(),
            await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i54.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i178.Credential>(() async => _i178.Credential(
        get<_i121.SaveClaimsUseCase>(),
        await get.getAsync<_i170.GetClaimsUseCase>(),
        get<_i119.RemoveClaimsUseCase>(),
        get<_i123.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i179.Iden3comm>(() async => _i179.Iden3comm(
        await get.getAsync<_i169.FetchAndSaveClaimsUseCase>(),
        get<_i25.GetIden3MessageUseCase>(),
        get<_i112.GetSchemasUseCase>(),
        get<_i113.GetVocabsUseCase>(),
        await get.getAsync<_i177.AuthenticateUseCase>(),
        await get.getAsync<_i150.GetFiltersUseCase>(),
        await get.getAsync<_i171.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i172.GetIden3commProofsUseCase>(),
        await get.getAsync<_i154.GetInteractionsUseCase>(),
        await get.getAsync<_i156.AddInteractionUseCase>(),
        await get.getAsync<_i155.RemoveInteractionsUseCase>(),
        await get.getAsync<_i164.UpdateInteractionUseCase>(),
      ));
  gh.factoryAsync<_i180.RemoveProfileUseCase>(
      () async => _i180.RemoveProfileUseCase(
            await get.getAsync<_i153.GetIdentityUseCase>(),
            await get.getAsync<_i173.UpdateIdentityUseCase>(),
            await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i168.CreateProfilesUseCase>(),
            get<_i128.RemoveIdentityStateUseCase>(),
            get<_i118.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i181.RestoreIdentityUseCase>(
      () async => _i181.RestoreIdentityUseCase(
            await get.getAsync<_i174.AddIdentityUseCase>(),
            await get.getAsync<_i153.GetIdentityUseCase>(),
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i161.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i182.RemoveIdentityUseCase>(
      () async => _i182.RemoveIdentityUseCase(
            await get.getAsync<_i129.IdentityRepository>(),
            await get.getAsync<_i162.GetProfilesUseCase>(),
            await get.getAsync<_i180.RemoveProfileUseCase>(),
            get<_i128.RemoveIdentityStateUseCase>(),
            get<_i118.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i157.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i183.Identity>(() async => _i183.Identity(
        await get.getAsync<_i166.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i142.GetPrivateKeyUseCase>(),
        await get.getAsync<_i175.AddNewIdentityUseCase>(),
        await get.getAsync<_i181.RestoreIdentityUseCase>(),
        await get.getAsync<_i165.BackupIdentityUseCase>(),
        await get.getAsync<_i153.GetIdentityUseCase>(),
        await get.getAsync<_i139.GetIdentitiesUseCase>(),
        await get.getAsync<_i182.RemoveIdentityUseCase>(),
        await get.getAsync<_i152.GetDidIdentifierUseCase>(),
        await get.getAsync<_i132.SignMessageUseCase>(),
        await get.getAsync<_i147.FetchIdentityStateUseCase>(),
        await get.getAsync<_i176.AddProfileUseCase>(),
        await get.getAsync<_i162.GetProfilesUseCase>(),
        await get.getAsync<_i180.RemoveProfileUseCase>(),
        await get.getAsync<_i137.GetDidUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i184.PlatformModule {}

class _$NetworkModule extends _i184.NetworkModule {}

class _$DatabaseModule extends _i184.DatabaseModule {}

class _$FilesManagerModule extends _i184.FilesManagerModule {}

class _$EncryptionModule extends _i184.EncryptionModule {}

class _$ChannelModule extends _i184.ChannelModule {}

class _$RepositoriesModule extends _i184.RepositoriesModule {}
