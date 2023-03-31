// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i72;
import 'package:encrypt/encrypt.dart' as _i15;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i40;
import 'package:sembast/sembast.dart' as _i14;
import 'package:web3dart/web3dart.dart' as _i110;

import '../../common/data/data_sources/mappers/env_mapper.dart' as _i18;
import '../../common/data/data_sources/package_info_datasource.dart' as _i41;
import '../../common/data/data_sources/storage_key_value_data_source.dart'
    as _i82;
import '../../common/data/repositories/config_repository_impl.dart' as _i91;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i42;
import '../../common/domain/repositories/config_repository.dart' as _i98;
import '../../common/domain/repositories/package_info_repository.dart' as _i89;
import '../../common/domain/use_cases/get_env_use_case.dart' as _i101;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i93;
import '../../common/domain/use_cases/set_env_use_case.dart' as _i108;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i43;
import '../../credential/data/credential_repository_impl.dart' as _i92;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i83;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i87;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i57;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i75;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i74;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i19;
import '../../credential/data/mappers/filters_mapper.dart' as _i20;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i28;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i60;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i99;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart'
    as _i100;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i138;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i154;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i104;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i105;
import '../../credential/domain/use_cases/save_claims_use_case.dart' as _i107;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i109;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i44;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i84;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i58;
import '../../iden3comm/data/data_sources/storage_connection_data_source.dart'
    as _i76;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i73;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/connection_mapper.dart' as _i12;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i77;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i53;
import '../../iden3comm/data/repositories/iden3comm_credential_repository_impl.dart'
    as _i79;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i95;
import '../../iden3comm/domain/repositories/iden3comm_credential_repository.dart'
    as _i94;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i103;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i162;
import '../../iden3comm/domain/use_cases/connection/get_connections_use_case.dart'
    as _i155;
import '../../iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i153;
import '../../iden3comm/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i111;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i145;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i146;
import '../../iden3comm/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i21;
import '../../iden3comm/domain/use_cases/get_filters_use_case.dart' as _i139;
import '../../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart'
    as _i156;
import '../../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart'
    as _i157;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i23;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i24;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i25;
import '../../iden3comm/domain/use_cases/get_vocabs_use_case.dart' as _i102;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i45;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i13;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i16;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i33;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i85;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i34;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i59;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i113;
import '../../identity/data/data_sources/smt_data_source.dart' as _i96;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i81;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i80;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i65;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i17;
import '../../identity/data/mappers/hash_mapper.dart' as _i26;
import '../../identity/data/mappers/hex_mapper.dart' as _i27;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i30;
import '../../identity/data/mappers/node_mapper.dart' as _i88;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i37;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i38;
import '../../identity/data/mappers/node_type_mapper.dart' as _i39;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i48;
import '../../identity/data/mappers/private_key_mapper.dart' as _i49;
import '../../identity/data/mappers/q_mapper.dart' as _i56;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i90;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i61;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i62;
import '../../identity/data/mappers/tree_state_mapper.dart' as _i63;
import '../../identity/data/mappers/tree_type_mapper.dart' as _i64;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i115;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i97;
import '../../identity/domain/repositories/identity_repository.dart' as _i117;
import '../../identity/domain/repositories/smt_repository.dart' as _i106;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i136;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i125;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i137;
import '../../identity/domain/use_cases/get_current_env_did_identifier_use_case.dart'
    as _i147;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i141;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i126;
import '../../identity/domain/use_cases/get_genesis_state_use_case.dart'
    as _i140;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i129;
import '../../identity/domain/use_cases/get_latest_state_use_case.dart'
    as _i112;
import '../../identity/domain/use_cases/get_public_keys_use_case.dart' as _i132;
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
    as _i128;
import '../../identity/domain/use_cases/identity/get_identity_use_case.dart'
    as _i142;
import '../../identity/domain/use_cases/identity/get_private_key_use_case.dart'
    as _i131;
import '../../identity/domain/use_cases/identity/remove_identity_use_case.dart'
    as _i167;
import '../../identity/domain/use_cases/identity/restore_identity_use_case.dart'
    as _i166;
import '../../identity/domain/use_cases/identity/sign_message_use_case.dart'
    as _i121;
import '../../identity/domain/use_cases/identity/update_identity_use_case.dart'
    as _i158;
import '../../identity/domain/use_cases/profile/add_profile_use_case.dart'
    as _i161;
import '../../identity/domain/use_cases/profile/create_profiles_use_case.dart'
    as _i152;
import '../../identity/domain/use_cases/profile/export_profile_use_case.dart'
    as _i124;
import '../../identity/domain/use_cases/profile/get_profiles_use_case.dart'
    as _i143;
