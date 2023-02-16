// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:archive/archive.dart' as _i70;
import 'package:encrypt/encrypt.dart' as _i15;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i39;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i63;

import '../../common/data/data_sources/env_datasource.dart' as _i74;
import '../../common/data/data_sources/package_info_datasource.dart' as _i40;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i89;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i41;
import '../../common/domain/repositories/config_repository.dart' as _i96;
import '../../common/domain/repositories/package_info_repository.dart' as _i86;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i100;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i91;
import '../../common/libs/polygonidcore/pidcore_base.dart' as _i42;
import '../../credential/data/credential_repository_impl.dart' as _i90;
import '../../credential/data/data_sources/lib_pidcore_credential_data_source.dart'
    as _i80;
import '../../credential/data/data_sources/local_claim_data_source.dart'
    as _i84;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i55;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i73;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i72;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i18;
import '../../credential/data/mappers/filters_mapper.dart' as _i19;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i27;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i58;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i97;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i142;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i98;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i128;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i99;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i20;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i101;
import '../../credential/domain/use_cases/remove_all_claims_use_case.dart'
    as _i106;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i107;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i109;
import '../../credential/libs/polygonidcore/pidcore_credential.dart' as _i43;
import '../../env/sdk_env.dart' as _i60;
import '../../iden3comm/data/data_sources/lib_pidcore_iden3comm_data_source.dart'
    as _i81;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i56;
import '../../iden3comm/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/auth_proof_mapper.dart' as _i71;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/gist_proof_mapper.dart' as _i76;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i51;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i92;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i102;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i141;
import '../../iden3comm/domain/use_cases/get_auth_inputs_use_case.dart'
    as _i136;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i137;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i21;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i23;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i138;
import '../../iden3comm/libs/polygonidcore/pidcore_iden3comm.dart' as _i44;
import '../../identity/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import '../../identity/data/data_sources/encryption_db_data_source.dart'
    as _i16;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i32;
import '../../identity/data/data_sources/lib_pidcore_identity_data_source.dart'
    as _i82;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i33;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i57;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i87;
import '../../identity/data/data_sources/smt_data_source.dart' as _i94;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i78;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i79;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i77;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i62;
import '../../identity/data/mappers/did_mapper.dart' as _i14;
import '../../identity/data/mappers/encryption_key_mapper.dart' as _i17;
import '../../identity/data/mappers/hash_mapper.dart' as _i25;
import '../../identity/data/mappers/hex_mapper.dart' as _i26;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i29;
import '../../identity/data/mappers/node_mapper.dart' as _i85;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i36;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i37;
import '../../identity/data/mappers/node_type_mapper.dart' as _i38;
import '../../identity/data/mappers/poseidon_hash_mapper.dart' as _i47;
import '../../identity/data/mappers/private_key_mapper.dart' as _i48;
import '../../identity/data/mappers/q_mapper.dart' as _i54;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i88;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i59;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i61;
import '../../identity/data/repositories/identity_repository_impl.dart'
    as _i103;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i95;
import '../../identity/domain/repositories/identity_repository.dart' as _i113;
import '../../identity/domain/repositories/smt_repository.dart' as _i108;
import '../../identity/domain/use_cases/backup_identity_use_case.dart' as _i131;
import '../../identity/domain/use_cases/check_identity_validity_use_case.dart'
    as _i132;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i133;
import '../../identity/domain/use_cases/create_new_identity_use_case.dart'
    as _i134;
import '../../identity/domain/use_cases/export_identity_use_case.dart' as _i119;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i126;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i120;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i127;
import '../../identity/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i121;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i129;
import '../../identity/domain/use_cases/get_did_use_case.dart' as _i122;
import '../../identity/domain/use_cases/get_identities_use_case.dart' as _i124;
import '../../identity/domain/use_cases/get_identity_auth_claim_use_case.dart'
    as _i125;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i130;
