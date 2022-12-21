// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt/encrypt.dart' as _i15;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i35;
import 'package:sembast/sembast.dart' as _i13;
import 'package:web3dart/web3dart.dart' as _i53;

import '../../common/data/data_sources/env_datasource.dart' as _i61;
import '../../common/data/data_sources/package_info_datasource.dart' as _i36;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i69;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i37;
import '../../common/domain/repositories/config_repository.dart' as _i74;
import '../../common/domain/repositories/package_info_repository.dart' as _i66;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i79;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i71;
import '../../credential/data/credential_repository_impl.dart' as _i70;
import '../../credential/data/data_sources/db_destination_path_data_source.dart'
    as _i12;
import '../../credential/data/data_sources/encryption_db_data_source.dart'
    as _i16;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i45;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i60;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i59;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/encryption_key_mapper.dart' as _i17;
import '../../credential/data/mappers/filter_mapper.dart' as _i18;
import '../../credential/data/mappers/filters_mapper.dart' as _i19;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i26;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i48;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i75;
import '../../credential/domain/use_cases/export_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i109;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i77;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i98;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i78;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i20;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i80;
import '../../credential/domain/use_cases/import_claims_use_case.dart' as _i82;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i85;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i86;
import '../../env/sdk_env.dart' as _i50;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i46;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i41;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i63;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i72;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i108;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i105;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i21;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i23;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i24;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i106;
import '../../identity/data/data_sources/babyjubjub_lib_data_source.dart'
    as _i7;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i28;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i32;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i47;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i67;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i64;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i65;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i52;
import '../../identity/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../identity/data/mappers/did_mapper.dart' as _i14;
import '../../identity/data/mappers/hash_mapper.dart' as _i62;
import '../../identity/data/mappers/hex_mapper.dart' as _i25;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i30;
import '../../identity/data/mappers/private_key_mapper.dart' as _i38;
import '../../identity/data/mappers/q_mapper.dart' as _i44;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i68;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i49;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i51;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i81;
import '../../identity/domain/repositories/identity_repository.dart' as _i88;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i94;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i96;
import '../../identity/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i97;
import '../../identity/domain/use_cases/get_auth_inputs_use_case.dart' as _i104;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i99;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i100;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i101;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i91;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i92;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/iden3core/iden3core.dart' as _i27;
import '../../identity/libs/smt/node.dart' as _i34;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i58;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i33;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i43;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i55;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i8;
import '../../proof_generation/data/mappers/jwz_mapper.dart' as _i31;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i40;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i73;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i83;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i103;
import '../../proof_generation/domain/use_cases/get_jwz_use_case.dart' as _i87;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i89;
import '../../proof_generation/domain/use_cases/load_circuit_use_case.dart'
    as _i90;
