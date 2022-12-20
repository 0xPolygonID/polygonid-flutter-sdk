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
import 'package:package_info_plus/package_info_plus.dart' as _i33;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i50;

import '../../common/data/data_sources/env_datasource.dart' as _i58;
import '../../common/data/data_sources/package_info_datasource.dart' as _i34;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i64;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i35;
import '../../common/domain/repositories/config_repository.dart' as _i68;
import '../../common/domain/repositories/package_info_repository.dart' as _i61;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i72;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i66;
import '../../credential/data/credential_repository_impl.dart' as _i65;
import '../../credential/data/data_sources/db_destination_path_data_source.dart'
    as _i10;
import '../../credential/data/data_sources/encryption_db_data_source.dart'
    as _i14;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i42;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i57;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i56;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/encryption_key_mapper.dart' as _i15;
import '../../credential/data/mappers/filter_mapper.dart' as _i16;
import '../../credential/data/mappers/filters_mapper.dart' as _i17;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i24;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i45;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i69;
import '../../credential/domain/use_cases/export_claims_use_case.dart' as _i70;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i95;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i90;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i71;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i18;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i73;
import '../../credential/domain/use_cases/import_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i78;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i79;
import '../../env/sdk_env.dart' as _i47;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i43;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i39;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i74;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i80;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i99;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i89;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i19;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i21;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i22;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i97;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i28;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i29;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i30;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i44;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i62;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i59;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i49;
import '../../identity/data/mappers/did_mapper.dart' as _i12;
import '../../identity/data/mappers/hex_mapper.dart' as _i23;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i27;
import '../../identity/data/mappers/private_key_mapper.dart' as _i36;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i63;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i46;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i48;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i75;
import '../../identity/domain/repositories/identity_repository.dart' as _i81;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i85;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i86;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i92;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i93;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i83;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i84;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i25;
import '../../identity/libs/smt/node.dart' as _i32;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i55;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i31;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i37;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i41;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i52;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i38;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i67;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i77;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i96;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i82;
import '../../proof_generation/libs/prover/prover.dart' as _i40;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i53;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i54;
import '../credential.dart' as _i100;
import '../iden3comm.dart' as _i101;
import '../identity.dart' as _i94;
import '../mappers/iden3_message_type_mapper.dart' as _i26;
import '../proof.dart' as _i98;
import 'injector.dart' as _i102; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i28.JWZIsolatesWrapper>(() => _i28.JWZIsolatesWrapper());
  gh.factory<_i29.LibIdentityDataSource>(
      () => _i29.LibIdentityDataSource(get<_i25.Iden3CoreLib>()));
  gh.factory<_i30.LocalContractFilesDataSource>(
      () => _i30.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i31.LocalProofFilesDataSource>(
      () => _i31.LocalProofFilesDataSource());
  gh.factory<_i32.Node>(() => _i32.Node(
        get<_i32.NodeType>(),
        get<_i25.Iden3CoreLib>(),
      ));
  gh.lazySingletonAsync<_i33.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i34.PackageInfoDataSource>(() async =>
      _i34.PackageInfoDataSource(await get.getAsync<_i33.PackageInfo>()));
  gh.factoryAsync<_i35.PackageInfoRepositoryImpl>(() async =>
      _i35.PackageInfoRepositoryImpl(
          await get.getAsync<_i34.PackageInfoDataSource>()));
  gh.factory<_i36.PrivateKeyMapper>(() => _i36.PrivateKeyMapper());
  gh.factory<_i37.ProofCircuitDataSource>(() => _i37.ProofCircuitDataSource());
  gh.factory<_i38.ProofMapper>(() => _i38.ProofMapper());
  gh.factory<_i39.ProofRequestFiltersMapper>(
      () => _i39.ProofRequestFiltersMapper());
  gh.factory<_i40.ProverLib>(() => _i40.ProverLib());
  gh.factory<_i41.ProverLibWrapper>(() => _i41.ProverLibWrapper());
  gh.factory<_i42.RemoteClaimDataSource>(
      () => _i42.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i43.RemoteIden3commDataSource>(
      () => _i43.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i44.RemoteIdentityDataSource>(
      () => _i44.RemoteIdentityDataSource());
  gh.factory<_i45.RevocationStatusMapper>(() => _i45.RevocationStatusMapper());
  gh.factory<_i46.RhsNodeTypeMapper>(() => _i46.RhsNodeTypeMapper());
  gh.lazySingleton<_i47.SdkEnv>(() => sdk.sdkEnv);
  gh.factoryParam<_i11.SembastCodec, String, dynamic>((
    privateKey,
    _,
  ) =>
      databaseModule.getCodec(privateKey));
  gh.factory<_i48.StateIdentifierMapper>(() => _i48.StateIdentifierMapper());
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i11.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i49.WalletLibWrapper>(() => _i49.WalletLibWrapper());
  gh.factory<_i50.Web3Client>(
      () => networkModule.web3Client(get<_i47.SdkEnv>()));
  gh.factory<_i51.WitnessAuthLib>(() => _i51.WitnessAuthLib());
  gh.factory<_i52.WitnessIsolatesWrapper>(() => _i52.WitnessIsolatesWrapper());
  gh.factory<_i53.WitnessMtpLib>(() => _i53.WitnessMtpLib());
  gh.factory<_i54.WitnessSigLib>(() => _i54.WitnessSigLib());
  gh.factory<_i55.AtomicQueryInputsWrapper>(
      () => _i55.AtomicQueryInputsWrapper(get<_i25.Iden3CoreLib>()));
  gh.factory<_i56.ClaimMapper>(() => _i56.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i57.ClaimStoreRefWrapper>(() => _i57.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i58.EnvDataSource>(() => _i58.EnvDataSource(get<_i47.SdkEnv>()));
  gh.factory<_i59.IdentityStoreRefWrapper>(() => _i59.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i60.KeyValueStoreRefWrapper>(() => _i60.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i61.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i35.PackageInfoRepositoryImpl>()));
  gh.factory<_i41.ProverLibDataSource>(
      () => _i41.ProverLibDataSource(get<_i41.ProverLibWrapper>()));
  gh.factory<_i62.RPCDataSource>(
      () => _i62.RPCDataSource(get<_i50.Web3Client>()));
  gh.factory<_i63.RhsNodeMapper>(
      () => _i63.RhsNodeMapper(get<_i46.RhsNodeTypeMapper>()));
  gh.factory<_i57.StorageClaimDataSource>(
      () => _i57.StorageClaimDataSource(get<_i57.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i60.StorageKeyValueDataSource>(
      () async => _i60.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i60.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i49.WalletDataSource>(
      () => _i49.WalletDataSource(get<_i49.WalletLibWrapper>()));
  gh.factory<_i52.WitnessDataSource>(
      () => _i52.WitnessDataSource(get<_i52.WitnessIsolatesWrapper>()));
  gh.factory<_i55.AtomicQueryInputsDataSource>(() =>
      _i55.AtomicQueryInputsDataSource(get<_i55.AtomicQueryInputsWrapper>()));
  gh.factory<_i64.ConfigRepositoryImpl>(
      () => _i64.ConfigRepositoryImpl(get<_i58.EnvDataSource>()));
  gh.factory<_i65.CredentialRepositoryImpl>(() => _i65.CredentialRepositoryImpl(
        get<_i42.RemoteClaimDataSource>(),
        get<_i57.StorageClaimDataSource>(),
        get<_i29.LibIdentityDataSource>(),
        get<_i56.ClaimMapper>(),
        get<_i17.FiltersMapper>(),
        get<_i24.IdFilterMapper>(),
        get<_i45.RevocationStatusMapper>(),
        get<_i14.EncryptionDbDataSource>(),
        get<_i10.DestinationPathDataSource>(),
        get<_i15.EncryptionKeyMapper>(),
      ));
  gh.factoryAsync<_i66.GetPackageNameUseCase>(() async =>
      _i66.GetPackageNameUseCase(
          await get.getAsync<_i61.PackageInfoRepository>()));
  gh.factory<_i28.JWZDataSource>(() => _i28.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i49.WalletDataSource>(),
        get<_i28.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i67.ProofRepositoryImpl>(() => _i67.ProofRepositoryImpl(
        get<_i52.WitnessDataSource>(),
        get<_i41.ProverLibDataSource>(),
        get<_i55.AtomicQueryInputsDataSource>(),
        get<_i31.LocalProofFilesDataSource>(),
        get<_i37.ProofCircuitDataSource>(),
        get<_i44.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i39.ProofRequestFiltersMapper>(),
        get<_i38.ProofMapper>(),
        get<_i56.ClaimMapper>(),
        get<_i45.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i59.StorageIdentityDataSource>(
      () async => _i59.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i59.IdentityStoreRefWrapper>(),
            await get.getAsync<_i60.StorageKeyValueDataSource>(),
            get<_i49.WalletDataSource>(),
            get<_i23.HexMapper>(),
          ));
  gh.factory<_i68.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i64.ConfigRepositoryImpl>()));
  gh.factory<_i69.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i65.CredentialRepositoryImpl>()));
  gh.factory<_i70.ExportClaimsUseCase>(
      () => _i70.ExportClaimsUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i71.GetClaimsUseCase>(
      () => _i71.GetClaimsUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i72.GetEnvConfigUseCase>(
      () => _i72.GetEnvConfigUseCase(get<_i68.ConfigRepository>()));
  gh.factory<_i73.GetVocabsUseCase>(
      () => _i73.GetVocabsUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i74.Iden3commRepositoryImpl>(() => _i74.Iden3commRepositoryImpl(
        get<_i43.RemoteIden3commDataSource>(),
        get<_i28.JWZDataSource>(),
        get<_i23.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i75.IdentityRepositoryImpl>(
      () async => _i75.IdentityRepositoryImpl(
            get<_i49.WalletDataSource>(),
            get<_i29.LibIdentityDataSource>(),
            get<_i44.RemoteIdentityDataSource>(),
            await get.getAsync<_i59.StorageIdentityDataSource>(),
            get<_i62.RPCDataSource>(),
            get<_i30.LocalContractFilesDataSource>(),
            get<_i23.HexMapper>(),
            get<_i36.PrivateKeyMapper>(),
            get<_i27.IdentityDTOMapper>(),
            get<_i63.RhsNodeMapper>(),
            get<_i48.StateIdentifierMapper>(),
            get<_i12.DidMapper>(),
          ));
  gh.factory<_i76.ImportClaimsUseCase>(
      () => _i76.ImportClaimsUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i77.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i67.ProofRepositoryImpl>()));
  gh.factory<_i78.RemoveClaimsUseCase>(
      () => _i78.RemoveClaimsUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i79.UpdateClaimUseCase>(
      () => _i79.UpdateClaimUseCase(get<_i69.CredentialRepository>()));
  gh.factory<_i80.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i74.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i81.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i75.IdentityRepositoryImpl>()));
  gh.factory<_i82.IsProofCircuitSupportedUseCase>(
      () => _i82.IsProofCircuitSupportedUseCase(get<_i77.ProofRepository>()));
  gh.factoryAsync<_i83.RemoveIdentityUseCase>(() async =>
      _i83.RemoveIdentityUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i84.SignMessageUseCase>(() async =>
      _i84.SignMessageUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i85.CreateAndSaveIdentityUseCase>(
      () async => _i85.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i81.IdentityRepository>(),
            get<_i72.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i86.FetchIdentityStateUseCase>(
      () async => _i86.FetchIdentityStateUseCase(
            await get.getAsync<_i81.IdentityRepository>(),
            get<_i72.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i87.FetchStateRootsUseCase>(() async =>
      _i87.FetchStateRootsUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i88.GenerateNonRevProofUseCase>(
      () async => _i88.GenerateNonRevProofUseCase(
            await get.getAsync<_i81.IdentityRepository>(),
            get<_i69.CredentialRepository>(),
            get<_i72.GetEnvConfigUseCase>(),
            await get.getAsync<_i86.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i89.GetAuthTokenUseCase>(
      () async => _i89.GetAuthTokenUseCase(
            get<_i80.Iden3commRepository>(),
            get<_i77.ProofRepository>(),
            get<_i69.CredentialRepository>(),
            await get.getAsync<_i81.IdentityRepository>(),
          ));
  gh.factoryAsync<_i90.GetClaimRevocationStatusUseCase>(
      () async => _i90.GetClaimRevocationStatusUseCase(
            get<_i69.CredentialRepository>(),
            await get.getAsync<_i81.IdentityRepository>(),
            await get.getAsync<_i88.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i91.GetDidIdentifierUseCase>(() async =>
      _i91.GetDidIdentifierUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i92.GetIdentifierUseCase>(() async =>
      _i92.GetIdentifierUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i93.GetIdentityUseCase>(() async =>
      _i93.GetIdentityUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i94.Identity>(() async => _i94.Identity(
        await get.getAsync<_i85.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i93.GetIdentityUseCase>(),
        await get.getAsync<_i83.RemoveIdentityUseCase>(),
        await get.getAsync<_i92.GetIdentifierUseCase>(),
        await get.getAsync<_i84.SignMessageUseCase>(),
        await get.getAsync<_i86.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i95.FetchAndSaveClaimsUseCase>(
      () async => _i95.FetchAndSaveClaimsUseCase(
            get<_i18.GetFetchRequestsUseCase>(),
            await get.getAsync<_i89.GetAuthTokenUseCase>(),
            get<_i69.CredentialRepository>(),
          ));
  gh.factoryAsync<_i96.GenerateProofUseCase>(
      () async => _i96.GenerateProofUseCase(
            get<_i77.ProofRepository>(),
            get<_i69.CredentialRepository>(),
            await get.getAsync<_i90.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i97.GetProofsUseCase>(() async => _i97.GetProofsUseCase(
        get<_i77.ProofRepository>(),
        await get.getAsync<_i81.IdentityRepository>(),
        get<_i71.GetClaimsUseCase>(),
        await get.getAsync<_i96.GenerateProofUseCase>(),
        get<_i82.IsProofCircuitSupportedUseCase>(),
        get<_i22.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i98.Proof>(
      () async => _i98.Proof(await get.getAsync<_i96.GenerateProofUseCase>()));
  gh.factoryAsync<_i99.AuthenticateUseCase>(
      () async => _i99.AuthenticateUseCase(
            get<_i80.Iden3commRepository>(),
            await get.getAsync<_i97.GetProofsUseCase>(),
            await get.getAsync<_i89.GetAuthTokenUseCase>(),
            get<_i72.GetEnvConfigUseCase>(),
            await get.getAsync<_i66.GetPackageNameUseCase>(),
            await get.getAsync<_i91.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i100.Credential>(() async => _i100.Credential(
        await get.getAsync<_i95.FetchAndSaveClaimsUseCase>(),
        get<_i71.GetClaimsUseCase>(),
        get<_i78.RemoveClaimsUseCase>(),
        get<_i79.UpdateClaimUseCase>(),
        get<_i70.ExportClaimsUseCase>(),
        get<_i76.ImportClaimsUseCase>(),
      ));
  gh.factoryAsync<_i101.Iden3comm>(() async => _i101.Iden3comm(
        get<_i73.GetVocabsUseCase>(),
        await get.getAsync<_i99.AuthenticateUseCase>(),
        await get.getAsync<_i97.GetProofsUseCase>(),
        get<_i20.GetIden3MessageUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i102.PlatformModule {}

class _$NetworkModule extends _i102.NetworkModule {}

class _$DatabaseModule extends _i102.DatabaseModule {}

class _$EncryptionModule extends _i102.EncryptionModule {}

class _$Sdk extends _i102.Sdk {}

class _$RepositoriesModule extends _i102.RepositoriesModule {}
