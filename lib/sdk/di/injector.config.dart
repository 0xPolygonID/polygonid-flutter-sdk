// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i15;

import 'package:archive/archive.dart' as _i75;
import 'package:encrypt/encrypt.dart' as _i16;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i41;
import 'package:sembast/sembast.dart' as _i14;
import 'package:web3dart/web3dart.dart' as _i67;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i19;
import '../../common/data/data_sources/mappers/filter_mapper.dart' as _i20;
import '../../common/data/data_sources/mappers/filters_mapper.dart' as _i21;
import '../../common/data/data_sources/package_info_datasource.dart' as _i42;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i87;
import '../../common/data/repositories/config_repository_impl.dart' as _i97;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i43;
import '../../common/domain/entities/env_entity.dart' as _i68;
import '../../common/domain/repositories/config_repository.dart' as _i105;
import '../../common/domain/repositories/package_info_repository.dart' as _i94;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i108;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i99;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i121;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i44;
import '../../credential/data/credential_repository_impl.dart' as _i98;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i88;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i92;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i58;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i80;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i10;
import '../../credential/data/mappers/claim_mapper.dart' as _i79;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i28;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i61;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i106;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i107;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i148;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i169;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i117;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i118;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i120;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i122;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i45;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i89;
import '../../iden3comm/data/data_sources/push_notification_data_source.dart'
    as _i7;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i59;
import '../../iden3comm/data/data_sources/secure_storage_interaction_data_source.dart'
    as _i96;
import '../../iden3comm/data/data_sources/storage_interaction_data_source.dart'
    as _i86;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i76;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i82;
import '../../iden3comm/data/mappers/interaction_id_filter_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/interaction_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i54;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i83;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i101;
import '../../iden3comm/data/repositories/interaction_repository_impl.dart'
    as _i102;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i100;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i113;
import '../../iden3comm/domain/repositories/interaction_repository.dart'
    as _i114;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i176;
import '../../iden3comm/domain/use_cases/check_profile_and_did_current_env.dart'
    as _i156;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i168;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i123;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i158;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i159;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i149;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i170;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i171;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_proof_query_context_use_case.dart'
    as _i109;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i25;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i110;
import '../../iden3comm/domain/use_cases/get_schemas_use_case.dart' as _i111;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i112;
import '../../iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart'
    as _i155;
import '../../iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart'
    as _i153;
import '../../iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart'
    as _i154;
import '../../iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart'
    as _i163;
import '../../iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart'
    as _i115;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i46;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i13;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i17;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i35;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i90;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i36;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i116;
import '../../identity/data/data_sources/smt_data_source.dart' as _i103;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i85;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i84;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i66;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i18;
import '../../identity/data/mappers/hash_mapper.dart' as _i26;
import '../../identity/data/mappers/hex_mapper.dart' as _i27;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i30;
import '../../identity/data/mappers/node_mapper.dart' as _i93;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i38;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i39;
import '../../identity/data/mappers/node_type_mapper.dart' as _i40;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i49;
import '../../identity/data/mappers/private_key_mapper.dart' as _i50;
import '../../identity/data/mappers/q_mapper.dart' as _i57;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i95;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i62;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i63;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i64;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i65;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i125;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i104;
import '../../identity/domain/repositories/identity_repository.dart' as _i128;
import '../../identity/domain/repositories/smt_repository.dart' as _i119;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i146;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i135;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i160;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i151;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i136;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i150;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i139;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i124;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i142;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i173;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i174;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i164;
import '../../identity/domain/use_cases/identity/check_identity_validity_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i166;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i138;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i152;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i141;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i181;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i180;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i131;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i172;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i175;
import '../../identity/domain/use_cases/profile/check_profile_validity_use_case.dart'
    as _i8;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i167;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i179;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i145;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i127;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i47;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i77;
import '../../proof/data/data_sources/circuits_files_data_source.dart' as _i78;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i91;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i51;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i56;
import '../../proof/data/data_sources/witness_data_source.dart' as _i70;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i9;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i81;
import '../../proof/data/mappers/jwz_mapper.dart' as _i33;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i34;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i37;
import '../../proof/data/mappers/proof_mapper.dart' as _i53;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i126;
import '../../proof/domain/repositories/proof_repository.dart' as _i129;
import '../../proof/domain/use_cases/cancel_download_circuits_use_case.dart'
    as _i132;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i133;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i134;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i157;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i137;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i140;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i143;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i144;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i130;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i52;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i48;
