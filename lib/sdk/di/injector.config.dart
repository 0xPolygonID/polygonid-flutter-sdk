// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i71;
import 'package:encrypt/encrypt.dart' as _i14;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i39;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i108;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i17;
import '../../common/data/data_sources/package_info_datasource.dart' as _i40;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i80;
import '../../common/data/repositories/config_repository_impl.dart' as _i89;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i41;
import '../../common/domain/repositories/config_repository.dart' as _i96;
import '../../common/domain/repositories/package_info_repository.dart' as _i87;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i100;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i91;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i106;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i42;
import '../../credential/data/credential_repository_impl.dart' as _i90;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i81;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i85;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i56;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i74;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i73;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i18;
import '../../credential/data/mappers/filters_mapper.dart' as _i19;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i27;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i59;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i97;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i98;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i135;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i99;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i103;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i104;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i149;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i107;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i43;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i82;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i57;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i72;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i76;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i52;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i77;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i93;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i92;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i102;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i150;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i155;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i109;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i144;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i145;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i136;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i138;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i147;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i21;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i23;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i101;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i44;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i15;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i32;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i83;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i33;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i58;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i111;
import '../../identity/data/data_sources/smt_data_source.dart' as _i94;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i79;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i78;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i64;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i16;
import '../../identity/data/mappers/hash_mapper.dart' as _i25;
import '../../identity/data/mappers/hex_mapper.dart' as _i26;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i29;
import '../../identity/data/mappers/node_mapper.dart' as _i86;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i36;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i37;
import '../../identity/data/mappers/node_type_mapper.dart' as _i38;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i47;
import '../../identity/data/mappers/private_key_mapper.dart' as _i48;
import '../../identity/data/mappers/q_mapper.dart' as _i55;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i88;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i60;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i61;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i62;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i63;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i113;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i95;
import '../../identity/domain/repositories/identity_repository.dart' as _i115;
import '../../identity/domain/repositories/smt_repository.dart' as _i105;
import '../../identity/domain/use_cases/check_identity_validity_use_case.dart'
    as _i152;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i133;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i123;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i134;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i146;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i139;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i124;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i137;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i127;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i110;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i129;
import '../../identity/domain/use_cases/identity/add_identity_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/identity/add_new_identity_use_case.dart'
    as _i159;
import '../../identity/domain/use_cases/identity/backup_identity_use_case.dart'
    as _i151;
import '../../identity/domain/use_cases/identity/create_identity_use_case.dart'
    as _i153;
import '../../identity/domain/use_cases/identity/get_identities_use_case.dart'
    as _i126;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i140;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i163;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i162;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i157;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i160;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/profile/export_profile_use_case.dart'
    as _i122;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i141;
import '../../identity/domain/use_cases/profile/import_profile_use_case.dart'
    as _i116;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i119;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i132;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i112;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i45;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i8;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i84;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i34;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i49;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i54;
