// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i29;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i50;

import '../../common/data/data_sources/env_datasource.dart' as _i60;
import '../../common/data/data_sources/package_info_datasource.dart' as _i30;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i70;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i31;
import '../../common/domain/repositories/config_repository.dart' as _i74;
import '../../common/domain/repositories/package_info_repository.dart' as _i65;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i77;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i72;
import '../../credential/data/credential_repository_impl.dart' as _i71;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i41;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i58;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i57;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i15;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i44;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i75;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i100;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i94;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i78;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i82;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i83;
import '../../env/sdk_env.dart' as _i48;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i38;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i42;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i56;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i61;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i17;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i28;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i36;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i37;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i66;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i79;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i84;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i104;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i93;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i102;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i20;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i21;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i22;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i43;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i67;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i64;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i49;
import '../../identity/data/mappers/hex_mapper.dart' as _i14;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i19;
import '../../identity/data/mappers/private_key_mapper.dart' as _i32;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i68;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i45;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i80;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i46;
import '../../identity/domain/repositories/identity_repository.dart' as _i85;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i26;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i89;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i92;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i96;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i97;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i98;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i88;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i16;
import '../../identity/libs/smt/hash.dart' as _i47;
import '../../identity/libs/smt/merkletree.dart' as _i25;
import '../../identity/libs/smt/node.dart' as _i27;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i55;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i33;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i40;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i52;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i34;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i73;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i81;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i101;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i86;
import '../../proof_generation/libs/prover/prover.dart' as _i39;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i53;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i54;
import '../credential_wallet.dart' as _i105;
import '../iden3comm.dart' as _i106;
import '../identity_wallet.dart' as _i99;
import '../mappers/iden3_message_mapper.dart' as _i62;
import '../mappers/iden3_message_type_mapper.dart' as _i18;
import '../mappers/schema_info_mapper.dart' as _i69;
import '../proof_generation.dart' as _i103;
import 'injector.dart' as _i107; // ignore_for_file: unnecessary_lambdas

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
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final packageInfoModule = _$PackageInfoModule();
  final sdk = _$Sdk();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.AuthResponseMapper>(() => _i3.AuthResponseMapper());
  gh.factory<_i4.BabyjubjubLib>(() => _i4.BabyjubjubLib());
  gh.factory<_i5.CircuitTypeMapper>(() => _i5.CircuitTypeMapper());
  gh.factory<_i6.ClaimInfoMapper>(() => _i6.ClaimInfoMapper());
  gh.factory<_i7.ClaimStateMapper>(() => _i7.ClaimStateMapper());
  gh.factory<_i8.Client>(() => networkModule.client);
  gh.factory<_i9.ContractFuncCallMapper>(() => _i9.ContractFuncCallMapper());
  gh.factory<_i10.CredentialRequestMapper>(
      () => _i10.CredentialRequestMapper());
  gh.lazySingletonAsync<_i11.Database>(() => databaseModule.database());
  gh.factory<_i12.FilterMapper>(() => _i12.FilterMapper());
  gh.factory<_i13.FiltersMapper>(
      () => _i13.FiltersMapper(get<_i12.FilterMapper>()));
  gh.factory<_i14.HexMapper>(() => _i14.HexMapper());
  gh.factory<_i15.IdFilterMapper>(() => _i15.IdFilterMapper());
  gh.factory<_i16.Iden3CoreLib>(() => _i16.Iden3CoreLib());
  gh.factory<_i17.Iden3MessageTypeDataMapper>(
      () => _i17.Iden3MessageTypeDataMapper());
  gh.factory<_i18.Iden3MessageTypeMapper>(() => _i18.Iden3MessageTypeMapper());
  gh.factory<_i19.IdentityDTOMapper>(() => _i19.IdentityDTOMapper());
  gh.factory<_i20.JWZIsolatesWrapper>(() => _i20.JWZIsolatesWrapper());
  gh.factory<_i21.LibIdentityDataSource>(
      () => _i21.LibIdentityDataSource(get<_i16.Iden3CoreLib>()));
  gh.factory<_i22.LocalContractFilesDataSource>(
      () => _i22.LocalContractFilesDataSource());
  gh.factory<_i23.LocalIdentityDataSource>(
      () => _i23.LocalIdentityDataSource());
  gh.factory<_i24.LocalProofFilesDataSource>(
      () => _i24.LocalProofFilesDataSource());
  gh.factory<_i25.MerkleTree>(() => _i25.MerkleTree(
        get<_i16.Iden3CoreLib>(),
        get<_i26.SMTStorageRepository>(),
        get<int>(),
      ));
  gh.factory<_i27.Node>(() => _i27.Node(
        get<_i27.NodeType>(),
        get<_i16.Iden3CoreLib>(),
      ));
  gh.factory<_i28.OfferRequestMapper>(
      () => _i28.OfferRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i29.PackageInfo>(() => packageInfoModule.packageInfo);
  gh.factoryAsync<_i30.PackageInfoDataSource>(() async =>
      _i30.PackageInfoDataSource(await get.getAsync<_i29.PackageInfo>()));
  gh.factoryAsync<_i31.PackageInfoRepositoryImpl>(() async =>
      _i31.PackageInfoRepositoryImpl(
          await get.getAsync<_i30.PackageInfoDataSource>()));
  gh.factory<_i32.PrivateKeyMapper>(() => _i32.PrivateKeyMapper());
  gh.factory<_i33.ProofCircuitDataSource>(() => _i33.ProofCircuitDataSource());
  gh.factory<_i34.ProofMapper>(() => _i34.ProofMapper());
  gh.factory<_i35.ProofQueryMapper>(() => _i35.ProofQueryMapper());
  gh.factory<_i36.ProofQueryParamMapper>(() => _i36.ProofQueryParamMapper());
  gh.factory<_i37.ProofRequestFiltersMapper>(
      () => _i37.ProofRequestFiltersMapper(get<_i35.ProofQueryMapper>()));
  gh.factory<_i38.ProofScopeDataSource>(() => _i38.ProofScopeDataSource());
  gh.factory<_i39.ProverLib>(() => _i39.ProverLib());
  gh.factory<_i40.ProverLibWrapper>(() => _i40.ProverLibWrapper());
  gh.factory<_i41.RemoteClaimDataSource>(
      () => _i41.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i42.RemoteIden3commDataSource>(
      () => _i42.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i43.RemoteIdentityDataSource>(
      () => _i43.RemoteIdentityDataSource());
  gh.factory<_i44.RevocationStatusMapper>(() => _i44.RevocationStatusMapper());
  gh.factory<_i45.RhsNodeTypeMapper>(() => _i45.RhsNodeTypeMapper());
  gh.factory<_i46.SMTMemoryStorageRepositoryImpl>(
      () => _i46.SMTMemoryStorageRepositoryImpl(
            get<_i47.Hash>(),
            get<Map<_i47.Hash, _i27.Node>>(),
          ));
  gh.lazySingleton<_i48.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i49.WalletLibWrapper>(() => _i49.WalletLibWrapper());
  gh.factory<_i50.Web3Client>(
      () => networkModule.web3Client(get<_i48.SdkEnv>()));
  gh.factory<_i51.WitnessAuthLib>(() => _i51.WitnessAuthLib());
  gh.factory<_i52.WitnessIsolatesWrapper>(() => _i52.WitnessIsolatesWrapper());
  gh.factory<_i53.WitnessMtpLib>(() => _i53.WitnessMtpLib());
  gh.factory<_i54.WitnessSigLib>(() => _i54.WitnessSigLib());
  gh.factory<_i55.AtomicQueryInputsWrapper>(
      () => _i55.AtomicQueryInputsWrapper(get<_i16.Iden3CoreLib>()));
  gh.factory<_i56.AuthRequestMapper>(
      () => _i56.AuthRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i57.ClaimMapper>(() => _i57.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i58.ClaimStoreRefWrapper>(() => _i58.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i59.ContractRequestMapper>(
      () => _i59.ContractRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.EnvDataSource>(() => _i60.EnvDataSource(get<_i48.SdkEnv>()));
  gh.factory<_i61.FetchRequestMapper>(
      () => _i61.FetchRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i62.Iden3MessageMapper>(
      () => _i62.Iden3MessageMapper(get<_i18.Iden3MessageTypeMapper>()));
  gh.factory<_i63.IdentityStoreRefWrapper>(() => _i63.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i64.KeyValueStoreRefWrapper>(() => _i64.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i65.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i31.PackageInfoRepositoryImpl>()));
  gh.factory<_i66.ProofRequestsMapper>(() => _i66.ProofRequestsMapper(
        get<_i56.AuthRequestMapper>(),
        get<_i61.FetchRequestMapper>(),
        get<_i28.OfferRequestMapper>(),
        get<_i59.ContractRequestMapper>(),
        get<_i36.ProofQueryParamMapper>(),
      ));
  gh.factory<_i40.ProverLibDataSource>(
      () => _i40.ProverLibDataSource(get<_i40.ProverLibWrapper>()));
  gh.factory<_i67.RPCDataSource>(
      () => _i67.RPCDataSource(get<_i50.Web3Client>()));
  gh.factory<_i68.RhsNodeMapper>(
      () => _i68.RhsNodeMapper(get<_i45.RhsNodeTypeMapper>()));
  gh.factory<_i69.SchemaInfoMapper>(() => _i69.SchemaInfoMapper(
        get<_i56.AuthRequestMapper>(),
        get<_i59.ContractRequestMapper>(),
      ));
  gh.factoryAsync<_i58.StorageClaimDataSource>(
      () async => _i58.StorageClaimDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i58.ClaimStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i64.StorageKeyValueDataSource>(
      () async => _i64.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i64.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i49.WalletDataSource>(
      () => _i49.WalletDataSource(get<_i49.WalletLibWrapper>()));
  gh.factory<_i52.WitnessDataSource>(
      () => _i52.WitnessDataSource(get<_i52.WitnessIsolatesWrapper>()));
  gh.factory<_i55.AtomicQueryInputsDataSource>(() =>
      _i55.AtomicQueryInputsDataSource(get<_i55.AtomicQueryInputsWrapper>()));
  gh.factory<_i70.ConfigRepositoryImpl>(
      () => _i70.ConfigRepositoryImpl(get<_i60.EnvDataSource>()));
  gh.factoryAsync<_i71.CredentialRepositoryImpl>(
      () async => _i71.CredentialRepositoryImpl(
            get<_i41.RemoteClaimDataSource>(),
            await get.getAsync<_i58.StorageClaimDataSource>(),
            get<_i43.RemoteIdentityDataSource>(),
            get<_i10.CredentialRequestMapper>(),
            get<_i57.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i15.IdFilterMapper>(),
            get<_i44.RevocationStatusMapper>(),
          ));
  gh.factoryAsync<_i72.GetPackageNameUseCase>(() async =>
      _i72.GetPackageNameUseCase(
          await get.getAsync<_i65.PackageInfoRepository>()));
  gh.factory<_i20.JWZDataSource>(() => _i20.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i49.WalletDataSource>(),
        get<_i20.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i73.ProofRepositoryImpl>(() => _i73.ProofRepositoryImpl(
        get<_i52.WitnessDataSource>(),
        get<_i40.ProverLibDataSource>(),
        get<_i55.AtomicQueryInputsDataSource>(),
        get<_i24.LocalProofFilesDataSource>(),
        get<_i33.ProofCircuitDataSource>(),
        get<_i43.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i66.ProofRequestsMapper>(),
        get<_i37.ProofRequestFiltersMapper>(),
        get<_i34.ProofMapper>(),
        get<_i57.ClaimMapper>(),
        get<_i44.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i63.StorageIdentityDataSource>(
      () async => _i63.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i63.IdentityStoreRefWrapper>(),
            await get.getAsync<_i64.StorageKeyValueDataSource>(),
          ));
  gh.factory<_i74.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i70.ConfigRepositoryImpl>()));
  gh.factoryAsync<_i75.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i71.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i76.GetClaimsUseCase>(() async =>
      _i76.GetClaimsUseCase(await get.getAsync<_i75.CredentialRepository>()));
  gh.factory<_i77.GetEnvConfigUseCase>(
      () => _i77.GetEnvConfigUseCase(get<_i74.ConfigRepository>()));
  gh.factoryAsync<_i78.GetVocabsUseCase>(() async =>
      _i78.GetVocabsUseCase(await get.getAsync<_i75.CredentialRepository>()));
  gh.factoryAsync<_i79.Iden3commRepositoryImpl>(
      () async => _i79.Iden3commRepositoryImpl(
            get<_i42.RemoteIden3commDataSource>(),
            get<_i20.JWZDataSource>(),
            get<_i14.HexMapper>(),
            get<_i38.ProofScopeDataSource>(),
            await get.getAsync<_i58.StorageClaimDataSource>(),
            get<_i57.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i3.AuthResponseMapper>(),
            get<_i56.AuthRequestMapper>(),
          ));
  gh.factoryAsync<_i80.IdentityRepositoryImpl>(
      () async => _i80.IdentityRepositoryImpl(
            get<_i49.WalletDataSource>(),
            get<_i21.LibIdentityDataSource>(),
            get<_i23.LocalIdentityDataSource>(),
            get<_i43.RemoteIdentityDataSource>(),
            await get.getAsync<_i63.StorageIdentityDataSource>(),
            await get.getAsync<_i64.StorageKeyValueDataSource>(),
            get<_i67.RPCDataSource>(),
            get<_i22.LocalContractFilesDataSource>(),
            get<_i14.HexMapper>(),
            get<_i32.PrivateKeyMapper>(),
            get<_i19.IdentityDTOMapper>(),
            get<_i68.RhsNodeMapper>(),
          ));
  gh.factory<_i81.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i73.ProofRepositoryImpl>()));
  gh.factoryAsync<_i82.RemoveClaimsUseCase>(() async =>
      _i82.RemoveClaimsUseCase(
          await get.getAsync<_i75.CredentialRepository>()));
  gh.factoryAsync<_i83.UpdateClaimUseCase>(() async =>
      _i83.UpdateClaimUseCase(await get.getAsync<_i75.CredentialRepository>()));
  gh.factoryAsync<_i84.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i79.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i85.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i80.IdentityRepositoryImpl>()));
  gh.factory<_i86.IsProofCircuitSupportedUseCase>(
      () => _i86.IsProofCircuitSupportedUseCase(get<_i81.ProofRepository>()));
  gh.factoryAsync<_i87.RemoveCurrentIdentityUseCase>(() async =>
      _i87.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i88.SignMessageUseCase>(() async =>
      _i88.SignMessageUseCase(await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i89.CreateIdentityUseCase>(() async =>
      _i89.CreateIdentityUseCase(
          await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i90.FetchIdentityStateUseCase>(
      () async => _i90.FetchIdentityStateUseCase(
            await get.getAsync<_i85.IdentityRepository>(),
            get<_i77.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i91.FetchStateRootsUseCase>(() async =>
      _i91.FetchStateRootsUseCase(
          await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i92.GenerateNonRevProofUseCase>(
      () async => _i92.GenerateNonRevProofUseCase(
            await get.getAsync<_i85.IdentityRepository>(),
            await get.getAsync<_i75.CredentialRepository>(),
            get<_i77.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i93.GetAuthTokenUseCase>(
      () async => _i93.GetAuthTokenUseCase(
            await get.getAsync<_i84.Iden3commRepository>(),
            get<_i81.ProofRepository>(),
            await get.getAsync<_i85.IdentityRepository>(),
          ));
  gh.factoryAsync<_i94.GetClaimRevocationStatusUseCase>(
      () async => _i94.GetClaimRevocationStatusUseCase(
            await get.getAsync<_i75.CredentialRepository>(),
            await get.getAsync<_i85.IdentityRepository>(),
            await get.getAsync<_i92.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i95.GetCurrentIdentifierUseCase>(() async =>
      _i95.GetCurrentIdentifierUseCase(
          await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i96.GetDidIdentifierUseCase>(() async =>
      _i96.GetDidIdentifierUseCase(
          await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i97.GetIdentityUseCase>(() async =>
      _i97.GetIdentityUseCase(await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i98.GetPublicKeysUseCase>(() async =>
      _i98.GetPublicKeysUseCase(await get.getAsync<_i85.IdentityRepository>()));
  gh.factoryAsync<_i99.IdentityWallet>(() async => _i99.IdentityWallet(
        await get.getAsync<_i89.CreateIdentityUseCase>(),
        await get.getAsync<_i97.GetIdentityUseCase>(),
        await get.getAsync<_i88.SignMessageUseCase>(),
        await get.getAsync<_i95.GetCurrentIdentifierUseCase>(),
        await get.getAsync<_i87.RemoveCurrentIdentityUseCase>(),
        await get.getAsync<_i90.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i100.FetchAndSaveClaimsUseCase>(
      () async => _i100.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i93.GetAuthTokenUseCase>(),
            await get.getAsync<_i75.CredentialRepository>(),
          ));
  gh.factoryAsync<_i101.GenerateProofUseCase>(
      () async => _i101.GenerateProofUseCase(
            get<_i81.ProofRepository>(),
            await get.getAsync<_i75.CredentialRepository>(),
            await get.getAsync<_i94.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i102.GetProofsUseCase>(() async => _i102.GetProofsUseCase(
        get<_i81.ProofRepository>(),
        await get.getAsync<_i85.IdentityRepository>(),
        await get.getAsync<_i76.GetClaimsUseCase>(),
        await get.getAsync<_i101.GenerateProofUseCase>(),
        await get.getAsync<_i98.GetPublicKeysUseCase>(),
        get<_i86.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i103.ProofGeneration>(() async =>
      _i103.ProofGeneration(await get.getAsync<_i101.GenerateProofUseCase>()));
  gh.factoryAsync<_i104.AuthenticateUseCase>(
      () async => _i104.AuthenticateUseCase(
            await get.getAsync<_i84.Iden3commRepository>(),
            await get.getAsync<_i102.GetProofsUseCase>(),
            await get.getAsync<_i93.GetAuthTokenUseCase>(),
            get<_i77.GetEnvConfigUseCase>(),
            await get.getAsync<_i72.GetPackageNameUseCase>(),
            await get.getAsync<_i96.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i105.CredentialWallet>(() async => _i105.CredentialWallet(
        await get.getAsync<_i100.FetchAndSaveClaimsUseCase>(),
        await get.getAsync<_i76.GetClaimsUseCase>(),
        await get.getAsync<_i82.RemoveClaimsUseCase>(),
        await get.getAsync<_i83.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i106.Iden3comm>(() async => _i106.Iden3comm(
        await get.getAsync<_i78.GetVocabsUseCase>(),
        await get.getAsync<_i104.AuthenticateUseCase>(),
        await get.getAsync<_i102.GetProofsUseCase>(),
        get<_i62.Iden3MessageMapper>(),
        get<_i69.SchemaInfoMapper>(),
      ));
  return get;
}

class _$NetworkModule extends _i107.NetworkModule {}

class _$DatabaseModule extends _i107.DatabaseModule {}

class _$PackageInfoModule extends _i107.PackageInfoModule {}

class _$Sdk extends _i107.Sdk {}

class _$RepositoriesModule extends _i107.RepositoriesModule {}