import '../../identity/domain/use_cases/import_identity_use_case.dart' as _i114;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i117;
import '../../identity/domain/use_cases/restore_identity_use_case.dart'
    as _i140;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i118;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/polygonidcore/pidcore_identity.dart' as _i45;
import '../../proof/data/data_sources/circuits_download_data_source.dart'
    as _i8;
import '../../proof/data/data_sources/lib_pidcore_proof_data_source.dart'
    as _i83;
import '../../proof/data/data_sources/local_proof_files_data_source.dart'
    as _i34;
import '../../proof/data/data_sources/proof_circuit_data_source.dart' as _i49;
import '../../proof/data/data_sources/prover_lib_data_source.dart' as _i53;
import '../../proof/data/data_sources/witness_data_source.dart' as _i65;
import '../../proof/data/mappers/circuit_type_mapper.dart' as _i7;
import '../../proof/data/mappers/gist_proof_mapper.dart' as _i75;
import '../../proof/data/mappers/jwz_mapper.dart' as _i30;
import '../../proof/data/mappers/jwz_proof_mapper.dart' as _i31;
import '../../proof/data/mappers/node_aux_mapper.dart' as _i35;
import '../../proof/data/mappers/proof_mapper.dart' as _i50;
import '../../proof/data/repositories/proof_repository_impl.dart' as _i93;
import '../../proof/domain/repositories/proof_repository.dart' as _i104;
import '../../proof/domain/use_cases/circuits_files_exist_use_case.dart'
    as _i110;
import '../../proof/domain/use_cases/download_circuits_use_case.dart' as _i111;
import '../../proof/domain/use_cases/generate_proof_use_case.dart' as _i135;
import '../../proof/domain/use_cases/get_gist_proof_use_case.dart' as _i123;
import '../../proof/domain/use_cases/get_jwz_use_case.dart' as _i112;
import '../../proof/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i115;
import '../../proof/domain/use_cases/load_circuit_use_case.dart' as _i116;
import '../../proof/domain/use_cases/prove_use_case.dart' as _i105;
import '../../proof/libs/polygonidcore/pidcore_proof.dart' as _i46;
import '../../proof/libs/prover/prover.dart' as _i52;
import '../../proof/libs/witnesscalc/auth_v2/witness_auth.dart' as _i64;
import '../../proof/libs/witnesscalc/mtp_v2/witness_mtp.dart' as _i66;
import '../../proof/libs/witnesscalc/mtp_v2_onchain/witness_mtp_onchain.dart'
    as _i67;
import '../../proof/libs/witnesscalc/sig_v2/witness_sig.dart' as _i68;
import '../../proof/libs/witnesscalc/sig_v2_onchain/witness_sig_onchain.dart'
    as _i69;
