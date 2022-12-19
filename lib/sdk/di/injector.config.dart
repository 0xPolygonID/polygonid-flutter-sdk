// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt/encrypt.dart' as _i13;
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i34;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i51;

import '../../common/data/data_sources/env_datasource.dart' as _i59;
import '../../common/data/data_sources/package_info_datasource.dart' as _i35;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i65;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i36;
import '../../common/domain/repositories/config_repository.dart' as _i69;
import '../../common/domain/repositories/package_info_repository.dart' as _i62;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i73;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i67;
import '../../credential/data/credential_repository_impl.dart' as _i66;
import '../../credential/data/data_sources/db_destination_path_data_source.dart'
    as _i10;
import '../../credential/data/data_sources/encryption_db_data_source.dart'
    as _i14;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i43;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i58;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i57;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/encryption_key_mapper.dart' as _i15;
import '../../credential/data/mappers/filter_mapper.dart' as _i16;
import '../../credential/data/mappers/filters_mapper.dart' as _i17;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i24;
import '../../credential/data/mappers/initialization_vector_mapper.dart'
    as _i28;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i46;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i70;
import '../../credential/domain/use_cases/export_claims_use_case.dart' as _i71;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i96;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i91;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i72;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i18;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i74;
import '../../credential/domain/use_cases/import_claims_use_case.dart' as _i77;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i79;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i80;
import '../../env/sdk_env.dart' as _i48;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i44;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i40;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i75;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i81;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i100;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i90;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i19;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i21;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i98;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i29;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i30;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i31;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i45;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i63;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i50;
import '../../identity/data/mappers/did_mapper.dart' as _i12;
import '../../identity/data/mappers/hex_mapper.dart' as _i23;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i27;
import '../../identity/data/mappers/private_key_mapper.dart' as _i37;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i64;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i47;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i49;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i76;
import '../../identity/domain/repositories/identity_repository.dart' as _i82;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i86;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i92;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i93;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i94;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i84;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i85;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i25;
import '../../identity/libs/smt/node.dart' as _i33;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i56;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i32;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i38;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i42;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i53;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i39;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i68;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i78;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i97;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i83;
import '../../proof_generation/libs/prover/prover.dart' as _i41;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i52;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i54;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i55;
import '../credential.dart' as _i101;
import '../iden3comm.dart' as _i102;
import '../identity.dart' as _i95;
import '../mappers/iden3_message_type_mapper.dart' as _i26;
import '../proof.dart' as _i99;
import 'injector.dart' as _i103; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.CircuitTypeMapper>(() => _i6.CircuitTypeMapper());
  gh.factory<_i7.ClaimInfoMapper>(() => _i7.ClaimInfoMapper());
  gh.factory<_i8.ClaimStateMapper>(() => _i8.ClaimStateMapper());
  gh.factory<_i9.Client>(() => networkModule.client);
  gh.factory<_i10.CreatePathWrapper>(() => _i10.CreatePathWrapper());
  gh.lazySingletonAsync<_i11.Database>(() => databaseModule.database());
  gh.factoryParamAsync<_i11.Database, String?, String?>(
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
  gh.factory<_i10.DestinationPathDataSource>(
      () => _i10.DestinationPathDataSource(get<_i10.CreatePathWrapper>()));
  gh.factory<_i12.DidMapper>(() => _i12.DidMapper());
  gh.factoryParam<_i13.Encrypter, _i13.Key, dynamic>(
    (
      key,
      _,
    ) =>
        encryptionModule.encryptAES(key),
    instanceName: 'encryptAES',
  );
  gh.factory<_i14.EncryptionDbDataSource>(() => _i14.EncryptionDbDataSource());
  gh.factory<_i15.EncryptionKeyMapper>(() => _i15.EncryptionKeyMapper());
  gh.factory<_i16.FilterMapper>(() => _i16.FilterMapper());
  gh.factory<_i17.FiltersMapper>(
      () => _i17.FiltersMapper(get<_i16.FilterMapper>()));
  gh.factory<_i18.GetFetchRequestsUseCase>(
      () => _i18.GetFetchRequestsUseCase());
  gh.factory<_i19.GetIden3MessageTypeUseCase>(
      () => _i19.GetIden3MessageTypeUseCase());
  gh.factory<_i20.GetIden3MessageUseCase>(() =>
      _i20.GetIden3MessageUseCase(get<_i19.GetIden3MessageTypeUseCase>()));
  gh.factory<_i21.GetProofQueryUseCase>(() => _i21.GetProofQueryUseCase());
  gh.factory<_i22.GetProofRequestsUseCase>(
      () => _i22.GetProofRequestsUseCase(get<_i21.GetProofQueryUseCase>()));
  gh.factory<_i23.HexMapper>(() => _i23.HexMapper());
  gh.factory<_i24.IdFilterMapper>(() => _i24.IdFilterMapper());
  gh.factory<_i25.Iden3CoreLib>(() => _i25.Iden3CoreLib());
  gh.factory<_i26.Iden3MessageTypeMapper>(() => _i26.Iden3MessageTypeMapper());
  gh.factory<_i27.IdentityDTOMapper>(() => _i27.IdentityDTOMapper());
  gh.factory<_i28.InitializationVectorMapper>(
      () => _i28.InitializationVectorMapper());
  gh.factory<_i29.JWZIsolatesWrapper>(() => _i29.JWZIsolatesWrapper());
  gh.factory<_i30.LibIdentityDataSource>(
      () => _i30.LibIdentityDataSource(get<_i25.Iden3CoreLib>()));
  gh.factory<_i31.LocalContractFilesDataSource>(
      () => _i31.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i32.LocalProofFilesDataSource>(
      () => _i32.LocalProofFilesDataSource());
  gh.factory<_i33.Node>(() => _i33.Node(
        get<_i33.NodeType>(),
        get<_i25.Iden3CoreLib>(),
      ));
  gh.lazySingletonAsync<_i34.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i35.PackageInfoDataSource>(() async =>
      _i35.PackageInfoDataSource(await get.getAsync<_i34.PackageInfo>()));
  gh.factoryAsync<_i36.PackageInfoRepositoryImpl>(() async =>
      _i36.PackageInfoRepositoryImpl(
          await get.getAsync<_i35.PackageInfoDataSource>()));
  gh.factory<_i37.PrivateKeyMapper>(() => _i37.PrivateKeyMapper());
  gh.factory<_i38.ProofCircuitDataSource>(() => _i38.ProofCircuitDataSource());
  gh.factory<_i39.ProofMapper>(() => _i39.ProofMapper());
  gh.factory<_i40.ProofRequestFiltersMapper>(
      () => _i40.ProofRequestFiltersMapper());
  gh.factory<_i41.ProverLib>(() => _i41.ProverLib());
  gh.factory<_i42.ProverLibWrapper>(() => _i42.ProverLibWrapper());
  gh.factory<_i43.RemoteClaimDataSource>(
      () => _i43.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i44.RemoteIden3commDataSource>(
      () => _i44.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i45.RemoteIdentityDataSource>(
      () => _i45.RemoteIdentityDataSource());
  gh.factory<_i46.RevocationStatusMapper>(() => _i46.RevocationStatusMapper());
  gh.factory<_i47.RhsNodeTypeMapper>(() => _i47.RhsNodeTypeMapper());
  gh.lazySingleton<_i48.SdkEnv>(() => sdk.sdkEnv);
  gh.factoryParam<_i11.SembastCodec, String, dynamic>(
    (
      privateKey,
      _,
    ) =>
        databaseModule.getCodec(privateKey),
    instanceName: 'sembastCodec',
  );
  gh.factory<_i49.StateIdentifierMapper>(() => _i49.StateIdentifierMapper());
  gh.factory<_i11.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i50.WalletLibWrapper>(() => _i50.WalletLibWrapper());
  gh.factory<_i51.Web3Client>(
      () => networkModule.web3Client(get<_i48.SdkEnv>()));
  gh.factory<_i52.WitnessAuthLib>(() => _i52.WitnessAuthLib());
  gh.factory<_i53.WitnessIsolatesWrapper>(() => _i53.WitnessIsolatesWrapper());
  gh.factory<_i54.WitnessMtpLib>(() => _i54.WitnessMtpLib());
  gh.factory<_i55.WitnessSigLib>(() => _i55.WitnessSigLib());
  gh.factory<_i56.AtomicQueryInputsWrapper>(
      () => _i56.AtomicQueryInputsWrapper(get<_i25.Iden3CoreLib>()));
  gh.factory<_i57.ClaimMapper>(() => _i57.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i58.ClaimStoreRefWrapper>(() => _i58.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i59.EnvDataSource>(() => _i59.EnvDataSource(get<_i48.SdkEnv>()));
  gh.factory<_i60.IdentityStoreRefWrapper>(() => _i60.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i61.KeyValueStoreRefWrapper>(() => _i61.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i62.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i36.PackageInfoRepositoryImpl>()));
  gh.factory<_i42.ProverLibDataSource>(
      () => _i42.ProverLibDataSource(get<_i42.ProverLibWrapper>()));
  gh.factory<_i63.RPCDataSource>(
      () => _i63.RPCDataSource(get<_i51.Web3Client>()));
  gh.factory<_i64.RhsNodeMapper>(
      () => _i64.RhsNodeMapper(get<_i47.RhsNodeTypeMapper>()));
  gh.factory<_i58.StorageClaimDataSource>(
      () => _i58.StorageClaimDataSource(get<_i58.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i61.StorageKeyValueDataSource>(
      () async => _i61.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i61.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i50.WalletDataSource>(
      () => _i50.WalletDataSource(get<_i50.WalletLibWrapper>()));
  gh.factory<_i53.WitnessDataSource>(
      () => _i53.WitnessDataSource(get<_i53.WitnessIsolatesWrapper>()));
  gh.factory<_i56.AtomicQueryInputsDataSource>(() =>
      _i56.AtomicQueryInputsDataSource(get<_i56.AtomicQueryInputsWrapper>()));
  gh.factory<_i65.ConfigRepositoryImpl>(
      () => _i65.ConfigRepositoryImpl(get<_i59.EnvDataSource>()));
  gh.factory<_i66.CredentialRepositoryImpl>(() => _i66.CredentialRepositoryImpl(
        get<_i43.RemoteClaimDataSource>(),
        get<_i58.StorageClaimDataSource>(),
        get<_i30.LibIdentityDataSource>(),
        get<_i57.ClaimMapper>(),
        get<_i17.FiltersMapper>(),
        get<_i24.IdFilterMapper>(),
        get<_i46.RevocationStatusMapper>(),
        get<_i14.EncryptionDbDataSource>(),
        get<_i10.DestinationPathDataSource>(),
        get<_i28.InitializationVectorMapper>(),
        get<_i15.EncryptionKeyMapper>(),
      ));
  gh.factoryAsync<_i67.GetPackageNameUseCase>(() async =>
      _i67.GetPackageNameUseCase(
          await get.getAsync<_i62.PackageInfoRepository>()));
  gh.factory<_i29.JWZDataSource>(() => _i29.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i50.WalletDataSource>(),
        get<_i29.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i68.ProofRepositoryImpl>(() => _i68.ProofRepositoryImpl(
        get<_i53.WitnessDataSource>(),
        get<_i42.ProverLibDataSource>(),
        get<_i56.AtomicQueryInputsDataSource>(),
        get<_i32.LocalProofFilesDataSource>(),
        get<_i38.ProofCircuitDataSource>(),
        get<_i45.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i40.ProofRequestFiltersMapper>(),
        get<_i39.ProofMapper>(),
        get<_i57.ClaimMapper>(),
        get<_i46.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i60.StorageIdentityDataSource>(
      () async => _i60.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i60.IdentityStoreRefWrapper>(),
            await get.getAsync<_i61.StorageKeyValueDataSource>(),
            get<_i50.WalletDataSource>(),
            get<_i23.HexMapper>(),
          ));
  gh.factory<_i69.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i65.ConfigRepositoryImpl>()));
  gh.factory<_i70.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i66.CredentialRepositoryImpl>()));
  gh.factory<_i71.ExportClaimsUseCase>(
      () => _i71.ExportClaimsUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i72.GetClaimsUseCase>(
      () => _i72.GetClaimsUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i73.GetEnvConfigUseCase>(
      () => _i73.GetEnvConfigUseCase(get<_i69.ConfigRepository>()));
  gh.factory<_i74.GetVocabsUseCase>(
      () => _i74.GetVocabsUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i75.Iden3commRepositoryImpl>(() => _i75.Iden3commRepositoryImpl(
        get<_i44.RemoteIden3commDataSource>(),
        get<_i29.JWZDataSource>(),
        get<_i23.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i76.IdentityRepositoryImpl>(
      () async => _i76.IdentityRepositoryImpl(
            get<_i50.WalletDataSource>(),
            get<_i30.LibIdentityDataSource>(),
            get<_i45.RemoteIdentityDataSource>(),
            await get.getAsync<_i60.StorageIdentityDataSource>(),
            get<_i63.RPCDataSource>(),
            get<_i31.LocalContractFilesDataSource>(),
            get<_i23.HexMapper>(),
            get<_i37.PrivateKeyMapper>(),
            get<_i27.IdentityDTOMapper>(),
            get<_i64.RhsNodeMapper>(),
            get<_i49.StateIdentifierMapper>(),
            get<_i12.DidMapper>(),
          ));
  gh.factory<_i77.ImportClaimsUseCase>(
      () => _i77.ImportClaimsUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i78.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i68.ProofRepositoryImpl>()));
  gh.factory<_i79.RemoveClaimsUseCase>(
      () => _i79.RemoveClaimsUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i80.UpdateClaimUseCase>(
      () => _i80.UpdateClaimUseCase(get<_i70.CredentialRepository>()));
  gh.factory<_i81.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i75.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i82.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i76.IdentityRepositoryImpl>()));
  gh.factory<_i83.IsProofCircuitSupportedUseCase>(
      () => _i83.IsProofCircuitSupportedUseCase(get<_i78.ProofRepository>()));
  gh.factoryAsync<_i84.RemoveIdentityUseCase>(() async =>
      _i84.RemoveIdentityUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i85.SignMessageUseCase>(() async =>
      _i85.SignMessageUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i86.CreateAndSaveIdentityUseCase>(
      () async => _i86.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i73.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i87.FetchIdentityStateUseCase>(
      () async => _i87.FetchIdentityStateUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i73.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i88.FetchStateRootsUseCase>(() async =>
      _i88.FetchStateRootsUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i89.GenerateNonRevProofUseCase>(
      () async => _i89.GenerateNonRevProofUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i70.CredentialRepository>(),
            get<_i73.GetEnvConfigUseCase>(),
            await get.getAsync<_i87.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i90.GetAuthTokenUseCase>(
      () async => _i90.GetAuthTokenUseCase(
            get<_i81.Iden3commRepository>(),
            get<_i78.ProofRepository>(),
            get<_i70.CredentialRepository>(),
            await get.getAsync<_i82.IdentityRepository>(),
          ));
  gh.factoryAsync<_i91.GetClaimRevocationStatusUseCase>(
      () async => _i91.GetClaimRevocationStatusUseCase(
            get<_i70.CredentialRepository>(),
            await get.getAsync<_i82.IdentityRepository>(),
            await get.getAsync<_i89.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i92.GetDidIdentifierUseCase>(() async =>
      _i92.GetDidIdentifierUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i93.GetIdentifierUseCase>(() async =>
      _i93.GetIdentifierUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i94.GetIdentityUseCase>(() async =>
      _i94.GetIdentityUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i95.Identity>(() async => _i95.Identity(
        await get.getAsync<_i86.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i94.GetIdentityUseCase>(),
        await get.getAsync<_i84.RemoveIdentityUseCase>(),
        await get.getAsync<_i93.GetIdentifierUseCase>(),
        await get.getAsync<_i85.SignMessageUseCase>(),
        await get.getAsync<_i87.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i96.FetchAndSaveClaimsUseCase>(
      () async => _i96.FetchAndSaveClaimsUseCase(
            get<_i18.GetFetchRequestsUseCase>(),
            await get.getAsync<_i90.GetAuthTokenUseCase>(),
            get<_i70.CredentialRepository>(),
          ));
  gh.factoryAsync<_i97.GenerateProofUseCase>(
      () async => _i97.GenerateProofUseCase(
            get<_i78.ProofRepository>(),
            get<_i70.CredentialRepository>(),
            await get.getAsync<_i91.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i98.GetProofsUseCase>(() async => _i98.GetProofsUseCase(
        get<_i78.ProofRepository>(),
        await get.getAsync<_i82.IdentityRepository>(),
        get<_i72.GetClaimsUseCase>(),
        await get.getAsync<_i97.GenerateProofUseCase>(),
        get<_i83.IsProofCircuitSupportedUseCase>(),
        get<_i22.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i99.Proof>(
      () async => _i99.Proof(await get.getAsync<_i97.GenerateProofUseCase>()));
  gh.factoryAsync<_i100.AuthenticateUseCase>(
      () async => _i100.AuthenticateUseCase(
            get<_i81.Iden3commRepository>(),
            await get.getAsync<_i98.GetProofsUseCase>(),
            await get.getAsync<_i90.GetAuthTokenUseCase>(),
            get<_i73.GetEnvConfigUseCase>(),
            await get.getAsync<_i67.GetPackageNameUseCase>(),
            await get.getAsync<_i92.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i101.Credential>(() async => _i101.Credential(
        await get.getAsync<_i96.FetchAndSaveClaimsUseCase>(),
        get<_i72.GetClaimsUseCase>(),
        get<_i79.RemoveClaimsUseCase>(),
        get<_i80.UpdateClaimUseCase>(),
        get<_i71.ExportClaimsUseCase>(),
        get<_i77.ImportClaimsUseCase>(),
      ));
  gh.factoryAsync<_i102.Iden3comm>(() async => _i102.Iden3comm(
        get<_i74.GetVocabsUseCase>(),
        await get.getAsync<_i100.AuthenticateUseCase>(),
        await get.getAsync<_i98.GetProofsUseCase>(),
        get<_i20.GetIden3MessageUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i103.PlatformModule {}

class _$NetworkModule extends _i103.NetworkModule {}

class _$DatabaseModule extends _i103.DatabaseModule {}

class _$EncryptionModule extends _i103.EncryptionModule {}

class _$Sdk extends _i103.Sdk {}

class _$RepositoriesModule extends _i103.RepositoriesModule {}