import '../../proof_generation/domain/use_cases/prove_use_case.dart' as _i84;
import '../../proof_generation/libs/prover/prover.dart' as _i42;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i54;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i56;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i57;
import '../credential.dart' as _i111;
import '../iden3comm.dart' as _i110;
import '../identity.dart' as _i102;
import '../mappers/iden3_message_type_mapper.dart' as _i29;
import '../proof.dart' as _i107;
import 'injector.dart' as _i112; // ignore_for_file: unnecessary_lambdas

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
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.BabyjubjubLibDataSource>(
      () => _i7.BabyjubjubLibDataSource(get<_i6.BabyjubjubLib>()));
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
        databaseModule.claimDatabase(
      identifier,
      privateKey,
    ),
    instanceName: 'polygonIdSdkClaims',
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
  gh.factory<_i25.HexMapper>(() => _i25.HexMapper());
  gh.factory<_i26.IdFilterMapper>(() => _i26.IdFilterMapper());
  gh.factory<_i27.Iden3CoreLib>(() => _i27.Iden3CoreLib());
  gh.factory<_i28.Iden3LibIsolatesWrapper>(
      () => _i28.Iden3LibIsolatesWrapper());
  gh.factory<_i29.Iden3MessageTypeMapper>(() => _i29.Iden3MessageTypeMapper());
  gh.factory<_i30.IdentityDTOMapper>(() => _i30.IdentityDTOMapper());
  gh.factory<_i31.JWZMapper>(() => _i31.JWZMapper());
  gh.factory<_i28.LibIdentityDataSource>(() => _i28.LibIdentityDataSource(
        get<_i27.Iden3CoreLib>(),
        get<_i28.Iden3LibIsolatesWrapper>(),
      ));
  gh.factory<_i32.LocalContractFilesDataSource>(
      () => _i32.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i33.LocalProofFilesDataSource>(
      () => _i33.LocalProofFilesDataSource());
  gh.factory<_i34.Node>(() => _i34.Node(
        get<_i34.NodeType>(),
        get<_i27.Iden3CoreLib>(),
      ));
  gh.lazySingletonAsync<_i35.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i36.PackageInfoDataSource>(() async =>
      _i36.PackageInfoDataSource(await get.getAsync<_i35.PackageInfo>()));
  gh.factoryAsync<_i37.PackageInfoRepositoryImpl>(() async =>
      _i37.PackageInfoRepositoryImpl(
          await get.getAsync<_i36.PackageInfoDataSource>()));
  gh.factory<_i38.PrivateKeyMapper>(() => _i38.PrivateKeyMapper());
  gh.factory<_i39.ProofCircuitDataSource>(() => _i39.ProofCircuitDataSource());
  gh.factory<_i40.ProofMapper>(() => _i40.ProofMapper());
  gh.factory<_i41.ProofRequestFiltersMapper>(
      () => _i41.ProofRequestFiltersMapper());
  gh.factory<_i42.ProverLib>(() => _i42.ProverLib());
  gh.factory<_i43.ProverLibWrapper>(() => _i43.ProverLibWrapper());
  gh.factory<_i44.QMapper>(() => _i44.QMapper());
  gh.factory<_i45.RemoteClaimDataSource>(
      () => _i45.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i46.RemoteIden3commDataSource>(
      () => _i46.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i47.RemoteIdentityDataSource>(
      () => _i47.RemoteIdentityDataSource());
  gh.factory<_i48.RevocationStatusMapper>(() => _i48.RevocationStatusMapper());
  gh.factory<_i49.RhsNodeTypeMapper>(() => _i49.RhsNodeTypeMapper());
  gh.lazySingleton<_i50.SdkEnv>(() => sdk.sdkEnv);
  gh.factoryParam<_i13.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i51.StateIdentifierMapper>(() => _i51.StateIdentifierMapper());
  gh.factory<_i13.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i13.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i52.WalletLibWrapper>(() => _i52.WalletLibWrapper());
  gh.factory<_i53.Web3Client>(
      () => networkModule.web3Client(get<_i50.SdkEnv>()));
  gh.factory<_i54.WitnessAuthLib>(() => _i54.WitnessAuthLib());
  gh.factory<_i55.WitnessIsolatesWrapper>(() => _i55.WitnessIsolatesWrapper());
  gh.factory<_i56.WitnessMtpLib>(() => _i56.WitnessMtpLib());
  gh.factory<_i57.WitnessSigLib>(() => _i57.WitnessSigLib());
  gh.factory<_i58.AtomicQueryInputsWrapper>(
      () => _i58.AtomicQueryInputsWrapper(get<_i27.Iden3CoreLib>()));
  gh.factory<_i59.ClaimMapper>(() => _i59.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i60.ClaimStoreRefWrapper>(() => _i60.ClaimStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i61.EnvDataSource>(() => _i61.EnvDataSource(get<_i50.SdkEnv>()));
  gh.factory<_i62.HashMapper>(() => _i62.HashMapper(get<_i25.HexMapper>()));
  gh.factory<_i63.Iden3commRepositoryImpl>(() => _i63.Iden3commRepositoryImpl(
        get<_i46.RemoteIden3commDataSource>(),
        get<_i25.HexMapper>(),
        get<_i5.AuthResponseMapper>(),
      ));
  gh.factory<_i64.IdentityStoreRefWrapper>(() => _i64.IdentityStoreRefWrapper(
      get<_i13.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i65.KeyValueStoreRefWrapper>(() => _i65.KeyValueStoreRefWrapper(
      get<_i13.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i66.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i37.PackageInfoRepositoryImpl>()));
  gh.factory<_i43.ProverLibDataSource>(
      () => _i43.ProverLibDataSource(get<_i43.ProverLibWrapper>()));
  gh.factory<_i67.RPCDataSource>(
      () => _i67.RPCDataSource(get<_i53.Web3Client>()));
  gh.factory<_i68.RhsNodeMapper>(
      () => _i68.RhsNodeMapper(get<_i49.RhsNodeTypeMapper>()));
  gh.factory<_i60.StorageClaimDataSource>(
      () => _i60.StorageClaimDataSource(get<_i60.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i65.StorageKeyValueDataSource>(
      () async => _i65.StorageKeyValueDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i65.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i52.WalletDataSource>(
      () => _i52.WalletDataSource(get<_i52.WalletLibWrapper>()));
  gh.factory<_i55.WitnessDataSource>(
      () => _i55.WitnessDataSource(get<_i55.WitnessIsolatesWrapper>()));
  gh.factory<_i58.AtomicQueryInputsDataSource>(() =>
      _i58.AtomicQueryInputsDataSource(get<_i58.AtomicQueryInputsWrapper>()));
  gh.factory<_i69.ConfigRepositoryImpl>(
      () => _i69.ConfigRepositoryImpl(get<_i61.EnvDataSource>()));
  gh.factory<_i70.CredentialRepositoryImpl>(() => _i70.CredentialRepositoryImpl(
        get<_i45.RemoteClaimDataSource>(),
        get<_i60.StorageClaimDataSource>(),
        get<_i28.LibIdentityDataSource>(),
        get<_i59.ClaimMapper>(),
        get<_i19.FiltersMapper>(),
        get<_i26.IdFilterMapper>(),
        get<_i48.RevocationStatusMapper>(),
        get<_i16.EncryptionDbDataSource>(),
        get<_i12.DestinationPathDataSource>(),
        get<_i17.EncryptionKeyMapper>(),
      ));
  gh.factoryAsync<_i71.GetPackageNameUseCase>(() async =>
      _i71.GetPackageNameUseCase(
          await get.getAsync<_i66.PackageInfoRepository>()));
  gh.factory<_i72.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i63.Iden3commRepositoryImpl>()));
  gh.factory<_i73.ProofRepositoryImpl>(() => _i73.ProofRepositoryImpl(
        get<_i55.WitnessDataSource>(),
        get<_i43.ProverLibDataSource>(),
        get<_i58.AtomicQueryInputsDataSource>(),
        get<_i33.LocalProofFilesDataSource>(),
        get<_i39.ProofCircuitDataSource>(),
        get<_i47.RemoteIdentityDataSource>(),
        get<_i8.CircuitTypeMapper>(),
        get<_i41.ProofRequestFiltersMapper>(),
        get<_i40.ProofMapper>(),
        get<_i59.ClaimMapper>(),
        get<_i48.RevocationStatusMapper>(),
        get<_i31.JWZMapper>(),
      ));
  gh.factoryAsync<_i64.StorageIdentityDataSource>(
      () async => _i64.StorageIdentityDataSource(
            await get.getAsync<_i13.Database>(),
            get<_i64.IdentityStoreRefWrapper>(),
            await get.getAsync<_i65.StorageKeyValueDataSource>(),
            get<_i52.WalletDataSource>(),
            get<_i25.HexMapper>(),
          ));
  gh.factory<_i74.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i69.ConfigRepositoryImpl>()));
  gh.factory<_i75.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i70.CredentialRepositoryImpl>()));
  gh.factory<_i76.ExportClaimsUseCase>(
      () => _i76.ExportClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i77.GetAuthClaimUseCase>(
      () => _i77.GetAuthClaimUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i78.GetClaimsUseCase>(
      () => _i78.GetClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i79.GetEnvConfigUseCase>(
      () => _i79.GetEnvConfigUseCase(get<_i74.ConfigRepository>()));
  gh.factory<_i80.GetVocabsUseCase>(
      () => _i80.GetVocabsUseCase(get<_i75.CredentialRepository>()));
  gh.factoryAsync<_i81.IdentityRepositoryImpl>(
      () async => _i81.IdentityRepositoryImpl(
            get<_i52.WalletDataSource>(),
            get<_i28.LibIdentityDataSource>(),
            get<_i47.RemoteIdentityDataSource>(),
            await get.getAsync<_i64.StorageIdentityDataSource>(),
            get<_i67.RPCDataSource>(),
            get<_i32.LocalContractFilesDataSource>(),
            get<_i7.BabyjubjubLibDataSource>(),
            get<_i25.HexMapper>(),
            get<_i38.PrivateKeyMapper>(),
            get<_i30.IdentityDTOMapper>(),
            get<_i68.RhsNodeMapper>(),
            get<_i51.StateIdentifierMapper>(),
            get<_i14.DidMapper>(),
            get<_i62.HashMapper>(),
            get<_i4.AuthInputsMapper>(),
            get<_i44.QMapper>(),
          ));
  gh.factory<_i82.ImportClaimsUseCase>(
      () => _i82.ImportClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i83.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i73.ProofRepositoryImpl>()));
  gh.factory<_i84.ProveUseCase>(
      () => _i84.ProveUseCase(get<_i83.ProofRepository>()));
  gh.factory<_i85.RemoveClaimsUseCase>(
      () => _i85.RemoveClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i86.UpdateClaimUseCase>(
      () => _i86.UpdateClaimUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i87.GetJWZUseCase>(
      () => _i87.GetJWZUseCase(get<_i83.ProofRepository>()));
  gh.factoryAsync<_i88.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i81.IdentityRepositoryImpl>()));
  gh.factory<_i89.IsProofCircuitSupportedUseCase>(
      () => _i89.IsProofCircuitSupportedUseCase(get<_i83.ProofRepository>()));
  gh.factory<_i90.LoadCircuitUseCase>(
      () => _i90.LoadCircuitUseCase(get<_i83.ProofRepository>()));
  gh.factoryAsync<_i91.RemoveIdentityUseCase>(() async =>
      _i91.RemoveIdentityUseCase(
          await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i92.SignMessageUseCase>(() async =>
      _i92.SignMessageUseCase(await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i93.CreateAndSaveIdentityUseCase>(
      () async => _i93.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i88.IdentityRepository>(),
            get<_i79.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i94.FetchIdentityStateUseCase>(
      () async => _i94.FetchIdentityStateUseCase(
            await get.getAsync<_i88.IdentityRepository>(),
            get<_i79.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i95.FetchStateRootsUseCase>(() async =>
      _i95.FetchStateRootsUseCase(
          await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i96.GenerateNonRevProofUseCase>(
      () async => _i96.GenerateNonRevProofUseCase(
            await get.getAsync<_i88.IdentityRepository>(),
            get<_i75.CredentialRepository>(),
            get<_i79.GetEnvConfigUseCase>(),
            await get.getAsync<_i94.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i97.GetAuthChallengeUseCase>(() async =>
      _i97.GetAuthChallengeUseCase(
          await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i98.GetClaimRevocationStatusUseCase>(
      () async => _i98.GetClaimRevocationStatusUseCase(
            get<_i75.CredentialRepository>(),
            await get.getAsync<_i88.IdentityRepository>(),
            await get.getAsync<_i96.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i99.GetDidIdentifierUseCase>(() async =>
      _i99.GetDidIdentifierUseCase(
          await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i100.GetIdentifierUseCase>(() async =>
      _i100.GetIdentifierUseCase(
          await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i101.GetIdentityUseCase>(() async =>
      _i101.GetIdentityUseCase(await get.getAsync<_i88.IdentityRepository>()));
  gh.factoryAsync<_i102.Identity>(() async => _i102.Identity(
        await get.getAsync<_i93.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i101.GetIdentityUseCase>(),
        await get.getAsync<_i91.RemoveIdentityUseCase>(),
        await get.getAsync<_i100.GetIdentifierUseCase>(),
        await get.getAsync<_i92.SignMessageUseCase>(),
        await get.getAsync<_i94.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i103.GenerateProofUseCase>(
      () async => _i103.GenerateProofUseCase(
            get<_i83.ProofRepository>(),
            await get.getAsync<_i98.GetClaimRevocationStatusUseCase>(),
            get<_i84.ProveUseCase>(),
          ));
  gh.factoryAsync<_i104.GetAuthInputsUseCase>(
      () async => _i104.GetAuthInputsUseCase(
            await get.getAsync<_i101.GetIdentityUseCase>(),
            get<_i77.GetAuthClaimUseCase>(),
            await get.getAsync<_i92.SignMessageUseCase>(),
            await get.getAsync<_i88.IdentityRepository>(),
          ));
  gh.factoryAsync<_i105.GetAuthTokenUseCase>(
      () async => _i105.GetAuthTokenUseCase(
            get<_i90.LoadCircuitUseCase>(),
            get<_i87.GetJWZUseCase>(),
            await get.getAsync<_i97.GetAuthChallengeUseCase>(),
            await get.getAsync<_i104.GetAuthInputsUseCase>(),
            get<_i84.ProveUseCase>(),
          ));
  gh.factoryAsync<_i106.GetProofsUseCase>(() async => _i106.GetProofsUseCase(
        get<_i83.ProofRepository>(),
        await get.getAsync<_i88.IdentityRepository>(),
        get<_i78.GetClaimsUseCase>(),
        await get.getAsync<_i103.GenerateProofUseCase>(),
        get<_i89.IsProofCircuitSupportedUseCase>(),
        get<_i24.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i107.Proof>(() async =>
      _i107.Proof(await get.getAsync<_i103.GenerateProofUseCase>()));
  gh.factoryAsync<_i108.AuthenticateUseCase>(
      () async => _i108.AuthenticateUseCase(
            get<_i72.Iden3commRepository>(),
            await get.getAsync<_i106.GetProofsUseCase>(),
            await get.getAsync<_i105.GetAuthTokenUseCase>(),
            get<_i79.GetEnvConfigUseCase>(),
            await get.getAsync<_i71.GetPackageNameUseCase>(),
            await get.getAsync<_i99.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i109.FetchAndSaveClaimsUseCase>(
      () async => _i109.FetchAndSaveClaimsUseCase(
            get<_i20.GetFetchRequestsUseCase>(),
            await get.getAsync<_i105.GetAuthTokenUseCase>(),
            get<_i75.CredentialRepository>(),
          ));
  gh.factoryAsync<_i110.Iden3comm>(() async => _i110.Iden3comm(
        get<_i80.GetVocabsUseCase>(),
        await get.getAsync<_i108.AuthenticateUseCase>(),
        await get.getAsync<_i106.GetProofsUseCase>(),
        get<_i22.GetIden3MessageUseCase>(),
      ));
  gh.factoryAsync<_i111.Credential>(() async => _i111.Credential(
        await get.getAsync<_i109.FetchAndSaveClaimsUseCase>(),
        get<_i78.GetClaimsUseCase>(),
        get<_i85.RemoveClaimsUseCase>(),
        get<_i86.UpdateClaimUseCase>(),
        get<_i76.ExportClaimsUseCase>(),
        get<_i82.ImportClaimsUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i112.PlatformModule {}

class _$NetworkModule extends _i112.NetworkModule {}

class _$DatabaseModule extends _i112.DatabaseModule {}

class _$EncryptionModule extends _i112.EncryptionModule {}

class _$Sdk extends _i112.Sdk {}

class _$RepositoriesModule extends _i112.RepositoriesModule {}