import '../credential.dart' as _i145;
import '../iden3comm.dart' as _i143;
import '../identity.dart' as _i144;
import '../mappers/iden3_message_type_mapper.dart' as _i28;
import '../proof.dart' as _i139;
import 'injector.dart' as _i146; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i14.DidMapper>(() => _i14.DidMapper());
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
  gh.factory<_i50.ProofMapper>(() => _i50.ProofMapper(
        get<_i25.HashMapper>(),
        get<_i35.NodeAuxMapper>(),
      ));
  gh.factory<_i51.ProofRequestFiltersMapper>(
      () => _i51.ProofRequestFiltersMapper());
  gh.factory<_i52.ProverLib>(() => _i52.ProverLib());
  gh.factory<_i53.ProverLibWrapper>(() => _i53.ProverLibWrapper());
  gh.factory<_i54.QMapper>(() => _i54.QMapper());
  gh.factory<_i55.RemoteClaimDataSource>(
      () => _i55.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i56.RemoteIden3commDataSource>(
      () => _i56.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i57.RemoteIdentityDataSource>(
      () => _i57.RemoteIdentityDataSource());
  gh.factory<_i58.RevocationStatusMapper>(() => _i58.RevocationStatusMapper());
  gh.factory<_i59.RhsNodeTypeMapper>(() => _i59.RhsNodeTypeMapper());
  gh.lazySingleton<_i60.SdkEnv>(() => sdk.sdkEnv);
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
  gh.factory<_i62.WalletLibWrapper>(() => _i62.WalletLibWrapper());
  gh.factory<_i63.Web3Client>(
      () => networkModule.web3Client(get<_i60.SdkEnv>()));
  gh.factory<_i64.WitnessAuthV2Lib>(() => _i64.WitnessAuthV2Lib());
  gh.factory<_i65.WitnessIsolatesWrapper>(() => _i65.WitnessIsolatesWrapper());
  gh.factory<_i66.WitnessMTPV2Lib>(() => _i66.WitnessMTPV2Lib());
  gh.factory<_i67.WitnessMTPV2OnchainLib>(() => _i67.WitnessMTPV2OnchainLib());
  gh.factory<_i68.WitnessSigV2Lib>(() => _i68.WitnessSigV2Lib());
  gh.factory<_i69.WitnessSigV2OnchainLib>(() => _i69.WitnessSigV2OnchainLib());
  gh.factory<_i70.ZipDecoder>(
    () => zipDecoderModule.zipDecoder(),
    instanceName: 'zipDecoder',
  );
  gh.factory<_i71.AuthProofMapper>(() => _i71.AuthProofMapper(
        get<_i25.HashMapper>(),
        get<_i35.NodeAuxMapper>(),
      ));
  gh.factory<_i72.ClaimMapper>(() => _i72.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i73.ClaimStoreRefWrapper>(() => _i73.ClaimStoreRefWrapper(
      get<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
          instanceName: 'securedStore')));
  gh.factory<_i74.EnvDataSource>(() => _i74.EnvDataSource(get<_i60.SdkEnv>()));
  gh.factory<_i75.GistProofMapper>(
      () => _i75.GistProofMapper(get<_i50.ProofMapper>()));
  gh.factory<_i76.GistProofMapper>(
      () => _i76.GistProofMapper(get<_i25.HashMapper>()));
  gh.factory<_i77.IdentitySMTStoreRefWrapper>(() =>
      _i77.IdentitySMTStoreRefWrapper(
          get<Map<String, _i13.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i78.IdentityStoreRefWrapper>(() => _i78.IdentityStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i79.KeyValueStoreRefWrapper>(() => _i79.KeyValueStoreRefWrapper(
      get<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i80.LibPolygonIdCoreCredentialDataSource>(() =>
      _i80.LibPolygonIdCoreCredentialDataSource(
          get<_i43.PolygonIdCoreCredential>()));
  gh.factory<_i81.LibPolygonIdCoreIden3commDataSource>(() =>
      _i81.LibPolygonIdCoreIden3commDataSource(
          get<_i44.PolygonIdCoreIden3comm>()));
  gh.factory<_i82.LibPolygonIdCoreIdentityDataSource>(() =>
      _i82.LibPolygonIdCoreIdentityDataSource(
          get<_i45.PolygonIdCoreIdentity>()));
  gh.factory<_i83.LibPolygonIdCoreWrapper>(
      () => _i83.LibPolygonIdCoreWrapper(get<_i46.PolygonIdCoreProof>()));
  gh.factory<_i84.LocalClaimDataSource>(() => _i84.LocalClaimDataSource(
      get<_i80.LibPolygonIdCoreCredentialDataSource>()));
  gh.factory<_i85.NodeMapper>(() => _i85.NodeMapper(
        get<_i38.NodeTypeMapper>(),
        get<_i37.NodeTypeEntityMapper>(),
        get<_i36.NodeTypeDTOMapper>(),
        get<_i25.HashMapper>(),
      ));
  gh.factoryAsync<_i86.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i41.PackageInfoRepositoryImpl>()));
  gh.factory<_i53.ProverLibDataSource>(
      () => _i53.ProverLibDataSource(get<_i53.ProverLibWrapper>()));
  gh.factory<_i87.RPCDataSource>(
      () => _i87.RPCDataSource(get<_i63.Web3Client>()));
  gh.factory<_i88.RhsNodeMapper>(
      () => _i88.RhsNodeMapper(get<_i59.RhsNodeTypeMapper>()));
  gh.factory<_i73.StorageClaimDataSource>(
      () => _i73.StorageClaimDataSource(get<_i73.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i78.StorageIdentityDataSource>(
      () async => _i78.StorageIdentityDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i78.IdentityStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i79.StorageKeyValueDataSource>(
      () async => _i79.StorageKeyValueDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i79.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i77.StorageSMTDataSource>(
      () => _i77.StorageSMTDataSource(get<_i77.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i62.WalletDataSource>(
      () => _i62.WalletDataSource(get<_i62.WalletLibWrapper>()));
  gh.factory<_i65.WitnessDataSource>(
      () => _i65.WitnessDataSource(get<_i65.WitnessIsolatesWrapper>()));
  gh.factory<_i89.ConfigRepositoryImpl>(
      () => _i89.ConfigRepositoryImpl(get<_i74.EnvDataSource>()));
  gh.factory<_i90.CredentialRepositoryImpl>(() => _i90.CredentialRepositoryImpl(
        get<_i55.RemoteClaimDataSource>(),
        get<_i73.StorageClaimDataSource>(),
        get<_i84.LocalClaimDataSource>(),
        get<_i72.ClaimMapper>(),
        get<_i19.FiltersMapper>(),
        get<_i27.IdFilterMapper>(),
      ));
  gh.factoryAsync<_i91.GetPackageNameUseCase>(() async =>
      _i91.GetPackageNameUseCase(
          await get.getAsync<_i86.PackageInfoRepository>()));
  gh.factory<_i92.Iden3commRepositoryImpl>(() => _i92.Iden3commRepositoryImpl(
        get<_i56.RemoteIden3commDataSource>(),
        get<_i81.LibPolygonIdCoreIden3commDataSource>(),
        get<_i5.AuthResponseMapper>(),
        get<_i4.AuthInputsMapper>(),
        get<_i71.AuthProofMapper>(),
        get<_i76.GistProofMapper>(),
      ));
  gh.factory<_i83.LibPolygonIdCoreProofDataSource>(() =>
      _i83.LibPolygonIdCoreProofDataSource(
          get<_i83.LibPolygonIdCoreWrapper>()));
  gh.factory<_i93.ProofRepositoryImpl>(() => _i93.ProofRepositoryImpl(
        get<_i65.WitnessDataSource>(),
        get<_i53.ProverLibDataSource>(),
        get<_i83.LibPolygonIdCoreProofDataSource>(),
        get<_i34.LocalProofFilesDataSource>(),
        get<_i49.ProofCircuitDataSource>(),
        get<_i57.RemoteIdentityDataSource>(),
        get<_i33.LocalContractFilesDataSource>(),
        get<_i87.RPCDataSource>(),
        get<_i7.CircuitTypeMapper>(),
        get<_i31.JWZProofMapper>(),
        get<_i72.ClaimMapper>(),
        get<_i58.RevocationStatusMapper>(),
        get<_i30.JWZMapper>(),
        get<_i51.ProofRequestFiltersMapper>(),
        get<_i71.AuthProofMapper>(),
        get<_i75.GistProofMapper>(),
        get<_i76.GistProofMapper>(),
        get<_i8.CircuitsDownloadDataSource>(),
      ));
  gh.factory<_i94.SMTDataSource>(() => _i94.SMTDataSource(
        get<_i26.HexMapper>(),
        get<_i32.LibBabyJubJubDataSource>(),
        get<_i77.StorageSMTDataSource>(),
      ));
  gh.factory<_i95.SMTRepositoryImpl>(() => _i95.SMTRepositoryImpl(
        get<_i94.SMTDataSource>(),
        get<_i77.StorageSMTDataSource>(),
        get<_i32.LibBabyJubJubDataSource>(),
        get<_i85.NodeMapper>(),
        get<_i25.HashMapper>(),
        get<_i50.ProofMapper>(),
      ));
  gh.factory<_i96.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i89.ConfigRepositoryImpl>()));
  gh.factory<_i97.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i90.CredentialRepositoryImpl>()));
  gh.factory<_i98.GetAuthClaimUseCase>(
      () => _i98.GetAuthClaimUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i99.GetClaimsUseCase>(
      () => _i99.GetClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i100.GetEnvConfigUseCase>(
      () => _i100.GetEnvConfigUseCase(get<_i96.ConfigRepository>()));
  gh.factory<_i101.GetVocabsUseCase>(
      () => _i101.GetVocabsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i102.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i92.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i103.IdentityRepositoryImpl>(
      () async => _i103.IdentityRepositoryImpl(
            get<_i62.WalletDataSource>(),
            get<_i57.RemoteIdentityDataSource>(),
            await get.getAsync<_i78.StorageIdentityDataSource>(),
            get<_i87.RPCDataSource>(),
            get<_i33.LocalContractFilesDataSource>(),
            get<_i32.LibBabyJubJubDataSource>(),
            get<_i82.LibPolygonIdCoreIdentityDataSource>(),
            get<_i94.SMTDataSource>(),
            get<_i16.EncryptionDbDataSource>(),
            get<_i12.DestinationPathDataSource>(),
            get<_i26.HexMapper>(),
            get<_i48.PrivateKeyMapper>(),
            get<_i29.IdentityDTOMapper>(),
            get<_i88.RhsNodeMapper>(),
            get<_i61.StateIdentifierMapper>(),
            get<_i85.NodeMapper>(),
            get<_i54.QMapper>(),
            get<_i17.EncryptionKeyMapper>(),
          ));
  gh.factory<_i104.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i93.ProofRepositoryImpl>()));
  gh.factory<_i105.ProveUseCase>(
      () => _i105.ProveUseCase(get<_i104.ProofRepository>()));
  gh.factory<_i106.RemoveAllClaimsUseCase>(
      () => _i106.RemoveAllClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i107.RemoveClaimsUseCase>(
      () => _i107.RemoveClaimsUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i108.SMTRepository>(
      () => repositoriesModule.smtRepository(get<_i95.SMTRepositoryImpl>()));
  gh.factory<_i109.UpdateClaimUseCase>(
      () => _i109.UpdateClaimUseCase(get<_i97.CredentialRepository>()));
  gh.factory<_i110.CircuitsFilesExistUseCase>(
      () => _i110.CircuitsFilesExistUseCase(get<_i104.ProofRepository>()));
  gh.factory<_i111.DownloadCircuitsUseCase>(() => _i111.DownloadCircuitsUseCase(
        get<_i104.ProofRepository>(),
        get<_i110.CircuitsFilesExistUseCase>(),
      ));
  gh.factory<_i112.GetJWZUseCase>(
      () => _i112.GetJWZUseCase(get<_i104.ProofRepository>()));
  gh.factoryAsync<_i113.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i103.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i114.ImportIdentityUseCase>(() async =>
      _i114.ImportIdentityUseCase(
          await get.getAsync<_i113.IdentityRepository>()));
  gh.factory<_i115.IsProofCircuitSupportedUseCase>(
      () => _i115.IsProofCircuitSupportedUseCase(get<_i104.ProofRepository>()));
  gh.factory<_i116.LoadCircuitUseCase>(
      () => _i116.LoadCircuitUseCase(get<_i104.ProofRepository>()));
  gh.factoryAsync<_i117.RemoveIdentityUseCase>(
      () async => _i117.RemoveIdentityUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i106.RemoveAllClaimsUseCase>(),
          ));
  gh.factoryAsync<_i118.SignMessageUseCase>(() async =>
      _i118.SignMessageUseCase(await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i119.ExportIdentityUseCase>(() async =>
      _i119.ExportIdentityUseCase(
          await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i120.FetchStateRootsUseCase>(() async =>
      _i120.FetchStateRootsUseCase(
          await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i121.GetAuthChallengeUseCase>(() async =>
      _i121.GetAuthChallengeUseCase(
          await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i122.GetDidUseCase>(() async =>
      _i122.GetDidUseCase(await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i123.GetGistProofUseCase>(
      () async => _i123.GetGistProofUseCase(
            get<_i104.ProofRepository>(),
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i100.GetEnvConfigUseCase>(),
            await get.getAsync<_i122.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i124.GetIdentitiesUseCase>(() async =>
      _i124.GetIdentitiesUseCase(
          await get.getAsync<_i113.IdentityRepository>()));
  gh.factoryAsync<_i125.GetIdentityAuthClaimUseCase>(
      () async => _i125.GetIdentityAuthClaimUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i98.GetAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i126.FetchIdentityStateUseCase>(
      () async => _i126.FetchIdentityStateUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i100.GetEnvConfigUseCase>(),
            await get.getAsync<_i122.GetDidUseCase>(),
          ));
  gh.factoryAsync<_i127.GenerateNonRevProofUseCase>(
      () async => _i127.GenerateNonRevProofUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i97.CredentialRepository>(),
            get<_i100.GetEnvConfigUseCase>(),
            await get.getAsync<_i126.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i128.GetClaimRevocationStatusUseCase>(
      () async => _i128.GetClaimRevocationStatusUseCase(
            get<_i97.CredentialRepository>(),
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i127.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i129.GetDidIdentifierUseCase>(
      () async => _i129.GetDidIdentifierUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i125.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i130.GetIdentityUseCase>(
      () async => _i130.GetIdentityUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i122.GetDidUseCase>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i131.BackupIdentityUseCase>(
      () async => _i131.BackupIdentityUseCase(
            await get.getAsync<_i130.GetIdentityUseCase>(),
            await get.getAsync<_i119.ExportIdentityUseCase>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i132.CheckIdentityValidityUseCase>(
      () async => _i132.CheckIdentityValidityUseCase(
            get<String>(instanceName: 'accessMessage'),
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i133.CreateAndSaveIdentityUseCase>(
      () async => _i133.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i122.GetDidUseCase>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
            await get.getAsync<_i125.GetIdentityAuthClaimUseCase>(),
          ));
  gh.factoryAsync<_i134.CreateNewIdentityUseCase>(
      () async => _i134.CreateNewIdentityUseCase(
            get<String>(instanceName: 'accessMessage'),
            await get.getAsync<_i113.IdentityRepository>(),
            await get.getAsync<_i133.CreateAndSaveIdentityUseCase>(),
          ));
  gh.factoryAsync<_i135.GenerateProofUseCase>(
      () async => _i135.GenerateProofUseCase(
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i108.SMTRepository>(),
            get<_i104.ProofRepository>(),
            get<_i105.ProveUseCase>(),
            await get.getAsync<_i130.GetIdentityUseCase>(),
            get<_i98.GetAuthClaimUseCase>(),
            await get.getAsync<_i123.GetGistProofUseCase>(),
            await get.getAsync<_i122.GetDidUseCase>(),
            await get.getAsync<_i118.SignMessageUseCase>(),
          ));
  gh.factoryAsync<_i136.GetAuthInputsUseCase>(
      () async => _i136.GetAuthInputsUseCase(
            await get.getAsync<_i130.GetIdentityUseCase>(),
            get<_i98.GetAuthClaimUseCase>(),
            await get.getAsync<_i118.SignMessageUseCase>(),
            await get.getAsync<_i123.GetGistProofUseCase>(),
            get<_i102.Iden3commRepository>(),
            await get.getAsync<_i113.IdentityRepository>(),
            get<_i108.SMTRepository>(),
          ));
  gh.factoryAsync<_i137.GetAuthTokenUseCase>(
      () async => _i137.GetAuthTokenUseCase(
            get<_i116.LoadCircuitUseCase>(),
            get<_i112.GetJWZUseCase>(),
            await get.getAsync<_i121.GetAuthChallengeUseCase>(),
            await get.getAsync<_i136.GetAuthInputsUseCase>(),
            get<_i105.ProveUseCase>(),
          ));
  gh.factoryAsync<_i138.GetProofsUseCase>(() async => _i138.GetProofsUseCase(
        get<_i104.ProofRepository>(),
        await get.getAsync<_i113.IdentityRepository>(),
        get<_i99.GetClaimsUseCase>(),
        await get.getAsync<_i135.GenerateProofUseCase>(),
        get<_i115.IsProofCircuitSupportedUseCase>(),
        get<_i24.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i139.Proof>(() async => _i139.Proof(
        await get.getAsync<_i135.GenerateProofUseCase>(),
        get<_i111.DownloadCircuitsUseCase>(),
        get<_i110.CircuitsFilesExistUseCase>(),
      ));
  gh.factoryAsync<_i140.RestoreIdentityUseCase>(
      () async => _i140.RestoreIdentityUseCase(
            await get.getAsync<_i133.CreateAndSaveIdentityUseCase>(),
            await get.getAsync<_i130.GetIdentityUseCase>(),
            await get.getAsync<_i114.ImportIdentityUseCase>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i141.AuthenticateUseCase>(
      () async => _i141.AuthenticateUseCase(
            get<_i102.Iden3commRepository>(),
            await get.getAsync<_i138.GetProofsUseCase>(),
            await get.getAsync<_i137.GetAuthTokenUseCase>(),
            get<_i100.GetEnvConfigUseCase>(),
            await get.getAsync<_i91.GetPackageNameUseCase>(),
            await get.getAsync<_i129.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i142.FetchAndSaveClaimsUseCase>(
      () async => _i142.FetchAndSaveClaimsUseCase(
            get<_i20.GetFetchRequestsUseCase>(),
            await get.getAsync<_i137.GetAuthTokenUseCase>(),
            get<_i97.CredentialRepository>(),
          ));
  gh.factoryAsync<_i143.Iden3comm>(() async => _i143.Iden3comm(
        get<_i101.GetVocabsUseCase>(),
        await get.getAsync<_i141.AuthenticateUseCase>(),
        await get.getAsync<_i138.GetProofsUseCase>(),
        get<_i22.GetIden3MessageUseCase>(),
      ));
  gh.factoryAsync<_i144.Identity>(() async => _i144.Identity(
        await get.getAsync<_i132.CheckIdentityValidityUseCase>(),
        await get.getAsync<_i133.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i134.CreateNewIdentityUseCase>(),
        await get.getAsync<_i140.RestoreIdentityUseCase>(),
        await get.getAsync<_i131.BackupIdentityUseCase>(),
        await get.getAsync<_i130.GetIdentityUseCase>(),
        await get.getAsync<_i124.GetIdentitiesUseCase>(),
        await get.getAsync<_i117.RemoveIdentityUseCase>(),
        await get.getAsync<_i129.GetDidIdentifierUseCase>(),
        await get.getAsync<_i118.SignMessageUseCase>(),
        await get.getAsync<_i126.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i145.Credential>(() async => _i145.Credential(
        await get.getAsync<_i142.FetchAndSaveClaimsUseCase>(),
        get<_i99.GetClaimsUseCase>(),
        get<_i107.RemoveClaimsUseCase>(),
        get<_i109.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i146.PlatformModule {}

class _$NetworkModule extends _i146.NetworkModule {}

class _$DatabaseModule extends _i146.DatabaseModule {}

class _$EncryptionModule extends _i146.EncryptionModule {}

class _$Sdk extends _i146.Sdk {}

class _$ZipDecoderModule extends _i146.ZipDecoderModule {}

class _$RepositoriesModule extends _i146.RepositoriesModule {}