import '../../identity/domain/use_cases/profile/import_profile_use_case.dart'
    as _i118;
import '../../identity/domain/use_cases/profile/remove_profile_use_case.dart'
    as _i165;
import '../../identity/domain/use_cases/smt/create_identity_state_use_case.dart'
    as _i135;
import '../../identity/domain/use_cases/smt/remove_identity_state_use_case.dart'
    as _i114;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i46;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i8;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i86;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i35;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i50;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i55;
import '../../proof/data/data_sources/witness_data_source.dart' as _i67;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i78;
import '../../proof/data/mappers/jwz_mapper.dart' as _i31;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i32;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i36;
import '../../proof/data/mappers/proof_mapper.dart' as _i52;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i116;
import '../../proof/domain/repositories/proof_repository.dart' as _i119;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i122;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i123;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i144;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i127;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i130;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i133;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i134;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i120;
import '../../proof/infrastructure/proof_generation_stream_manager.dart'
    as _i51;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i47;
import '../../proof/libs/prover/prover.dart' as _i54;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i66;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i68;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i69;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i70;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i71;
import '../credential.dart' as _i163;
import '../iden3comm.dart' as _i164;
import '../identity.dart' as _i168;
import '../mappers/iden3_message_type_mapper.dart' as _i29;
import '../proof.dart' as _i148;
import 'injector.dart' as _i169; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i12.ConnectionMapper>(() => _i12.ConnectionMapper());
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
  gh.factoryParam<_i15.Encrypter, _i15.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i16.EncryptionDbDataSource>(() => _i16.EncryptionDbDataSource());
  gh.factory<_i17.EncryptionKeyMapper>(() => _i17.EncryptionKeyMapper());
  gh.factory<_i18.EnvMapper>(() => _i18.EnvMapper());
  gh.factory<_i19.FilterMapper>(() => _i19.FilterMapper());
  gh.factory<_i20.FiltersMapper>(
      () => _i20.FiltersMapper(get<_i19.FilterMapper>()));
  gh.factory<_i21.GetFetchRequestsUseCase>(
      () => _i21.GetFetchRequestsUseCase());
  gh.factory<_i22.GetIden3MessageTypeUseCase>(
      () => _i22.GetIden3MessageTypeUseCase());
  gh.factory<_i23.GetIden3MessageUseCase>(() =>
      _i23.GetIden3MessageUseCase(get<_i22.GetIden3MessageTypeUseCase>()));
  gh.factory<_i24.GetProofQueryUseCase>(() => _i24.GetProofQueryUseCase());
  gh.factory<_i25.GetProofRequestsUseCase>(
      () => _i25.GetProofRequestsUseCase(get<_i24.GetProofQueryUseCase>()));
  gh.factory<_i26.HashMapper>(() => _i26.HashMapper());
  gh.factory<_i27.HexMapper>(() => _i27.HexMapper());
  gh.factory<_i28.IdFilterMapper>(() => _i28.IdFilterMapper());
  gh.factory<_i29.Iden3MessageTypeMapper>(() => _i29.Iden3MessageTypeMapper());
  gh.factory<_i30.IdentityDTOMapper>(() => _i30.IdentityDTOMapper());
  gh.factory<_i31.JWZMapper>(() => _i31.JWZMapper());
  gh.factory<_i32.JWZProofMapper>(() => _i32.JWZProofMapper());
  gh.factory<_i33.LibBabyJubJubDataSource>(
      () => _i33.LibBabyJubJubDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i34.LocalContractFilesDataSource>(
      () => _i34.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i35.LocalProofFilesDataSource>(
      () => _i35.LocalProofFilesDataSource());
  gh.factory<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i36.NodeAuxMapper>(() => _i36.NodeAuxMapper());
  gh.factory<_i37.NodeTypeDTOMapper>(() => _i37.NodeTypeDTOMapper());
  gh.factory<_i38.NodeTypeEntityMapper>(() => _i38.NodeTypeEntityMapper());
  gh.factory<_i39.NodeTypeMapper>(() => _i39.NodeTypeMapper());
  gh.lazySingletonAsync<_i40.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i41.PackageInfoDataSource>(() async =>
      _i41.PackageInfoDataSource(await get.getAsync<_i40.PackageInfo>()));
  gh.factoryAsync<_i42.PackageInfoRepositoryImpl>(() async =>
      _i42.PackageInfoRepositoryImpl(
          await get.getAsync<_i41.PackageInfoDataSource>()));
  gh.factory<_i43.PolygonIdCore>(() => _i43.PolygonIdCore());
  gh.factory<_i44.PolygonIdCoreCredential>(
      () => _i44.PolygonIdCoreCredential());
  gh.factory<_i45.PolygonIdCoreIden3comm>(() => _i45.PolygonIdCoreIden3comm());
  gh.factory<_i46.PolygonIdCoreIdentity>(() => _i46.PolygonIdCoreIdentity());
  gh.factory<_i47.PolygonIdCoreProof>(() => _i47.PolygonIdCoreProof());
  gh.factory<_i48.PoseidonHashMapper>(
      () => _i48.PoseidonHashMapper(get<_i27.HexMapper>()));
  gh.factory<_i49.PrivateKeyMapper>(() => _i49.PrivateKeyMapper());
  gh.factory<_i50.ProofCircuitDataSource>(() => _i50.ProofCircuitDataSource());
  gh.lazySingleton<_i51.ProofGenerationStepsStreamManager>(
      () => _i51.ProofGenerationStepsStreamManager());
  gh.factory<_i52.ProofMapper>(() => _i52.ProofMapper(
        get<_i26.HashMapper>(),
        get<_i36.NodeAuxMapper>(),
      ));
  gh.factory<_i53.ProofRequestFiltersMapper>(
      () => _i53.ProofRequestFiltersMapper());
  gh.factory<_i54.ProverLib>(() => _i54.ProverLib());
  gh.factory<_i55.ProverLibWrapper>(() => _i55.ProverLibWrapper());
  gh.factory<_i56.QMapper>(() => _i56.QMapper());
  gh.factory<_i57.RemoteClaimDataSource>(
      () => _i57.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i58.RemoteIden3commDataSource>(
      () => _i58.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i59.RemoteIdentityDataSource>(
      () => _i59.RemoteIdentityDataSource());
  gh.factory<_i60.RevocationStatusMapper>(() => _i60.RevocationStatusMapper());
  gh.factory<_i61.RhsNodeTypeMapper>(() => _i61.RhsNodeTypeMapper());
  gh.factoryParam<_i14.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i62.StateIdentifierMapper>(() => _i62.StateIdentifierMapper());
  gh.factory<_i14.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i14.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i63.TreeStateMapper>(() => _i63.TreeStateMapper());
  gh.factory<_i64.TreeTypeMapper>(() => _i64.TreeTypeMapper());
  gh.factory<_i65.WalletLibWrapper>(() => _i65.WalletLibWrapper());
  gh.factory<_i66.WitnessAuthV2Lib>(() => _i66.WitnessAuthV2Lib());
  gh.factory<_i67.WitnessIsolatesWrapper>(() => _i67.WitnessIsolatesWrapper());
  gh.factory<_i68.WitnessMTPV2Lib>(() => _i68.WitnessMTPV2Lib());
  gh.factory<_i69.WitnessMTPV2OnchainLib>(() => _i69.WitnessMTPV2OnchainLib());
  gh.factory<_i70.WitnessSigV2Lib>(() => _i70.WitnessSigV2Lib());
  gh.factory<_i71.WitnessSigV2OnchainLib>(() => _i71.WitnessSigV2OnchainLib());
  gh.factory<_i72.ZipDecoder>(
    () => zipDecoderModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i73.AuthProofMapper>(() => _i73.AuthProofMapper(
        get<_i26.HashMapper>(),
        get<_i36.NodeAuxMapper>(),
      ));
  gh.factory<_i74.ClaimMapper>(() => _i74.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i75.ClaimStoreRefWrapper>(() => _i75.ClaimStoreRefWrapper(
      get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
          instanceName: 'securedStore')));
  gh.factory<_i76.ConnectionStoreRefWrapper>(() =>
      _i76.ConnectionStoreRefWrapper(
          get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i77.GistProofMapper>(
      () => _i77.GistProofMapper(get<_i26.HashMapper>()));
  gh.factory<_i78.GistProofMapper>(
      () => _i78.GistProofMapper(get<_i52.ProofMapper>()));
  gh.factory<_i79.Iden3commCredentialRepositoryImpl>(
      () => _i79.Iden3commCredentialRepositoryImpl(
            get<_i58.RemoteIden3commDataSource>(),
            get<_i53.ProofRequestFiltersMapper>(),
            get<_i74.ClaimMapper>(),
          ));
  gh.factory<_i80.IdentitySMTStoreRefWrapper>(() =>
      _i80.IdentitySMTStoreRefWrapper(
          get<Map<String, _i14.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i81.IdentityStoreRefWrapper>(() => _i81.IdentityStoreRefWrapper(
      get<_i14.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i82.KeyValueStoreRefWrapper>(() => _i82.KeyValueStoreRefWrapper(
      get<_i14.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i83.LibPolygonIdCoreCredentialDataSource>(() =>
      _i83.LibPolygonIdCoreCredentialDataSource(
          get<_i44.PolygonIdCoreCredential>()));
  gh.factory<_i84.LibPolygonIdCoreIden3commDataSource>(() =>
      _i84.LibPolygonIdCoreIden3commDataSource(
          get<_i45.PolygonIdCoreIden3comm>()));
  gh.factory<_i85.LibPolygonIdCoreIdentityDataSource>(() =>
      _i85.LibPolygonIdCoreIdentityDataSource(
          get<_i46.PolygonIdCoreIdentity>()));
  gh.factory<_i86.LibPolygonIdCoreWrapper>(
      () => _i86.LibPolygonIdCoreWrapper(get<_i47.PolygonIdCoreProof>()));
  gh.factory<_i87.LocalClaimDataSource>(() => _i87.LocalClaimDataSource(
      get<_i83.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i88.NodeMapper>(() => _i88.NodeMapper(
        get<_i39.NodeTypeMapper>(),
        get<_i38.NodeTypeEntityMapper>(),
        get<_i37.NodeTypeDTOMapper>(),
        get<_i26.HashMapper>(),
      ));
  gh.factoryAsync<_i89.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i42.PackageInfoRepositoryImpl>()));
  gh.factory<_i55.ProverLibDataSource>(
      () => _i55.ProverLibDataSource(get<_i55.ProverLibWrapper>()));
  gh.factory<_i90.RhsNodeMapper>(
      () => _i90.RhsNodeMapper(get<_i61.RhsNodeTypeMapper>()));
  gh.factory<_i75.StorageClaimDataSource>(
      () => _i75.StorageClaimDataSource(get<_i75.ClaimStoreRefWrapper>()));
  gh.factory<_i76.StorageConnectionDataSource>(() =>
      _i76.StorageConnectionDataSource(get<_i76.ConnectionStoreRefWrapper>()));
  gh.factoryAsync<_i81.StorageIdentityDataSource>(
      () async => _i81.StorageIdentityDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i81.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i82.StorageKeyValueDataSource>(
      () async => _i82.StorageKeyValueDataSource(
            await get.getAsync<_i14.Database>(),
            get<_i82.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i80.StorageSMTDataSource>(
      () => _i80.StorageSMTDataSource(get<_i80.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i65.WalletDataSource>(
      () => _i65.WalletDataSource(get<_i65.WalletLibWrapper>()));
  gh.factory<_i67.WitnessDataSource>(
      () => _i67.WitnessDataSource(get<_i67.WitnessIsolatesWrapper>()));
  gh.factoryAsync<_i91.ConfigRepositoryImpl>(
      () async => _i91.ConfigRepositoryImpl(
            await get.getAsync<_i82.StorageKeyValueDataSource>(),
            get<_i18.EnvMapper>(),
          ));
  gh.factory<_i92.CredentialRepositoryImpl>(() => _i92.CredentialRepositoryImpl(
        get<_i57.RemoteClaimDataSource>(),
        get<_i75.StorageClaimDataSource>(),
        get<_i87.LocalClaimDataSource>(),
        get<_i74.ClaimMapper>(),
        get<_i20.FiltersMapper>(),
        get<_i28.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i93.GetPackageNameUseCase>(() async =>
      _i93.GetPackageNameUseCase(
          await get.getAsync<_i89.PackageInfoRepository>()));
  gh.factory<_i94.Iden3commCredentialRepository>(() =>
      repositoriesModule.iden3commCredentialRepository(
          get<_i79.Iden3commCredentialRepositoryImpl>()));
  gh.factory<_i95.Iden3commRepositoryImpl>(() => _i95.Iden3commRepositoryImpl(
        get<_i58.RemoteIden3commDataSource>(),
        get<_i84.LibPolygonIdCoreIden3commDataSource>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i76.StorageConnectionDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i73.AuthProofMapper>(),
        get<_i77.GistProofMapper>(),
        get<_i56.QMapper>(),
        get<_i12.ConnectionMapper>(),
      ));
  gh.factory<_i86.LibPolygonIdCoreProofDataSource>(() =>
      _i86.LibPolygonIdCoreProofDataSource(
          get<_i86.LibPolygonIdCoreWrapper>()));
  gh.factory<_i96.SMTDataSource>(() => _i96.SMTDataSource(
        get<_i27.HexMapper>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i80.StorageSMTDataSource>(),
      ));
  gh.factory<_i97.SMTRepositoryImpl>(() => _i97.SMTRepositoryImpl(
        get<_i96.SMTDataSource>(),
        get<_i80.StorageSMTDataSource>(),
        get<_i33.LibBabyJubJubDataSource>(),
        get<_i88.NodeMapper>(),
        get<_i26.HashMapper>(),
        get<_i52.ProofMapper>(),
        get<_i64.TreeTypeMapper>(),
        get<_i63.TreeStateMapper>(),
      ));
  gh.factoryAsync<_i98.ConfigRepository>(() async => repositoriesModule
      .configRepository(await get.getAsync<_i91.ConfigRepositoryImpl>()));
  gh.factory<_i99.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i92.CredentialRepositoryImpl>()));
  gh.factory<_i100.GetAuthClaimUseCase>(
      () => _i100.GetAuthClaimUseCase(get<_i99.CredentialRepository>()));
  gh.factoryAsync<_i101.GetEnvUseCase>(() async =>
      _i101.GetEnvUseCase(await get.getAsync<_i98.ConfigRepository>()));
  gh.factory<_i102.GetVocabsUseCase>(
      () => _i102.GetVocabsUseCase(get<_i94.Iden3commCredentialRepository>()));
  gh.factory<_i103.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i95.Iden3commRepositoryImpl>()));
  gh.factory<_i104.RemoveAllClaimsUseCase>(
      () => _i104.RemoveAllClaimsUseCase(get<_i99.CredentialRepository>()));
  gh.factory<_i105.RemoveClaimsUseCase>(
      () => _i105.RemoveClaimsUseCase(get<_i99.CredentialRepository>()));
  gh.factory<_i106.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i97.SMTRepositoryImpl>()));
  gh.factory<_i107.SaveClaimsUseCase>(
      () => _i107.SaveClaimsUseCase(get<_i99.CredentialRepository>()));
  gh.factoryAsync<_i108.SetEnvUseCase>(() async =>
      _i108.SetEnvUseCase(await get.getAsync<_i98.ConfigRepository>()));
  gh.factory<_i109.UpdateClaimUseCase>(
      () => _i109.UpdateClaimUseCase(get<_i99.CredentialRepository>()));
  gh.factoryAsync<_i110.Web3Client>(() async =>
      networkModule.web3Client(await get.getAsync<_i101.GetEnvUseCase>()));
  gh.factory<_i111.GetAuthChallengeUseCase>(
      () => _i111.GetAuthChallengeUseCase(get<_i103.Iden3commRepository>()));
  gh.factory<_i112.GetLatestStateUseCase>(
      () => _i112.GetLatestStateUseCase(get<_i106.SMTRepository>()));
  gh.factoryAsync<_i113.RPCDataSource>(
      () async => _i113.RPCDataSource(await get.getAsync<_i110.Web3Client>()));
  gh.factory<_i114.RemoveIdentityStateUseCase>(
      () => _i114.RemoveIdentityStateUseCase(get<_i106.SMTRepository>()));
  gh.factoryAsync<_i115.IdentityRepositoryImpl>(
      () async => _i115.IdentityRepositoryImpl(
            get<_i65.WalletDataSource>(),
            get<_i59.RemoteIdentityDataSource>(),
            await get.getAsync<_i81.StorageIdentityDataSource>(),
            await get.getAsync<_i113.RPCDataSource>(),
            get<_i34.LocalContractFilesDataSource>(),
            get<_i33.LibBabyJubJubDataSource>(),
            get<_i85.LibPolygonIdCoreIdentityDataSource>(),
            get<_i16.EncryptionDbDataSource>(),
            get<_i13.DestinationPathDataSource>(),
            get<_i27.HexMapper>(),
            get<_i49.PrivateKeyMapper>(),
            get<_i30.IdentityDTOMapper>(),
            get<_i90.RhsNodeMapper>(),
            get<_i62.StateIdentifierMapper>(),
            get<_i88.NodeMapper>(),
            get<_i17.EncryptionKeyMapper>(),
          ));
  gh.factoryAsync<_i116.ProofRepositoryImpl>(
      () async => _i116.ProofRepositoryImpl(
            get<_i67.WitnessDataSource>(),
            get<_i55.ProverLibDataSource>(),
            get<_i86.LibPolygonIdCoreProofDataSource>(),
            get<_i35.LocalProofFilesDataSource>(),
            get<_i50.ProofCircuitDataSource>(),
            get<_i59.RemoteIdentityDataSource>(),
            get<_i34.LocalContractFilesDataSource>(),
            get<_i8.CircuitsDownloadDataSource>(),
            await get.getAsync<_i113.RPCDataSource>(),
            get<_i7.CircuitTypeMapper>(),
            get<_i32.JWZProofMapper>(),
            get<_i74.ClaimMapper>(),
            get<_i60.RevocationStatusMapper>(),
            get<_i31.JWZMapper>(),
            get<_i73.AuthProofMapper>(),
            get<_i78.GistProofMapper>(),
            get<_i77.GistProofMapper>(),
          ));
  gh.factoryAsync<_i117.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i115.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i118.ImportProfileUseCase>(() async =>
      _i118.ImportProfileUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i119.ProofRepository>(() async => repositoriesModule
      .proofRepository(await get.getAsync<_i116.ProofRepositoryImpl>()));
  gh.factoryAsync<_i120.ProveUseCase>(() async =>
      _i120.ProveUseCase(await get.getAsync<_i119.ProofRepository>()));
  gh.factoryAsync<_i121.SignMessageUseCase>(() async =>
      _i121.SignMessageUseCase(await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i122.CircuitsFilesExistUseCase>(() async =>
      _i122.CircuitsFilesExistUseCase(
          await get.getAsync<_i119.ProofRepository>()));
  gh.factoryAsync<_i123.DownloadCircuitsUseCase>(
      () async => _i123.DownloadCircuitsUseCase(
            await get.getAsync<_i119.ProofRepository>(),
            await get.getAsync<_i122.CircuitsFilesExistUseCase>(),
          ));
  gh.factoryAsync<_i124.ExportProfileUseCase>(() async =>
      _i124.ExportProfileUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i125.FetchStateRootsUseCase>(() async =>
      _i125.FetchStateRootsUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i126.GetDidUseCase>(() async =>
      _i126.GetDidUseCase(await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i127.GetGistProofUseCase>(
      () async => _i127.GetGistProofUseCase(
            await get.getAsync<_i119.ProofRepository>(),
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i101.GetEnvUseCase>(),
            await get.getAsync<_i126.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i128.GetIdentitiesUseCase>(() async =>
      _i128.GetIdentitiesUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i129.GetIdentityAuthClaimUseCase>(
      () async => _i129.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i100.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i130.GetJWZUseCase>(() async =>
      _i130.GetJWZUseCase(await get.getAsync<_i119.ProofRepository>()));
  gh.factoryAsync<_i131.GetPrivateKeyUseCase>(() async =>
      _i131.GetPrivateKeyUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i132.GetPublicKeysUseCase>(() async =>
      _i132.GetPublicKeysUseCase(
          await get.getAsync<_i117.IdentityRepository>()));
  gh.factoryAsync<_i133.IsProofCircuitSupportedUseCase>(() async =>
      _i133.IsProofCircuitSupportedUseCase(
          await get.getAsync<_i119.ProofRepository>()));
  gh.factoryAsync<_i134.LoadCircuitUseCase>(() async =>
      _i134.LoadCircuitUseCase(await get.getAsync<_i119.ProofRepository>()));
  gh.factoryAsync<_i135.CreateIdentityStateUseCase>(
      () async => _i135.CreateIdentityStateUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i106.SMTRepository>(),
            await get.getAsync<_i129.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i136.FetchIdentityStateUseCase>(
      () async => _i136.FetchIdentityStateUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i101.GetEnvUseCase>(),
            await get.getAsync<_i126.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i137.GenerateNonRevProofUseCase>(
      () async => _i137.GenerateNonRevProofUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i99.CredentialRepository>(),
            await get.getAsync<_i136.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i138.GetClaimRevocationStatusUseCase>(
      () async => _i138.GetClaimRevocationStatusUseCase(
            get<_i99.CredentialRepository>(),
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i137.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i139.GetFiltersUseCase>(() async => _i139.GetFiltersUseCase(
        get<_i94.Iden3commCredentialRepository>(),
        await get.getAsync<_i133.IsProofCircuitSupportedUseCase>(),
        get<_i25.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i140.GetGenesisStateUseCase>(
      () async => _i140.GetGenesisStateUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i106.SMTRepository>(),
            await get.getAsync<_i129.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i141.GetDidIdentifierUseCase>(
      () async => _i141.GetDidIdentifierUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i140.GetGenesisStateUseCase>(),
          ));
  gh.factoryAsync<_i142.GetIdentityUseCase>(
      () async => _i142.GetIdentityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i126.GetDidUseCase>(),
            await get.getAsync<_i141.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i143.GetProfilesUseCase>(() async =>
      _i143.GetProfilesUseCase(await get.getAsync<_i142.GetIdentityUseCase>()));
  gh.factoryAsync<_i144.GenerateProofUseCase>(
      () async => _i144.GenerateProofUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i106.SMTRepository>(),
            await get.getAsync<_i119.ProofRepository>(),
            await get.getAsync<_i120.ProveUseCase>(),
            await get.getAsync<_i142.GetIdentityUseCase>(),
            get<_i100.GetAuthClaimUseCase>(),
            await get.getAsync<_i127.GetGistProofUseCase>(),
            await get.getAsync<_i126.GetDidUseCase>(),
            await get.getAsync<_i121.SignMessageUseCase>(),
            get<_i112.GetLatestStateUseCase>(),
          ));
  gh.factoryAsync<_i145.GetAuthInputsUseCase>(
      () async => _i145.GetAuthInputsUseCase(
            await get.getAsync<_i142.GetIdentityUseCase>(),
            get<_i100.GetAuthClaimUseCase>(),
            await get.getAsync<_i121.SignMessageUseCase>(),
            await get.getAsync<_i127.GetGistProofUseCase>(),
            get<_i112.GetLatestStateUseCase>(),
            get<_i103.Iden3commRepository>(),
            await get.getAsync<_i117.IdentityRepository>(),
            get<_i106.SMTRepository>(),
          ));
  gh.factoryAsync<_i146.GetAuthTokenUseCase>(
      () async => _i146.GetAuthTokenUseCase(
            await get.getAsync<_i134.LoadCircuitUseCase>(),
            await get.getAsync<_i130.GetJWZUseCase>(),
            get<_i111.GetAuthChallengeUseCase>(),
            await get.getAsync<_i145.GetAuthInputsUseCase>(),
            await get.getAsync<_i120.ProveUseCase>(),
          ));
  gh.factoryAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(
      () async => _i147.GetCurrentEnvDidIdentifierUseCase(
            await get.getAsync<_i101.GetEnvUseCase>(),
            await get.getAsync<_i141.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i148.Proof>(() async => _i148.Proof(
        await get.getAsync<_i144.GenerateProofUseCase>(),
        await get.getAsync<_i123.DownloadCircuitsUseCase>(),
        await get.getAsync<_i122.CircuitsFilesExistUseCase>(),
        get<_i51.ProofGenerationStepsStreamManager>(),
      ));
  gh.factoryAsync<_i149.BackupIdentityUseCase>(
      () async => _i149.BackupIdentityUseCase(
            await get.getAsync<_i142.GetIdentityUseCase>(),
            await get.getAsync<_i124.ExportProfileUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i150.CheckIdentityValidityUseCase>(
      () async => _i150.CheckIdentityValidityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i151.CreateIdentityUseCase>(
      () async => _i151.CreateIdentityUseCase(
            await get.getAsync<_i132.GetPublicKeysUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i152.CreateProfilesUseCase>(
      () async => _i152.CreateProfilesUseCase(
            await get.getAsync<_i132.GetPublicKeysUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i153.FetchAndSaveClaimsUseCase>(
      () async => _i153.FetchAndSaveClaimsUseCase(
            get<_i94.Iden3commCredentialRepository>(),
            get<_i21.GetFetchRequestsUseCase>(),
            await get.getAsync<_i146.GetAuthTokenUseCase>(),
            get<_i107.SaveClaimsUseCase>(),
            await get.getAsync<_i138.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i154.GetClaimsUseCase>(() async => _i154.GetClaimsUseCase(
        get<_i99.CredentialRepository>(),
        await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i142.GetIdentityUseCase>(),
      ));
  gh.factoryAsync<_i155.GetConnectionsUseCase>(
      () async => _i155.GetConnectionsUseCase(
            get<_i103.Iden3commRepository>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
            await get.getAsync<_i142.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i156.GetIden3commClaimsUseCase>(
      () async => _i156.GetIden3commClaimsUseCase(
            get<_i94.Iden3commCredentialRepository>(),
            await get.getAsync<_i154.GetClaimsUseCase>(),
            await get.getAsync<_i138.GetClaimRevocationStatusUseCase>(),
            get<_i109.UpdateClaimUseCase>(),
            await get.getAsync<_i133.IsProofCircuitSupportedUseCase>(),
            get<_i25.GetProofRequestsUseCase>(),
          ));
  gh.factoryAsync<_i157.GetIden3commProofsUseCase>(
      () async => _i157.GetIden3commProofsUseCase(
            await get.getAsync<_i119.ProofRepository>(),
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i156.GetIden3commClaimsUseCase>(),
            await get.getAsync<_i144.GenerateProofUseCase>(),
            await get.getAsync<_i133.IsProofCircuitSupportedUseCase>(),
            get<_i25.GetProofRequestsUseCase>(),
            get<_i51.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i158.UpdateIdentityUseCase>(
      () async => _i158.UpdateIdentityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i151.CreateIdentityUseCase>(),
            await get.getAsync<_i142.GetIdentityUseCase>(),
          ));
  gh.factoryAsync<_i159.AddIdentityUseCase>(
      () async => _i159.AddIdentityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i151.CreateIdentityUseCase>(),
            await get.getAsync<_i135.CreateIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i160.AddNewIdentityUseCase>(
      () async => _i160.AddNewIdentityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i159.AddIdentityUseCase>(),
          ));
  gh.factoryAsync<_i161.AddProfileUseCase>(() async => _i161.AddProfileUseCase(
        await get.getAsync<_i142.GetIdentityUseCase>(),
        await get.getAsync<_i158.UpdateIdentityUseCase>(),
        await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
        await get.getAsync<_i152.CreateProfilesUseCase>(),
        await get.getAsync<_i135.CreateIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i162.AuthenticateUseCase>(
      () async => _i162.AuthenticateUseCase(
            get<_i103.Iden3commRepository>(),
            await get.getAsync<_i157.GetIden3commProofsUseCase>(),
            await get.getAsync<_i146.GetAuthTokenUseCase>(),
            await get.getAsync<_i101.GetEnvUseCase>(),
            await get.getAsync<_i93.GetPackageNameUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
            get<_i51.ProofGenerationStepsStreamManager>(),
          ));
  gh.factoryAsync<_i163.Credential>(() async => _i163.Credential(
        get<_i107.SaveClaimsUseCase>(),
        await get.getAsync<_i154.GetClaimsUseCase>(),
        get<_i105.RemoveClaimsUseCase>(),
        get<_i109.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i164.Iden3comm>(() async => _i164.Iden3comm(
        await get.getAsync<_i153.FetchAndSaveClaimsUseCase>(),
        get<_i23.GetIden3MessageUseCase>(),
        await get.getAsync<_i162.AuthenticateUseCase>(),
        await get.getAsync<_i139.GetFiltersUseCase>(),
        await get.getAsync<_i156.GetIden3commClaimsUseCase>(),
        await get.getAsync<_i157.GetIden3commProofsUseCase>(),
        await get.getAsync<_i155.GetConnectionsUseCase>(),
      ));
  gh.factoryAsync<_i165.RemoveProfileUseCase>(
      () async => _i165.RemoveProfileUseCase(
            await get.getAsync<_i142.GetIdentityUseCase>(),
            await get.getAsync<_i158.UpdateIdentityUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
            await get.getAsync<_i152.CreateProfilesUseCase>(),
            get<_i114.RemoveIdentityStateUseCase>(),
            get<_i104.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i166.RestoreIdentityUseCase>(
      () async => _i166.RestoreIdentityUseCase(
            await get.getAsync<_i159.AddIdentityUseCase>(),
            await get.getAsync<_i142.GetIdentityUseCase>(),
            await get.getAsync<_i118.ImportProfileUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i167.RemoveIdentityUseCase>(
      () async => _i167.RemoveIdentityUseCase(
            await get.getAsync<_i117.IdentityRepository>(),
            await get.getAsync<_i143.GetProfilesUseCase>(),
            await get.getAsync<_i165.RemoveProfileUseCase>(),
            get<_i114.RemoveIdentityStateUseCase>(),
            get<_i104.RemoveAllClaimsUseCase>(),
            await get.getAsync<_i147.GetCurrentEnvDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i168.Identity>(() async => _i168.Identity(
        await get.getAsync<_i150.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i131.GetPrivateKeyUseCase>(),
        await get.getAsync<_i160.AddNewIdentityUseCase>(),
        await get.getAsync<_i166.RestoreIdentityUseCase>(),
        await get.getAsync<_i149.BackupIdentityUseCase>(),
        await get.getAsync<_i142.GetIdentityUseCase>(),
        await get.getAsync<_i128.GetIdentitiesUseCase>(),
        await get.getAsync<_i167.RemoveIdentityUseCase>(),
        await get.getAsync<_i141.GetDidIdentifierUseCase>(),
        await get.getAsync<_i121.SignMessageUseCase>(),
        await get.getAsync<_i136.FetchIdentityStateUseCase>(),
        await get.getAsync<_i161.AddProfileUseCase>(),
        await get.getAsync<_i143.GetProfilesUseCase>(),
        await get.getAsync<_i165.RemoveProfileUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i169.PlatformModule {}

class _$NetworkModule extends _i169.NetworkModule {}

class _$DatabaseModule extends _i169.DatabaseModule {}

class _$EncryptionModule extends _i169.EncryptionModule {}

class _$ZipDecoderModule extends _i169.ZipDecoderModule {}

class _$RepositoriesModule extends _i169.RepositoriesModule {}