import '../../proof/data/data_sources/witness_data_source.dart' as _i66;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i75;
import '../../proof/data/mappers/jwz_mapper.dart' as _i30;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i31;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i35;
import '../../proof/data/mappers/proof_mapper.dart' as _i51;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i114;
import '../../proof/domain/repositories/proof_repository.dart' as _i117;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i120;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i121;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i143;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i125;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i128;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i130;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i131;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i118;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i50;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i46;
import '../../proof/libs/prover/prover.dart' as _i53;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i65;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i67;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i68;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i69;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i70;
import '../credential.dart' as _i154;
import '../iden3comm.dart' as _i156;
import '../identity.dart' as _i164;
import '../mappers/iden3_message_type_mapper.dart' as _i28;
import '../proof.dart' as _i148;
import 'injector.dart' as _i165; // ignore_for_file: unnecessary_lambdas

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
  final sdk = _$Sdk();
  final zipDecoderModule = _$ZipDecoderModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.CircuitTypeMapper>(() => _i7.CircuitTypeMapper());
  gh.factory<_i8.CircuitsDownloadDataSource>(
      () => _i8.CircuitsDownloadDataSource());
  gh.factory<_i9.ClaimInfoMapper>(() => _i9.ClaimInfoMapper());
  gh.factory<_i10.ClaimStateMapper>(() => _i10.ClaimStateMapper());
  gh.factory<_i11.Client>(() => networkModule.client);
  gh.factory<_i12.CreatePathWrapper>(() => _i12.CreatePathWrapper());
  gh.lazySingletonAsync<_i13.Database>(() => databaseModule.database());
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
  gh.factory<_i12.DestinationPathDataSource>(
      () => _i12.DestinationPathDataSource(get<_i12.CreatePathWrapper>()));
  gh.factoryParam<_i14.Encrypter, _i14.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i15.EncryptionDbDataSource>(() => _i15.EncryptionDbDataSource());
  gh.factory<_i16.EncryptionKeyMapper>(() => _i16.EncryptionKeyMapper());
  gh.factory<_i17.EnvMapper>(() => _i17.EnvMapper());
  gh.factory<_i18.FilterMapper>(() => _i18.FilterMapper());
  gh.factory<_i19.FiltersMapper>(
      () => _i19.FiltersMapper(get<_i18.FilterMapper>()));
  gh.factory<_i20.GetFetchRequestsUseCase>(
      () => _i20.GetFetchRequestsUseCase());
  gh.factory<_i21.GetIden3MessageTypeUseCase>(
      () => _i21.GetIden3MessageTypeUseCase());
  gh.factory<_i22.GetIden3MessageUseCase>(() =>
      _i22.GetIden3MessageUseCase(get<_i21.GetIden3MessageTypeUseCase>()));
  gh.factory<_i23.GetProofQueryUseCase>(() => _i23.GetProofQueryUseCase());
  gh.factory<_i24.GetProofRequestsUseCase>(
      () => _i24.GetProofRequestsUseCase(get<_i23.GetProofQueryUseCase>()));
  gh.factory<_i25.HashMapper>(() => _i25.HashMapper());
  gh.factory<_i26.HexMapper>(() => _i26.HexMapper());
  gh.factory<_i27.IdFilterMapper>(() => _i27.IdFilterMapper());
  gh.factory<_i28.Iden3MessageTypeMapper>(() => _i28.Iden3MessageTypeMapper());
  gh.factory<_i29.IdentityDTOMapper>(() => _i29.IdentityDTOMapper());
  gh.factory<_i30.JWZMapper>(() => _i30.JWZMapper());
  gh.factory<_i31.JWZProofMapper>(() => _i31.JWZProofMapper());
  gh.factory<_i32.LibBabyJubJubDataSource>(
      () => _i32.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i33.LocalContractFilesDataSource>(
      () => _i33.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i34.LocalProofFilesDataSource>(
      () => _i34.LocalProofFilesDataSource());
  gh.factory<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i35.NodeAuxMapper>(() => _i35.NodeAuxMapper());
  gh.factory<_i36.NodeTypeDTOMapper>(() => _i36.NodeTypeDTOMapper());
  gh.factory<_i37.NodeTypeEntityMapper>(() => _i37.NodeTypeEntityMapper());
  gh.factory<_i38.NodeTypeMapper>(() => _i38.NodeTypeMapper());
  gh.lazySingletonAsync<_i39.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i40.PackageInfoDataSource>(() async =>
      _i40.PackageInfoDataSource(await get.getAsync<_i39.PackageInfo>()));
  gh.factoryAsync<_i41.PackageInfoRepositoryImpl>(() async =>
      _i41.PackageInfoRepositoryImpl(
          await get.getAsync<_i40.PackageInfoDataSource>()));
  gh.factory<_i42.PolygonIdCore>(() => _i42.PolygonIdCore());
  gh.factory<_i43.PolygonIdCoreCredential>(
      () => _i43.PolygonIdCoreCredential());
  gh.factory<_i44.PolygonIdCoreIden3comm>(() => _i44.PolygonIdCoreIden3comm());
  gh.factory<_i45.PolygonIdCoreIdentity>(() => _i45.PolygonIdCoreIdentity());
  gh.factory<_i46.PolygonIdCoreProof>(() => _i46.PolygonIdCoreProof());
  gh.factory<_i47.PoseidonHashMapper>(
      () => _i47.PoseidonHashMapper(get<_i26.HexMapper>()));
  gh.factory<_i48.PrivateKeyMapper>(() => _i48.PrivateKeyMapper());
  gh.factory<_i49.ProofCircuitDataSource>(() => _i49.ProofCircuitDataSource());
  gh.lazySingleton<_i50.ProofGenerationStepsStreamManager>(
      () => _i50.ProofGenerationStepsStreamManager());
  gh.factory<_i51.ProofMapper>(() => _i51.ProofMapper(
        get<_i25.HashMapper>(),
        get<_i35.NodeAuxMapper>(),
      ));
  gh.factory<_i52.ProofRequestFiltersMapper>(
      () => _i52.ProofRequestFiltersMapper());
  gh.factory<_i53.ProverLib>(() => _i53.ProverLib());
  gh.factory<_i54.ProverLibWrapper>(() => _i54.ProverLibWrapper());
  gh.factory<_i55.QMapper>(() => _i55.QMapper());
  gh.factory<_i56.RemoteClaimDataSource>(
      () => _i56.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i57.RemoteIden3commDataSource>(
      () => _i57.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i58.RemoteIdentityDataSource>(
      () => _i58.RemoteIdentityDataSource());
  gh.factory<_i59.RevocationStatusMapper>(() => _i59.RevocationStatusMapper());
  gh.factory<_i60.RhsNodeTypeMapper>(() => _i60.RhsNodeTypeMapper());
  gh.factoryParam<_i13.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i61.StateIdentifierMapper>(() => _i61.StateIdentifierMapper());
  gh.factory<_i13.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<String>(
    () => sdk.accessMessage,
    instanceName: 'accessMessage',
  );
  gh.factory<_i62.TreeStateMapper>(() => _i62.TreeStateMapper());
  gh.factory<_i63.TreeTypeMapper>(() => _i63.TreeTypeMapper());
  gh.factory<_i64.WalletLibWrapper>(() => _i64.WalletLibWrapper());
  gh.factory<_i65.WitnessAuthV2Lib>(() => _i65.WitnessAuthV2Lib());
  gh.factory<_i66.WitnessIsolatesWrapper>(() => _i66.WitnessIsolatesWrapper());
  gh.factory<_i67.WitnessMTPV2Lib>(() => _i67.WitnessMTPV2Lib());
  gh.factory<_i68.WitnessMTPV2OnchainLib>(() => _i68.WitnessMTPV2OnchainLib());
  gh.factory<_i69.WitnessSigV2Lib>(() => _i69.WitnessSigV2Lib());
  gh.factory<_i70.WitnessSigV2OnchainLib>(() => _i70.WitnessSigV2OnchainLib());
  gh.factory<_i71.ZipDecoder>(
    () => zipDecoderModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i72.AuthProofMapper>(() => _i72.AuthProofMapper(
        get<_i25.HashMapper>(),
        get<_i35.NodeAuxMapper>(),
      ));
  gh.factory<_i73.ClaimMapper>(() => _i73.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i74.ClaimStoreRefWrapper>(() => _i74.ClaimStoreRefWrapper(
      get<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
          instanceName: 'securedStore')));
  gh.factory<_i75.GistProofMapper>(
      () => _i75.GistProofMapper(get<_i51.ProofMapper>()));
  gh.factory<_i76.GistProofMapper>(
      () => _i76.GistProofMapper(get<_i25.HashMapper>()));
  gh.factory<_i77.Iden3commCredentialRepositoryImpl>(
      () => _i77.Iden3commCredentialRepositoryImpl(
            get<_i57.RemoteIden3commDataSource>(),
            get<_i52.ProofRequestFiltersMapper>(),
            get<_i73.ClaimMapper>(),
          ));
  gh.factory<_i78.IdentitySMTStoreRefWrapper>(() =>
      _i78.IdentitySMTStoreRefWrapper(
          get<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i79.IdentityStoreRefWrapper>(() => _i79.IdentityStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i80.KeyValueStoreRefWrapper>(() => _i80.KeyValueStoreRefWrapper(
      get<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i81.LibPolygonIdCoreCredentialDataSource>(() =>
      _i81.LibPolygonIdCoreCredentialDataSource(
          get<_i43.PolygonIdCoreCredential>()));
  gh.factory<_i82.LibPolygonIdCoreIden3commDataSource>(() =>
      _i82.LibPolygonIdCoreIden3commDataSource(
          get<_i44.PolygonIdCoreIden3comm>()));
  gh.factory<_i83.LibPolygonIdCoreIdentityDataSource>(() =>
      _i83.LibPolygonIdCoreIdentityDataSource(
          get<_i45.PolygonIdCoreIdentity>()));
  gh.factory<_i84.LibPolygonIdCoreWrapper>(
      () => _i84.LibPolygonIdCoreWrapper(get<_i46.PolygonIdCoreProof>()));
  gh.factory<_i85.LocalClaimDataSource>(() => _i85.LocalClaimDataSource(
      get<_i81.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i86.NodeMapper>(() => _i86.NodeMapper(
        get<_i38.NodeTypeMapper>(),
        get<_i37.NodeTypeEntityMapper>(),
        get<_i36.NodeTypeDTOMapper>(),
        get<_i25.HashMapper>(),
      ));
  gh.factoryAsync<_i87.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i41.PackageInfoRepositoryImpl>()));
  gh.factory<_i54.ProverLibDataSource>(
      () => _i54.ProverLibDataSource(get<_i54.ProverLibWrapper>()));
  gh.factory<_i88.RhsNodeMapper>(
      () => _i88.RhsNodeMapper(get<_i60.RhsNodeTypeMapper>()));
  gh.factory<_i74.StorageClaimDataSource>(
      () => _i74.StorageClaimDataSource(get<_i74.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i79.StorageIdentityDataSource>(
      () async => _i79.StorageIdentityDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i79.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i80.StorageKeyValueDataSource>(
      () async => _i80.StorageKeyValueDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i80.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i78.StorageSMTDataSource>(
      () => _i78.StorageSMTDataSource(get<_i78.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i64.WalletDataSource>(
      () => _i64.WalletDataSource(get<_i64.WalletLibWrapper>()));
  gh.factory<_i66.WitnessDataSource>(
      () => _i66.WitnessDataSource(get<_i66.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i89.ConfigRepositoryImpl>(
      () async => _i89.ConfigRepositoryImpl(
            await get.getAsync<_i80.StorageKeyValueDataSource>(),
            get<_i17.EnvMapper>(),
          ));
  gh.factory<_i90.CredentialRepositoryImpl>(() => _i90.CredentialRepositoryImpl(
        get<_i56.RemoteClaimDataSource>(),
        get<_i74.StorageClaimDataSource>(),
        get<_i85.LocalClaimDataSource>(),
        get<_i73.ClaimMapper>(),
        get<_i19.FiltersMapper>(),
        get<_i27.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i91.GetPackageNameUseCase>(() async =>
      _i91.GetPackageNameUseCase(
          await get.getAsync<_i87.PackageInfoRepository>()));
  gh.factory<_i92.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i77.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i93.Iden3commRepositoryImpl>(() => _i93.Iden3commRepositoryImpl(
        get<_i57.RemoteIden3commDataSource>(),
        get<_i82.LibPolygonIdCoreIden3commDataSource>(),
        get<_i32.LibBabyJubJubDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i72.AuthProofMapper>(),
        get<_i76.GistProofMapper>(),
        get<_i55.QMapper>(),
      ));
  gh.factory<_i84.LibPolygonIdCoreProofDataSource>(() =>
      _i84.LibPolygonIdCoreProofDataSource(
          get<_i84.LibPolygonIdCoreWrapper>()));
  gh.factory<_i94.SMTDataSource>(() => _i94.SMTDataSource(
        get<_i26.HexMapper>(),
        get<_i32.LibBabyJubJubDataSource>(),
        get<_i78.StorageSMTDataSource>(),
      ));
  gh.factory<_i95.SMTRepositoryImpl>(() => _i95.SMTRepositoryImpl(
        get<_i94.SMTDataSource>(),
        get<_i78.StorageSMTDataSource>(),
        get<_i32.LibBabyJubJubDataSource>(),
        get<_i86.NodeMapper>(),
        get<_i25.HashMapper>(),
        get<_i51.ProofMapper>(),
        get<_i63.TreeTypeMapper>(),
        get<_i62.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i96.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i89.ConfigRepositoryImpl>()));
  gh.factory<_i97.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i90.CredentialRepositoryImpl>()));
  gh.factory<_i98.GetAuthClaimUseCase>(
      () => _i98.GetAuthClaimUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i99.GetClaimsUseCase>(
      () => _i99.GetClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factoryAsync<_i100.GetEnvUseCase>(() async =>
      _i100.GetEnvUseCase(await get.getAsync<_i96.ConfigRepository>()));
  gh.factory<_i101.GetVocabsUseCase>(
      () => _i101.GetVocabsUseCase(get<_i92.Iden3commCredentialRepository>()));
  gh.factory<_i102.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i93.Iden3commRepositoryImpl>()));
  gh.factory<_i103.RemoveAllClaimsUseCase>(
      () => _i103.RemoveAllClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i104.RemoveClaimsUseCase>(
      () => _i104.RemoveClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i105.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i95.SMTRepositoryImpl>()));
  gh.factoryAsync<_i106.SetEnvUseCase>(() async =>
      _i106.SetEnvUseCase(await get.getAsync<_i96.ConfigRepository>()));
  gh.factory<_i107.UpdateClaimUseCase>(
      () => _i107.UpdateClaimUseCase(get<_i97.CredentialRepository>()));
  gh.factoryAsync<_i108.Web3Client>(() async =>
      networkModule.web3Client(await get.getAsync<_i100.GetEnvUseCase>()));
  gh.factory<_i109.GetAuthChallengeUseCase>(
      () => _i109.GetAuthChallengeUseCase(get<_i102.Iden3commRepository>()));
  gh.factory<_i110.GetLatestStateUseCase>(
      () => _i110.GetLatestStateUseCase(get<_i105.SMTRepository>()));
  gh.factoryAsync<_i111.RPCDataSource>(
      () async => _i111.RPCDataSource(await get.getAsync<_i108.Web3Client>()));
  gh.factory<_i112.RemoveIdentityStateUseCase>(
      () => _i112.RemoveIdentityStateUseCase(get<_i105.SMTRepository>()));
  gh.factoryAsync<_i113.IdentityRepositoryImpl>(
      () async => _i113.IdentityRepositoryImpl(
            get<_i64.WalletDataSource>(),
            get<_i58.RemoteIdentityDataSource>(),
            await get.getAsync<_i79.StorageIdentityDataSource>(),
            await get.getAsync<_i111.RPCDataSource>(),
            get<_i33.LocalContractFilesDataSource>(),
            get<_i32.LibBabyJubJubDataSource>(),
            get<_i83.LibPolygonIdCoreIdentityDataSource>(),
            get<_i15.EncryptionDbDataSource>(),
            get<_i12.DestinationPathDataSource>(),
            get<_i26.HexMapper>(),
            get<_i48.PrivateKeyMapper>(),
            get<_i29.IdentityDTOMapper>(),
            get<_i88.RhsNodeMapper>(),
            get<_i61.StateIdentifierMapper>(),
            get<_i86.NodeMapper>(),
            get<_i16.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i114.ProofRepositoryImpl>(
      () async => _i114.ProofRepositoryImpl(
            get<_i66.WitnessDataSource>(),
            get<_i54.ProverLibDataSource>(),
            get<_i84.LibPolygonIdCoreProofDataSource>(),
            get<_i34.LocalProofFilesDataSource>(),
            get<_i49.ProofCircuitDataSource>(),
            get<_i58.RemoteIdentityDataSource>(),
            get<_i33.LocalContractFilesDataSource>(),
            get<_i8.CircuitsDownloadDataSource>(),
            await get.getAsync<_i111.RPCDataSource>(),
            get<_i7.CircuitTypeMapper>(),
            get<_i31.JWZProofMapper>(),
            get<_i73.ClaimMapper>(),
            get<_i59.RevocationStatusMapper>(),
            get<_i30.JWZMapper>(),
            get<_i72.AuthProofMapper>(),
            get<_i75.GistProofMapper>(),
            get<_i76.GistProofMapper>(),
          ));
  gh.factoryAsync<_i115.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i113.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i116.ImportProfileUseCase>(() async =>
      _i116.ImportProfileUseCase(
          await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i117.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i114.ProofRepositoryImpl>()));
  gh.factoryAsync<_i118.ProveUseCase>(() async =>
      _i118.ProveUseCase(await get.getAsync<_i117.ProofRepository>()));
  gh.factoryAsync<_i119.SignMessageUseCase>(() async =>
      _i119.SignMessageUseCase(await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i120.CircuitsFilesExistUseCase>(() async =>
      _i120.CircuitsFilesExistUseCase(
          await get.getAsync<_i117.ProofRepository>()));
  gh.factoryAsync<_i121.DownloadCircuitsUseCase>(
      () async => _i121.DownloadCircuitsUseCase(
            await get.getAsync<_i117.ProofRepository>(),
            await get.getAsync<_i120.CircuitsFilesExistUseCase>(),
          ));
  gh.factoryAsync<_i122.ExportProfileUseCase>(() async =>
      _i122.ExportProfileUseCase(
          await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i123.FetchStateRootsUseCase>(() async =>
      _i123.FetchStateRootsUseCase(
          await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i124.GetDidUseCase>(() async =>
      _i124.GetDidUseCase(await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i125.GetGistProofUseCase>(
      () async => _i125.GetGistProofUseCase(
            await get.getAsync<_i117.ProofRepository>(),
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i100.GetEnvUseCase>(),
            await get.getAsync<_i124.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i126.GetIdentitiesUseCase>(() async =>
      _i126.GetIdentitiesUseCase(
          await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i127.GetIdentityAuthClaimUseCase>(
      () async => _i127.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i98.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i128.GetJWZUseCase>(() async =>
      _i128.GetJWZUseCase(await get.getAsync<_i117.ProofRepository>()));
  gh.factoryAsync<_i129.GetPublicKeysUseCase>(() async =>
      _i129.GetPublicKeysUseCase(
          await get.getAsync<_i115.IdentityRepository>()));
  gh.factoryAsync<_i130.IsProofCircuitSupportedUseCase>(() async =>
      _i130.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i117.ProofRepository>()));
  gh.factoryAsync<_i131.LoadCircuitUseCase>(() async =>
      _i131.LoadCircuitUseCase(await get.getAsync<_i117.ProofRepository>()));
  gh.factoryAsync<_i132.CreateIdentityStateUseCase>(
      () async => _i132.CreateIdentityStateUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i105.SMTRepository>(),
            await get.getAsync<_i127.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i133.FetchIdentityStateUseCase>(
      () async => _i133.FetchIdentityStateUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i100.GetEnvUseCase>(),
            await get.getAsync<_i124.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i134.GenerateNonRevProofUseCase>(
      () async => _i134.GenerateNonRevProofUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i97.CredentialRepository>(),
            await get.getAsync<_i133.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i135.GetClaimRevocationStatusUseCase>(
      () async => _i135.GetClaimRevocationStatusUseCase(
            get<_i97.CredentialRepository>(),
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i134.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i136.GetFiltersUseCase>(() async => _i136.GetFiltersUseCase(
        get<_i92.Iden3commCredentialRepository>(),
        await get.getAsync<_i130.IsProofCircuitSupportedUseCase>(),
        get<_i24.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i137.GetGenesisStateUseCase>(
      () async => _i137.GetGenesisStateUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i105.SMTRepository>(),
            await get.getAsync<_i127.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i138.GetIden3commClaimsUseCase>(
      () async => _i138.GetIden3commClaimsUseCase(
            get<_i92.Iden3commCredentialRepository>(),
            get<_i99.GetClaimsUseCase>(),
            await get.getAsync<_i135.GetClaimRevocationStatusUseCase>(),
            get<_i107.UpdateClaimUseCase>(),
            await get.getAsync<_i130.IsProofCircuitSupportedUseCase>(),
            get<_i24.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i139.GetDidIdentifierUseCase>(
      () async => _i139.GetDidIdentifierUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i137.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i140.GetIdentityUseCase>(
      () async => _i140.GetIdentityUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i124.GetDidUseCase>(),
            await get.getAsync<_i139.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i141.GetProfilesUseCase>(() async =>
      _i141.GetProfilesUseCase(await get.getAsync<_i140.GetIdentityUseCase>()));
  gh.factoryAsync<_i142.CreateProfilesUseCase>(
      () async => _i142.CreateProfilesUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i129.GetPublicKeysUseCase>(),
            await get.getAsync<_i139.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i143.GenerateProofUseCase>(
      () async => _i143.GenerateProofUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i105.SMTRepository>(),
            await get.getAsync<_i117.ProofRepository>(),
            await get.getAsync<_i118.ProveUseCase>(),
            await get.getAsync<_i140.GetIdentityUseCase>(),
            get<_i98.GetAuthClaimUseCase>(),
            await get.getAsync<_i125.GetGistProofUseCase>(),
            await get.getAsync<_i124.GetDidUseCase>(),
            await get.getAsync<_i119.SignMessageUseCase>(),
            get<_i110.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i144.GetAuthInputsUseCase>(
      () async => _i144.GetAuthInputsUseCase(
            await get.getAsync<_i140.GetIdentityUseCase>(),
            get<_i98.GetAuthClaimUseCase>(),
            await get.getAsync<_i119.SignMessageUseCase>(),
            await get.getAsync<_i125.GetGistProofUseCase>(),
            get<_i110.GetLatestStateUseCase>(),
            get<_i102.Iden3commRepository>(),
            await get.getAsync<_i115.IdentityRepository>(),
            get<_i105.SMTRepository>(),
          ));
  gh.factoryAsync<_i145.GetAuthTokenUseCase>(
      () async => _i145.GetAuthTokenUseCase(
            await get.getAsync<_i131.LoadCircuitUseCase>(),
            await get.getAsync<_i128.GetJWZUseCase>(),
            get<_i109.GetAuthChallengeUseCase>(),
            await get.getAsync<_i144.GetAuthInputsUseCase>(),
            await get.getAsync<_i118.ProveUseCase>(),
          ));
  gh.factoryAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i146.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i100.GetEnvUseCase>(),
            await get.getAsync<_i139.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i147.GetIden3commProofsUseCase>(
      () async => _i147.GetIden3commProofsUseCase(
            await get.getAsync<_i117.ProofRepository>(),
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i138.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i143.GenerateProofUseCase>(),
            await get.getAsync<_i130.IsProofCircuitSupportedUseCase>(),
            get<_i24.GetProofRequestsUseCase>(),
            get<_i50.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i148.Proof>(() async => _i148.Proof(
        await get.getAsync<_i143.GenerateProofUseCase>(),
        await get.getAsync<_i121.DownloadCircuitsUseCase>(),
        await get.getAsync<_i120.CircuitsFilesExistUseCase>(),
        get<_i50.ProofGenerationStepsStreamManager>(),
      ));
  gh.factoryAsync<_i149.SaveClaimsUseCase>(() async => _i149.SaveClaimsUseCase(
        get<_i20.GetFetchRequestsUseCase>(),
        await get.getAsync<_i145.GetAuthTokenUseCase>(),
        get<_i97.CredentialRepository>(),
      ));
  gh.factoryAsync<_i150.AuthenticateUseCase>(
      () async => _i150.AuthenticateUseCase(
            get<_i102.Iden3commRepository>(),
            await get.getAsync<_i147.GetIden3commProofsUseCase>(),
            await get.getAsync<_i145.GetAuthTokenUseCase>(),
            await get.getAsync<_i100.GetEnvUseCase>(),
            await get.getAsync<_i91.GetPackageNameUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
            get<_i50.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i151.BackupIdentityUseCase>(
      () async => _i151.BackupIdentityUseCase(
            await get.getAsync<_i140.GetIdentityUseCase>(),
            await get.getAsync<_i122.ExportProfileUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i152.CheckIdentityValidityUseCase>(
      () async => _i152.CheckIdentityValidityUseCase(
            get<String>(instanceName: 'accessMessage'),
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i153.CreateIdentityUseCase>(
      () async => _i153.CreateIdentityUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i129.GetPublicKeysUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i154.Credential>(() async => _i154.Credential(
        await get.getAsync<_i149.SaveClaimsUseCase>(),
        get<_i99.GetClaimsUseCase>(),
        get<_i104.RemoveClaimsUseCase>(),
        get<_i107.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i155.FetchAndSaveClaimsUseCase>(
      () async => _i155.FetchAndSaveClaimsUseCase(
            get<_i92.Iden3commCredentialRepository>(),
            get<_i20.GetFetchRequestsUseCase>(),
            await get.getAsync<_i145.GetAuthTokenUseCase>(),
            await get.getAsync<_i149.SaveClaimsUseCase>(),
            await get.getAsync<_i135.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i156.Iden3comm>(() async => _i156.Iden3comm(
        await get.getAsync<_i155.FetchAndSaveClaimsUseCase>(),
        get<_i22.GetIden3MessageUseCase>(),
        await get.getAsync<_i150.AuthenticateUseCase>(),
        await get.getAsync<_i136.GetFiltersUseCase>(),
        await get.getAsync<_i138.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i147.GetIden3commProofsUseCase>(),
      ));
  gh.factoryAsync<_i157.UpdateIdentityUseCase>(
      () async => _i157.UpdateIdentityUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i153.CreateIdentityUseCase>(),
            await get.getAsync<_i140.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i158.AddIdentityUseCase>(
      () async => _i158.AddIdentityUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i153.CreateIdentityUseCase>(),
            await get.getAsync<_i132.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i159.AddNewIdentityUseCase>(
      () async => _i159.AddNewIdentityUseCase(
            get<String>(instanceName: 'accessMessage'),
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i158.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i160.AddProfileUseCase>(() async => _i160.AddProfileUseCase(
        await get.getAsync<_i140.GetIdentityUseCase>(),
        await get.getAsync<_i124.GetDidUseCase>(),
        await get.getAsync<_i157.UpdateIdentityUseCase>(),
        await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i142.CreateProfilesUseCase>(),
        await get.getAsync<_i132.CreateIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i161.RemoveProfileUseCase>(
      () async => _i161.RemoveProfileUseCase(
            await get.getAsync<_i140.GetIdentityUseCase>(),
            await get.getAsync<_i124.GetDidUseCase>(),
            await get.getAsync<_i157.UpdateIdentityUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
            await get.getAsync<_i142.CreateProfilesUseCase>(),
            get<_i112.RemoveIdentityStateUseCase>(),
            get<_i103.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i162.RestoreIdentityUseCase>(
      () async => _i162.RestoreIdentityUseCase(
            await get.getAsync<_i158.AddIdentityUseCase>(),
            await get.getAsync<_i140.GetIdentityUseCase>(),
            await get.getAsync<_i116.ImportProfileUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i163.RemoveIdentityUseCase>(
      () async => _i163.RemoveIdentityUseCase(
            await get.getAsync<_i115.IdentityRepository>(),
            await get.getAsync<_i141.GetProfilesUseCase>(),
            await get.getAsync<_i161.RemoveProfileUseCase>(),
            get<_i112.RemoveIdentityStateUseCase>(),
            get<_i103.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i146.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i164.Identity>(() async => _i164.Identity(
        await get.getAsync<_i152.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i159.AddNewIdentityUseCase>(),
        await get.getAsync<_i162.RestoreIdentityUseCase>(),
        await get.getAsync<_i151.BackupIdentityUseCase>(),
        await get.getAsync<_i140.GetIdentityUseCase>(),
        await get.getAsync<_i126.GetIdentitiesUseCase>(),
        await get.getAsync<_i163.RemoveIdentityUseCase>(),
        await get.getAsync<_i139.GetDidIdentifierUseCase>(),
        await get.getAsync<_i119.SignMessageUseCase>(),
        await get.getAsync<_i133.FetchIdentityStateUseCase>(),
        await get.getAsync<_i160.AddProfileUseCase>(),
        await get.getAsync<_i141.GetProfilesUseCase>(),
        await get.getAsync<_i161.RemoveProfileUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i165.PlatformModule {}

class _$NetworkModule extends _i165.NetworkModule {}

class _$DatabaseModule extends _i165.DatabaseModule {}

class _$EncryptionModule extends _i165.EncryptionModule {}

class _$Sdk extends _i165.Sdk {}

class _$ZipDecoderModule extends _i165.ZipDecoderModule {}

class _$RepositoriesModule extends _i165.RepositoriesModule {}