import '../../proof/libs/prover/prover.dart' as _i55;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i69;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i71;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i72;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i73;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i74;
import '../credential.dart' as _i177;
import '../iden3comm.dart' as _i178;
import '../identity.dart' as _i182;
import '../mappers/iden3_message_type_mapper.dart' as _i29;
import '../proof.dart' as _i162;
import 'injector.dart' as _i183; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i10.ClaimInfoMapper>(() => _i10.ClaimInfoMapper());
  gh.factory<_i11.ClaimStateMapper>(() => _i11.ClaimStateMapper());
  gh.factory<_i12.Client>(() => networkModule.client);
  gh.factory<_i13.CreatePathWrapper>(() => _i13.CreatePathWrapper());
  gh.lazySingletonAsync<_i14.Database>(() => databaseModule.database());
  gh.factoryParamAsync<_i14.Database, String?, String?>(
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
  gh.factory<_i13.DestinationPathDataSource>(
      () => _i13.DestinationPathDataSource(get<_i13.CreatePathWrapper>()));
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
  gh.factory<_i26.HashMapper>(() => _i26.HashMapper());
  gh.factory<_i27.HexMapper>(() => _i27.HexMapper());
  gh.factory<_i28.IdFilterMapper>(() => _i28.IdFilterMapper());
  gh.factory<_i29.Iden3MessageTypeMapper>(() => _i29.Iden3MessageTypeMapper());
  gh.factory<_i30.IdentityDTOMapper>(() => _i30.IdentityDTOMapper());
  gh.factory<_i31.InteractionIdFilterMapper>(
      () => _i31.InteractionIdFilterMapper());
  gh.factory<_i32.InteractionMapper>(() => _i32.InteractionMapper());
  gh.factory<_i33.JWZMapper>(() => _i33.JWZMapper());
  gh.factory<_i34.JWZProofMapper>(() => _i34.JWZProofMapper());
  gh.factory<_i35.LibBabyJubJubDataSource>(
      () => _i35.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i36.LocalContractFilesDataSource>(
      () => _i36.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.identityStateStore,
    instanceName: 'identityStateStore',
  );
  gh.lazySingleton<_i3.MethodChannel>(() => channelModule.methodChannel);
  gh.factory<_i37.NodeAuxMapper>(() => _i37.NodeAuxMapper());
  gh.factory<_i38.NodeTypeDTOMapper>(() => _i38.NodeTypeDTOMapper());
  gh.factory<_i39.NodeTypeEntityMapper>(() => _i39.NodeTypeEntityMapper());
  gh.factory<_i40.NodeTypeMapper>(() => _i40.NodeTypeMapper());
  gh.lazySingletonAsync<_i41.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i42.PackageInfoDataSource>(() async =>
      _i42.PackageInfoDataSource(await get.getAsync<_i41.PackageInfo>()));
  gh.factoryAsync<_i43.PackageInfoRepositoryImpl>(() async =>
      _i43.PackageInfoRepositoryImpl(
          await get.getAsync<_i42.PackageInfoDataSource>()));
  gh.factory<_i44.PolygonIdCore>(() => _i44.PolygonIdCore());
  gh.factory<_i45.PolygonIdCoreCredential>(
      () => _i45.PolygonIdCoreCredential());
  gh.factory<_i46.PolygonIdCoreIden3comm>(() => _i46.PolygonIdCoreIden3comm());
  gh.factory<_i47.PolygonIdCoreIdentity>(() => _i47.PolygonIdCoreIdentity());
  gh.factory<_i48.PolygonIdCoreProof>(() => _i48.PolygonIdCoreProof());
  gh.factory<_i49.PoseidonHashMapper>(
      () => _i49.PoseidonHashMapper(get<_i27.HexMapper>()));
  gh.factory<_i50.PrivateKeyMapper>(() => _i50.PrivateKeyMapper());
  gh.factory<_i51.ProofCircuitDataSource>(() => _i51.ProofCircuitDataSource());
  gh.lazySingleton<_i52.ProofGenerationStepsStreamManager>(
      () => _i52.ProofGenerationStepsStreamManager());
  gh.factory<_i53.ProofMapper>(() => _i53.ProofMapper(
        get<_i26.HashMapper>(),
        get<_i37.NodeAuxMapper>(),
      ));
  gh.factory<_i54.ProofRequestFiltersMapper>(
      () => _i54.ProofRequestFiltersMapper());
  gh.factory<_i55.ProverLib>(() => _i55.ProverLib());
  gh.factory<_i56.ProverLibWrapper>(() => _i56.ProverLibWrapper());
  gh.factory<_i57.QMapper>(() => _i57.QMapper());
  gh.factory<_i58.RemoteClaimDataSource>(
      () => _i58.RemoteClaimDataSource(get<_i12.Client>()));
  gh.factory<_i59.RemoteIden3commDataSource>(
      () => _i59.RemoteIden3commDataSource(get<_i12.Client>()));
  gh.factory<_i60.RemoteIdentityDataSource>(
      () => _i60.RemoteIdentityDataSource());
  gh.factory<_i61.RevocationStatusMapper>(() => _i61.RevocationStatusMapper());
  gh.factory<_i62.RhsNodeTypeMapper>(() => _i62.RhsNodeTypeMapper());
  gh.factoryParam<_i14.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i63.StateIdentifierMapper>(() => _i63.StateIdentifierMapper());
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.interactionStore,
    instanceName: 'interactionStore',
  );
  gh.factory<_i14.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i64.TreeStateMapper>(() => _i64.TreeStateMapper());
  gh.factory<_i65.TreeTypeMapper>(() => _i65.TreeTypeMapper());
  gh.factory<_i66.WalletLibWrapper>(() => _i66.WalletLibWrapper());
  gh.factoryParam<_i67.Web3Client, _i68.EnvEntity, dynamic>((
    env,
    _,
  ) =>
      networkModule.web3client(env));
  gh.factory<_i69.WitnessAuthV2Lib>(() => _i69.WitnessAuthV2Lib());
  gh.factory<_i70.WitnessIsolatesWrapper>(() => _i70.WitnessIsolatesWrapper());
  gh.factory<_i71.WitnessMTPV2Lib>(() => _i71.WitnessMTPV2Lib());
  gh.factory<_i72.WitnessMTPV2OnchainLib>(() => _i72.WitnessMTPV2OnchainLib());
  gh.factory<_i73.WitnessSigV2Lib>(() => _i73.WitnessSigV2Lib());
  gh.factory<_i74.WitnessSigV2OnchainLib>(() => _i74.WitnessSigV2OnchainLib());
  gh.factory<_i75.ZipDecoder>(() => filesManagerModule.zipDecoder());
  gh.factory<_i76.AuthProofMapper>(() => _i76.AuthProofMapper(
        get<_i26.HashMapper>(),
        get<_i37.NodeAuxMapper>(),
      ));
  gh.factory<_i77.CircuitsDownloadDataSource>(
      () => _i77.CircuitsDownloadDataSource(get<_i12.Client>()));
  gh.factoryAsync<_i78.CircuitsFilesDataSource>(() async =>
      _i78.CircuitsFilesDataSource(await get.getAsync<_i15.Directory>()));
  gh.factory<_i79.ClaimMapper>(() => _i79.ClaimMapper(
        get<_i11.ClaimStateMapper>(),
        get<_i10.ClaimInfoMapper>(),
      ));
  gh.factory<_i80.ClaimStoreRefWrapper>(() => _i80.ClaimStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i81.GistProofMapper>(
      () => _i81.GistProofMapper(get<_i53.ProofMapper>()));
  gh.factory<_i82.GistProofMapper>(
      () => _i82.GistProofMapper(get<_i26.HashMapper>()));
  gh.factory<_i83.Iden3commCredentialRepositoryImpl>(
      () => _i83.Iden3commCredentialRepositoryImpl(
            get<_i59.RemoteIden3commDataSource>(),
            get<_i54.ProofRequestFiltersMapper>(),
            get<_i79.ClaimMapper>(),
          ));
  gh.factory<_i84.IdentitySMTStoreRefWrapper>(() =>
      _i84.IdentitySMTStoreRefWrapper(
          get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'identityStateStore')));
  gh.factory<_i85.IdentityStoreRefWrapper>(() => _i85.IdentityStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i86.InteractionStoreRefWrapper>(() =>
      _i86.InteractionStoreRefWrapper(
          get<_i14.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i87.KeyValueStoreRefWrapper>(() => _i87.KeyValueStoreRefWrapper(
      get<_i14.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i88.LibPolygonIdCoreCredentialDataSource>(() =>
      _i88.LibPolygonIdCoreCredentialDataSource(
          get<_i45.PolygonIdCoreCredential>()));
  gh.factory<_i89.LibPolygonIdCoreIden3commDataSource>(() =>
      _i89.LibPolygonIdCoreIden3commDataSource(
          get<_i46.PolygonIdCoreIden3comm>()));
  gh.factory<_i90.LibPolygonIdCoreIdentityDataSource>(() =>
      _i90.LibPolygonIdCoreIdentityDataSource(
          get<_i47.PolygonIdCoreIdentity>()));
  gh.factory<_i91.LibPolygonIdCoreWrapper>(
      () => _i91.LibPolygonIdCoreWrapper(get<_i48.PolygonIdCoreProof>()));
  gh.factory<_i92.LocalClaimDataSource>(() => _i92.LocalClaimDataSource(
      get<_i88.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i93.NodeMapper>(() => _i93.NodeMapper(
        get<_i40.NodeTypeMapper>(),
        get<_i39.NodeTypeEntityMapper>(),
        get<_i38.NodeTypeDTOMapper>(),
        get<_i26.HashMapper>(),
      ));
  gh.factoryAsync<_i94.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i43.PackageInfoRepositoryImpl>()));
  gh.factory<_i56.ProverLibDataSource>(
      () => _i56.ProverLibDataSource(get<_i56.ProverLibWrapper>()));
  gh.factory<_i95.RhsNodeMapper>(
      () => _i95.RhsNodeMapper(get<_i62.RhsNodeTypeMapper>()));
  gh.factory<_i96.SecureInteractionStoreRefWrapper>(() =>
      _i96.SecureInteractionStoreRefWrapper(
          get<_i14.StoreRef<String, Map<String, Object?>>>(
              instanceName: 'interactionStore')));
  gh.factory<_i96.SecureStorageInteractionDataSource>(() =>
      _i96.SecureStorageInteractionDataSource(
          get<_i96.SecureInteractionStoreRefWrapper>()));
  gh.factory<_i80.StorageClaimDataSource>(
      () => _i80.StorageClaimDataSource(get<_i80.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i85.StorageIdentityDataSource>(
      () async => _i85.StorageIdentityDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i85.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i86.StorageInteractionDataSource>(
      () async => _i86.StorageInteractionDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i86.InteractionStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i87.StorageKeyValueDataSource>(
      () async => _i87.StorageKeyValueDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i87.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i84.StorageSMTDataSource>(
      () => _i84.StorageSMTDataSource(get<_i84.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i66.WalletDataSource>(
      () => _i66.WalletDataSource(get<_i66.WalletLibWrapper>()));
  gh.factory<_i70.WitnessDataSource>(
      () => _i70.WitnessDataSource(get<_i70.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i97.ConfigRepositoryImpl>(
      () async => _i97.ConfigRepositoryImpl(
            await get.getAsync<_i87.StorageKeyValueDataSource>(),
            get<_i19.EnvMapper>(),
          ));
  gh.factory<_i98.CredentialRepositoryImpl>(() => _i98.CredentialRepositoryImpl(
        get<_i58.RemoteClaimDataSource>(),
        get<_i80.StorageClaimDataSource>(),
        get<_i92.LocalClaimDataSource>(),
        get<_i79.ClaimMapper>(),
        get<_i21.FiltersMapper>(),
        get<_i28.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i99.GetPackageNameUseCase>(() async =>
      _i99.GetPackageNameUseCase(
          await get.getAsync<_i94.PackageInfoRepository>()));
  gh.factory<_i100.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i83.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i101.Iden3commRepositoryImpl>(() => _i101.Iden3commRepositoryImpl(
        get<_i59.RemoteIden3commDataSource>(),
        get<_i89.LibPolygonIdCoreIden3commDataSource>(),
        get<_i35.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i76.AuthProofMapper>(),
        get<_i82.GistProofMapper>(),
        get<_i57.QMapper>(),
      ));
  gh.factoryAsync<_i102.InteractionRepositoryImpl>(
      () async => _i102.InteractionRepositoryImpl(
            get<_i96.SecureStorageInteractionDataSource>(),
            await get.getAsync<_i86.StorageInteractionDataSource>(),
            get<_i32.InteractionMapper>(),
            get<_i21.FiltersMapper>(),
            get<_i31.InteractionIdFilterMapper>(),
          ));
  gh.factory<_i91.LibPolygonIdCoreProofDataSource>(() =>
      _i91.LibPolygonIdCoreProofDataSource(
          get<_i91.LibPolygonIdCoreWrapper>()));
  gh.factory<_i103.SMTDataSource>(() => _i103.SMTDataSource(
        get<_i27.HexMapper>(),
        get<_i35.LibBabyJubJubDataSource>(),
        get<_i84.StorageSMTDataSource>(),
      ));
  gh.factory<_i104.SMTRepositoryImpl>(() => _i104.SMTRepositoryImpl(
        get<_i103.SMTDataSource>(),
        get<_i84.StorageSMTDataSource>(),
        get<_i35.LibBabyJubJubDataSource>(),
        get<_i93.NodeMapper>(),
        get<_i26.HashMapper>(),
        get<_i53.ProofMapper>(),
        get<_i65.TreeTypeMapper>(),
        get<_i64.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i105.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i97.ConfigRepositoryImpl>()));
  gh.factory<_i106.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i98.CredentialRepositoryImpl>()));
  gh.factory<_i107.GetAuthClaimUseCase>(
      () => _i107.GetAuthClaimUseCase(get<_i106.CredentialRepository>()));
  gh.factoryAsync<_i108.GetEnvUseCase>(() async =>
      _i108.GetEnvUseCase(await get.getAsync<_i105.ConfigRepository>()));
  gh.factory<_i109.GetProofQueryContextUseCase>(() =>
      _i109.GetProofQueryContextUseCase(
          get<_i100.Iden3commCredentialRepository>()));
  gh.factory<_i110.GetProofRequestsUseCase>(() => _i110.GetProofRequestsUseCase(
        get<_i109.GetProofQueryContextUseCase>(),
        get<_i25.GetProofQueryUseCase>(),
      ));
  gh.factory<_i111.GetSchemasUseCase>(() =>
      _i111.GetSchemasUseCase(get<_i100.Iden3commCredentialRepository>()));
  gh.factory<_i112.GetVocabsUseCase>(
      () => _i112.GetVocabsUseCase(get<_i100.Iden3commCredentialRepository>()));
  gh.factory<_i113.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i101.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i114.InteractionRepository>(() async =>
      repositoriesModule.interactionRepository(
          await get.getAsync<_i102.InteractionRepositoryImpl>()));
  gh.factoryAsync<_i115.ListenAndStoreNotificationUseCase>(() async =>
      _i115.ListenAndStoreNotificationUseCase(
          await get.getAsync<_i114.InteractionRepository>()));
  gh.factoryAsync<_i116.RPCDataSource>(() async =>
      _i116.RPCDataSource(await get.getAsync<_i108.GetEnvUseCase>()));
  gh.factory<_i117.RemoveAllClaimsUseCase>(
      () => _i117.RemoveAllClaimsUseCase(get<_i106.CredentialRepository>()));
  gh.factory<_i118.RemoveClaimsUseCase>(
      () => _i118.RemoveClaimsUseCase(get<_i106.CredentialRepository>()));
  gh.factory<_i119.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i104.SMTRepositoryImpl>()));
  gh.factory<_i120.SaveClaimsUseCase>(
      () => _i120.SaveClaimsUseCase(get<_i106.CredentialRepository>()));
  gh.factoryAsync<_i121.SetEnvUseCase>(() async =>
      _i121.SetEnvUseCase(await get.getAsync<_i105.ConfigRepository>()));
  gh.factory<_i122.UpdateClaimUseCase>(
      () => _i122.UpdateClaimUseCase(get<_i106.CredentialRepository>()));
  gh.factory<_i123.GetAuthChallengeUseCase>(
      () => _i123.GetAuthChallengeUseCase(get<_i113.Iden3commRepository>()));
  gh.factory<_i124.GetLatestStateUseCase>(
      () => _i124.GetLatestStateUseCase(get<_i119.SMTRepository>()));
  gh.factoryAsync<_i125.IdentityRepositoryImpl>(
      () async => _i125.IdentityRepositoryImpl(
            get<_i66.WalletDataSource>(),
            get<_i60.RemoteIdentityDataSource>(),
            await get.getAsync<_i85.StorageIdentityDataSource>(),
            await get.getAsync<_i116.RPCDataSource>(),
            get<_i36.LocalContractFilesDataSource>(),
            get<_i35.LibBabyJubJubDataSource>(),
            get<_i90.LibPolygonIdCoreIdentityDataSource>(),
            get<_i17.EncryptionDbDataSource>(),
            get<_i13.DestinationPathDataSource>(),
            get<_i27.HexMapper>(),
            get<_i50.PrivateKeyMapper>(),
            get<_i30.IdentityDTOMapper>(),
            get<_i95.RhsNodeMapper>(),
            get<_i63.StateIdentifierMapper>(),
            get<_i93.NodeMapper>(),
            get<_i18.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i126.ProofRepositoryImpl>(
      () async => _i126.ProofRepositoryImpl(
            get<_i70.WitnessDataSource>(),
            get<_i56.ProverLibDataSource>(),
            get<_i91.LibPolygonIdCoreProofDataSource>(),
            get<_i51.ProofCircuitDataSource>(),
            get<_i60.RemoteIdentityDataSource>(),
            get<_i36.LocalContractFilesDataSource>(),
            get<_i77.CircuitsDownloadDataSource>(),
            await get.getAsync<_i116.RPCDataSource>(),
            get<_i9.CircuitTypeMapper>(),
            get<_i34.JWZProofMapper>(),
            get<_i79.ClaimMapper>(),
            get<_i61.RevocationStatusMapper>(),
            get<_i33.JWZMapper>(),
            get<_i76.AuthProofMapper>(),
            get<_i81.GistProofMapper>(),
            get<_i82.GistProofMapper>(),
            await get.getAsync<_i78.CircuitsFilesDataSource>(),
          ));
  gh.factory<_i127.RemoveIdentityStateUseCase>(
      () => _i127.RemoveIdentityStateUseCase(get<_i119.SMTRepository>()));
  gh.factoryAsync<_i128.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i125.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i129.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i126.ProofRepositoryImpl>()));
  gh.factoryAsync<_i130.ProveUseCase>(() async =>
      _i130.ProveUseCase(await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i131.SignMessageUseCase>(() async =>
      _i131.SignMessageUseCase(await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i132.CancelDownloadCircuitsUseCase>(() async =>
      _i132.CancelDownloadCircuitsUseCase(
          await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i133.CircuitsFilesExistUseCase>(() async =>
      _i133.CircuitsFilesExistUseCase(
          await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i134.DownloadCircuitsUseCase>(() async =>
      _i134.DownloadCircuitsUseCase(
          await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i135.FetchStateRootsUseCase>(() async =>
      _i135.FetchStateRootsUseCase(
          await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i136.GetDidUseCase>(() async =>
      _i136.GetDidUseCase(await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i137.GetGistProofUseCase>(
      () async => _i137.GetGistProofUseCase(
            await get.getAsync<_i129.ProofRepository>(),
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i136.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i138.GetIdentitiesUseCase>(() async =>
      _i138.GetIdentitiesUseCase(
          await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i139.GetIdentityAuthClaimUseCase>(
      () async => _i139.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i107.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i140.GetJWZUseCase>(() async =>
      _i140.GetJWZUseCase(await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i141.GetPrivateKeyUseCase>(() async =>
      _i141.GetPrivateKeyUseCase(
          await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i142.GetPublicKeysUseCase>(() async =>
      _i142.GetPublicKeysUseCase(
          await get.getAsync<_i128.IdentityRepository>()));
  gh.factoryAsync<_i143.IsProofCircuitSupportedUseCase>(() async =>
      _i143.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i144.LoadCircuitUseCase>(() async =>
      _i144.LoadCircuitUseCase(await get.getAsync<_i129.ProofRepository>()));
  gh.factoryAsync<_i145.CreateIdentityStateUseCase>(
      () async => _i145.CreateIdentityStateUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i119.SMTRepository>(),
            await get.getAsync<_i139.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i146.FetchIdentityStateUseCase>(
      () async => _i146.FetchIdentityStateUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i136.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i147.GenerateNonRevProofUseCase>(
      () async => _i147.GenerateNonRevProofUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i106.CredentialRepository>(),
            await get.getAsync<_i146.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i148.GetClaimRevocationStatusUseCase>(
      () async => _i148.GetClaimRevocationStatusUseCase(
            get<_i106.CredentialRepository>(),
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i147.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i149.GetFiltersUseCase>(() async => _i149.GetFiltersUseCase(
        get<_i100.Iden3commCredentialRepository>(),
        await get.getAsync<_i143.IsProofCircuitSupportedUseCase>(),
        get<_i110.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i150.GetGenesisStateUseCase>(
      () async => _i150.GetGenesisStateUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i119.SMTRepository>(),
            await get.getAsync<_i139.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i151.GetDidIdentifierUseCase>(
      () async => _i151.GetDidIdentifierUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i150.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i152.GetIdentityUseCase>(
      () async => _i152.GetIdentityUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i136.GetDidUseCase>(),
            await get.getAsync<_i151.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i153.GetInteractionsUseCase>(
      () async => _i153.GetInteractionsUseCase(
            await get.getAsync<_i114.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i154.RemoveInteractionsUseCase>(
      () async => _i154.RemoveInteractionsUseCase(
            await get.getAsync<_i114.InteractionRepository>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i155.AddInteractionUseCase>(
      () async => _i155.AddInteractionUseCase(
            await get.getAsync<_i114.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(
      () async => _i156.CheckProfileAndDidCurrentEnvUseCase(
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i151.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i157.GenerateProofUseCase>(
      () async => _i157.GenerateProofUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i119.SMTRepository>(),
            await get.getAsync<_i129.ProofRepository>(),
            await get.getAsync<_i130.ProveUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
            get<_i107.GetAuthClaimUseCase>(),
            await get.getAsync<_i137.GetGistProofUseCase>(),
            await get.getAsync<_i136.GetDidUseCase>(),
            await get.getAsync<_i131.SignMessageUseCase>(),
            get<_i124.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i158.GetAuthInputsUseCase>(
      () async => _i158.GetAuthInputsUseCase(
            await get.getAsync<_i152.GetIdentityUseCase>(),
            get<_i107.GetAuthClaimUseCase>(),
            await get.getAsync<_i131.SignMessageUseCase>(),
            await get.getAsync<_i137.GetGistProofUseCase>(),
            get<_i124.GetLatestStateUseCase>(),
            get<_i113.Iden3commRepository>(),
            await get.getAsync<_i128.IdentityRepository>(),
            get<_i119.SMTRepository>(),
          ));
  gh.factoryAsync<_i159.GetAuthTokenUseCase>(
      () async => _i159.GetAuthTokenUseCase(
            await get.getAsync<_i144.LoadCircuitUseCase>(),
            await get.getAsync<_i140.GetJWZUseCase>(),
            get<_i123.GetAuthChallengeUseCase>(),
            await get.getAsync<_i158.GetAuthInputsUseCase>(),
            await get.getAsync<_i130.ProveUseCase>(),
          ));
  gh.factoryAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i160.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i151.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i161.GetProfilesUseCase>(
      () async => _i161.GetProfilesUseCase(
            await get.getAsync<_i152.GetIdentityUseCase>(),
            await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i162.Proof>(() async => _i162.Proof(
        await get.getAsync<_i157.GenerateProofUseCase>(),
        await get.getAsync<_i134.DownloadCircuitsUseCase>(),
        await get.getAsync<_i133.CircuitsFilesExistUseCase>(),
        get<_i52.ProofGenerationStepsStreamManager>(),
        await get.getAsync<_i132.CancelDownloadCircuitsUseCase>(),
      ));
  gh.factoryAsync<_i163.UpdateInteractionUseCase>(
      () async => _i163.UpdateInteractionUseCase(
            await get.getAsync<_i114.InteractionRepository>(),
            get<_i8.CheckProfileValidityUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
            await get.getAsync<_i155.AddInteractionUseCase>(),
          ));
  gh.factoryAsync<_i164.BackupIdentityUseCase>(
      () async => _i164.BackupIdentityUseCase(
            await get.getAsync<_i152.GetIdentityUseCase>(),
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i165.CheckIdentityValidityUseCase>(
      () async => _i165.CheckIdentityValidityUseCase(
            await get.getAsync<_i141.GetPrivateKeyUseCase>(),
            await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i166.CreateIdentityUseCase>(
      () async => _i166.CreateIdentityUseCase(
            await get.getAsync<_i142.GetPublicKeysUseCase>(),
            await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i167.CreateProfilesUseCase>(
      () async => _i167.CreateProfilesUseCase(
            await get.getAsync<_i142.GetPublicKeysUseCase>(),
            await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i168.FetchAndSaveClaimsUseCase>(
      () async => _i168.FetchAndSaveClaimsUseCase(
            get<_i100.Iden3commCredentialRepository>(),
            await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i151.GetDidIdentifierUseCase>(),
            get<_i22.GetFetchRequestsUseCase>(),
            await get.getAsync<_i159.GetAuthTokenUseCase>(),
            get<_i120.SaveClaimsUseCase>(),
            await get.getAsync<_i148.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i169.GetClaimsUseCase>(() async => _i169.GetClaimsUseCase(
        get<_i106.CredentialRepository>(),
        await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i152.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i170.GetIden3commClaimsUseCase>(
      () async => _i170.GetIden3commClaimsUseCase(
            get<_i100.Iden3commCredentialRepository>(),
            await get.getAsync<_i169.GetClaimsUseCase>(),
            await get.getAsync<_i148.GetClaimRevocationStatusUseCase>(),
            get<_i122.UpdateClaimUseCase>(),
            await get.getAsync<_i143.IsProofCircuitSupportedUseCase>(),
            get<_i110.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i171.GetIden3commProofsUseCase>(
      () async => _i171.GetIden3commProofsUseCase(
            await get.getAsync<_i129.ProofRepository>(),
            await get.getAsync<_i170.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i157.GenerateProofUseCase>(),
            await get.getAsync<_i143.IsProofCircuitSupportedUseCase>(),
            get<_i110.GetProofRequestsUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
            get<_i52.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i172.UpdateIdentityUseCase>(
      () async => _i172.UpdateIdentityUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i166.CreateIdentityUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i173.AddIdentityUseCase>(
      () async => _i173.AddIdentityUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i166.CreateIdentityUseCase>(),
            await get.getAsync<_i145.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i174.AddNewIdentityUseCase>(
      () async => _i174.AddNewIdentityUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i173.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i175.AddProfileUseCase>(() async => _i175.AddProfileUseCase(
        await get.getAsync<_i152.GetIdentityUseCase>(),
        await get.getAsync<_i172.UpdateIdentityUseCase>(),
        await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
        await get.getAsync<_i167.CreateProfilesUseCase>(),
      ));
  gh.factoryAsync<_i176.AuthenticateUseCase>(
      () async => _i176.AuthenticateUseCase(
            get<_i113.Iden3commRepository>(),
            await get.getAsync<_i171.GetIden3commProofsUseCase>(),
            await get.getAsync<_i151.GetDidIdentifierUseCase>(),
            await get.getAsync<_i159.GetAuthTokenUseCase>(),
            await get.getAsync<_i108.GetEnvUseCase>(),
            await get.getAsync<_i99.GetPackageNameUseCase>(),
            await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
            get<_i52.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i177.Credential>(() async => _i177.Credential(
        get<_i120.SaveClaimsUseCase>(),
        await get.getAsync<_i169.GetClaimsUseCase>(),
        get<_i118.RemoveClaimsUseCase>(),
        get<_i122.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i178.Iden3comm>(() async => _i178.Iden3comm(
        await get.getAsync<_i168.FetchAndSaveClaimsUseCase>(),
        get<_i24.GetIden3MessageUseCase>(),
        get<_i111.GetSchemasUseCase>(),
        get<_i112.GetVocabsUseCase>(),
        await get.getAsync<_i176.AuthenticateUseCase>(),
        await get.getAsync<_i149.GetFiltersUseCase>(),
        await get.getAsync<_i170.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i171.GetIden3commProofsUseCase>(),
        await get.getAsync<_i153.GetInteractionsUseCase>(),
        await get.getAsync<_i155.AddInteractionUseCase>(),
        await get.getAsync<_i154.RemoveInteractionsUseCase>(),
        await get.getAsync<_i163.UpdateInteractionUseCase>(),
      ));
  gh.factoryAsync<_i179.RemoveProfileUseCase>(
      () async => _i179.RemoveProfileUseCase(
            await get.getAsync<_i152.GetIdentityUseCase>(),
            await get.getAsync<_i172.UpdateIdentityUseCase>(),
            await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
            await get.getAsync<_i167.CreateProfilesUseCase>(),
            get<_i127.RemoveIdentityStateUseCase>(),
            get<_i117.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i180.RestoreIdentityUseCase>(
      () async => _i180.RestoreIdentityUseCase(
            await get.getAsync<_i173.AddIdentityUseCase>(),
            await get.getAsync<_i152.GetIdentityUseCase>(),
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i160.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i181.RemoveIdentityUseCase>(
      () async => _i181.RemoveIdentityUseCase(
            await get.getAsync<_i128.IdentityRepository>(),
            await get.getAsync<_i161.GetProfilesUseCase>(),
            await get.getAsync<_i179.RemoveProfileUseCase>(),
            get<_i127.RemoveIdentityStateUseCase>(),
            get<_i117.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i156.CheckProfileAndDidCurrentEnvUseCase>(),
          ));
  gh.factoryAsync<_i182.Identity>(() async => _i182.Identity(
        await get.getAsync<_i165.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i141.GetPrivateKeyUseCase>(),
        await get.getAsync<_i174.AddNewIdentityUseCase>(),
        await get.getAsync<_i180.RestoreIdentityUseCase>(),
        await get.getAsync<_i164.BackupIdentityUseCase>(),
        await get.getAsync<_i152.GetIdentityUseCase>(),
        await get.getAsync<_i138.GetIdentitiesUseCase>(),
        await get.getAsync<_i181.RemoveIdentityUseCase>(),
        await get.getAsync<_i151.GetDidIdentifierUseCase>(),
        await get.getAsync<_i131.SignMessageUseCase>(),
        await get.getAsync<_i146.FetchIdentityStateUseCase>(),
        await get.getAsync<_i175.AddProfileUseCase>(),
        await get.getAsync<_i161.GetProfilesUseCase>(),
        await get.getAsync<_i179.RemoveProfileUseCase>(),
        await get.getAsync<_i136.GetDidUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i183.PlatformModule {}

class _$NetworkModule extends _i183.NetworkModule {}

class _$DatabaseModule extends _i183.DatabaseModule {}

class _$FilesManagerModule extends _i183.FilesManagerModule {}

class _$EncryptionModule extends _i183.EncryptionModule {}

class _$ChannelModule extends _i183.ChannelModule {}

class _$RepositoriesModule extends _i183.RepositoriesModule {}
