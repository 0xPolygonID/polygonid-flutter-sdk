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
import 'package:web3dart/web3dart.dart' as _i51;

import '../../common/data/data_sources/env_datasource.dart' as _i61;
import '../../common/data/data_sources/package_info_datasource.dart' as _i30;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i71;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i31;
import '../../common/domain/repositories/config_repository.dart' as _i75;
import '../../common/domain/repositories/package_info_repository.dart' as _i66;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i78;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i73;
import '../../credential/data/credential_repository_impl.dart' as _i72;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i42;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i59;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i58;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i15;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i45;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i76;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i98;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i94;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i77;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i79;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i83;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i84;
import '../../env/sdk_env.dart' as _i49;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i39;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i43;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i60;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i62;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i17;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i28;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i36;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i37;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i38;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i67;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i80;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i85;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i102;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i93;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i100;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i20;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i21;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i22;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i44;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i68;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i64;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i65;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i50;
import '../../identity/data/mappers/hex_mapper.dart' as _i14;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i19;
import '../../identity/data/mappers/private_identity_dto_mapper.dart' as _i32;
import '../../identity/data/mappers/private_key_mapper.dart' as _i33;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i69;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i46;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i81;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i47;
import '../../identity/domain/repositories/identity_repository.dart' as _i86;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i26;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i89;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i92;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i96;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i88;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i16;
import '../../identity/libs/smt/hash.dart' as _i48;
import '../../identity/libs/smt/merkletree.dart' as _i25;
import '../../identity/libs/smt/node.dart' as _i27;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i56;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i34;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i41;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i53;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i35;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i74;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i82;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i99;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i87;
import '../../proof_generation/libs/prover/prover.dart' as _i40;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i52;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i54;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i55;
import '../credential_wallet.dart' as _i103;
import '../iden3comm.dart' as _i104;
import '../identity_wallet.dart' as _i97;
import '../mappers/iden3_message_mapper.dart' as _i63;
import '../mappers/iden3_message_type_mapper.dart' as _i18;
import '../mappers/schema_info_mapper.dart' as _i70;
import '../proof_generation.dart' as _i101;
import 'injector.dart' as _i105; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i32.PrivateIdentityDTOMapper>(
      () => _i32.PrivateIdentityDTOMapper());
  gh.factory<_i33.PrivateKeyMapper>(() => _i33.PrivateKeyMapper());
  gh.factory<_i34.ProofCircuitDataSource>(() => _i34.ProofCircuitDataSource());
  gh.factory<_i35.ProofMapper>(() => _i35.ProofMapper());
  gh.factory<_i36.ProofQueryMapper>(() => _i36.ProofQueryMapper());
  gh.factory<_i37.ProofQueryParamMapper>(() => _i37.ProofQueryParamMapper());
  gh.factory<_i38.ProofRequestFiltersMapper>(
      () => _i38.ProofRequestFiltersMapper(get<_i36.ProofQueryMapper>()));
  gh.factory<_i39.ProofScopeDataSource>(() => _i39.ProofScopeDataSource());
  gh.factory<_i40.ProverLib>(() => _i40.ProverLib());
  gh.factory<_i41.ProverLibWrapper>(() => _i41.ProverLibWrapper());
  gh.factory<_i42.RemoteClaimDataSource>(
      () => _i42.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i43.RemoteIden3commDataSource>(
      () => _i43.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i44.RemoteIdentityDataSource>(
      () => _i44.RemoteIdentityDataSource());
  gh.factory<_i45.RevocationStatusMapper>(() => _i45.RevocationStatusMapper());
  gh.factory<_i46.RhsNodeTypeMapper>(() => _i46.RhsNodeTypeMapper());
  gh.factory<_i47.SMTMemoryStorageRepositoryImpl>(
      () => _i47.SMTMemoryStorageRepositoryImpl(
            get<_i48.Hash>(),
            get<Map<_i48.Hash, _i27.Node>>(),
          ));
  gh.lazySingleton<_i49.SdkEnv>(() => sdk.sdkEnv);
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
  gh.factory<_i50.WalletLibWrapper>(() => _i50.WalletLibWrapper());
  gh.factory<_i51.Web3Client>(
      () => networkModule.web3Client(get<_i49.SdkEnv>()));
  gh.factory<_i52.WitnessAuthLib>(() => _i52.WitnessAuthLib());
  gh.factory<_i53.WitnessIsolatesWrapper>(() => _i53.WitnessIsolatesWrapper());
  gh.factory<_i54.WitnessMtpLib>(() => _i54.WitnessMtpLib());
  gh.factory<_i55.WitnessSigLib>(() => _i55.WitnessSigLib());
  gh.factory<_i56.AtomicQueryInputsWrapper>(
      () => _i56.AtomicQueryInputsWrapper(get<_i16.Iden3CoreLib>()));
  gh.factory<_i57.AuthRequestMapper>(
      () => _i57.AuthRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.ClaimMapper>(() => _i58.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i59.ClaimStoreRefWrapper>(() => _i59.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i60.ContractRequestMapper>(
      () => _i60.ContractRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i61.EnvDataSource>(() => _i61.EnvDataSource(get<_i49.SdkEnv>()));
  gh.factory<_i62.FetchRequestMapper>(
      () => _i62.FetchRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i63.Iden3MessageMapper>(
      () => _i63.Iden3MessageMapper(get<_i18.Iden3MessageTypeMapper>()));
  gh.factory<_i64.IdentityStoreRefWrapper>(() => _i64.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i65.KeyValueStoreRefWrapper>(() => _i65.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i66.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i31.PackageInfoRepositoryImpl>()));
  gh.factory<_i67.ProofRequestsMapper>(() => _i67.ProofRequestsMapper(
        get<_i57.AuthRequestMapper>(),
        get<_i62.FetchRequestMapper>(),
        get<_i28.OfferRequestMapper>(),
        get<_i60.ContractRequestMapper>(),
        get<_i37.ProofQueryParamMapper>(),
      ));
  gh.factory<_i41.ProverLibDataSource>(
      () => _i41.ProverLibDataSource(get<_i41.ProverLibWrapper>()));
  gh.factory<_i68.RPCDataSource>(
      () => _i68.RPCDataSource(get<_i51.Web3Client>()));
  gh.factory<_i69.RhsNodeMapper>(
      () => _i69.RhsNodeMapper(get<_i46.RhsNodeTypeMapper>()));
  gh.factory<_i70.SchemaInfoMapper>(() => _i70.SchemaInfoMapper(
        get<_i57.AuthRequestMapper>(),
        get<_i60.ContractRequestMapper>(),
      ));
  gh.factory<_i59.StorageClaimDataSource>(
      () => _i59.StorageClaimDataSource(get<_i59.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i65.StorageKeyValueDataSource>(
      () async => _i65.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i65.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i50.WalletDataSource>(
      () => _i50.WalletDataSource(get<_i50.WalletLibWrapper>()));
  gh.factory<_i53.WitnessDataSource>(
      () => _i53.WitnessDataSource(get<_i53.WitnessIsolatesWrapper>()));
  gh.factory<_i56.AtomicQueryInputsDataSource>(() =>
      _i56.AtomicQueryInputsDataSource(get<_i56.AtomicQueryInputsWrapper>()));
  gh.factory<_i71.ConfigRepositoryImpl>(
      () => _i71.ConfigRepositoryImpl(get<_i61.EnvDataSource>()));
  gh.factory<_i72.CredentialRepositoryImpl>(() => _i72.CredentialRepositoryImpl(
        get<_i42.RemoteClaimDataSource>(),
        get<_i59.StorageClaimDataSource>(),
        get<_i44.RemoteIdentityDataSource>(),
        get<_i10.CredentialRequestMapper>(),
        get<_i58.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i15.IdFilterMapper>(),
        get<_i45.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i73.GetPackageNameUseCase>(() async =>
      _i73.GetPackageNameUseCase(
          await get.getAsync<_i66.PackageInfoRepository>()));
  gh.factory<_i20.JWZDataSource>(() => _i20.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i50.WalletDataSource>(),
        get<_i20.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i74.ProofRepositoryImpl>(() => _i74.ProofRepositoryImpl(
        get<_i53.WitnessDataSource>(),
        get<_i41.ProverLibDataSource>(),
        get<_i56.AtomicQueryInputsDataSource>(),
        get<_i24.LocalProofFilesDataSource>(),
        get<_i34.ProofCircuitDataSource>(),
        get<_i44.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i67.ProofRequestsMapper>(),
        get<_i38.ProofRequestFiltersMapper>(),
        get<_i35.ProofMapper>(),
        get<_i58.ClaimMapper>(),
        get<_i45.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i64.StorageIdentityDataSource>(
      () async => _i64.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i64.IdentityStoreRefWrapper>(),
            await get.getAsync<_i65.StorageKeyValueDataSource>(),
            get<_i50.WalletDataSource>(),
            get<_i21.LibIdentityDataSource>(),
            get<_i33.PrivateKeyMapper>(),
          ));
  gh.factory<_i75.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i71.ConfigRepositoryImpl>()));
  gh.factory<_i76.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i72.CredentialRepositoryImpl>()));
  gh.factory<_i77.GetClaimsUseCase>(
      () => _i77.GetClaimsUseCase(get<_i76.CredentialRepository>()));
  gh.factory<_i78.GetEnvConfigUseCase>(
      () => _i78.GetEnvConfigUseCase(get<_i75.ConfigRepository>()));
  gh.factory<_i79.GetVocabsUseCase>(
      () => _i79.GetVocabsUseCase(get<_i76.CredentialRepository>()));
  gh.factory<_i80.Iden3commRepositoryImpl>(() => _i80.Iden3commRepositoryImpl(
        get<_i43.RemoteIden3commDataSource>(),
        get<_i20.JWZDataSource>(),
        get<_i14.HexMapper>(),
        get<_i39.ProofScopeDataSource>(),
        get<_i59.StorageClaimDataSource>(),
        get<_i58.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i3.AuthResponseMapper>(),
        get<_i57.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i81.IdentityRepositoryImpl>(
      () async => _i81.IdentityRepositoryImpl(
            get<_i50.WalletDataSource>(),
            get<_i21.LibIdentityDataSource>(),
            get<_i23.LocalIdentityDataSource>(),
            get<_i44.RemoteIdentityDataSource>(),
            await get.getAsync<_i64.StorageIdentityDataSource>(),
            await get.getAsync<_i65.StorageKeyValueDataSource>(),
            get<_i68.RPCDataSource>(),
            get<_i22.LocalContractFilesDataSource>(),
            get<_i14.HexMapper>(),
            get<_i33.PrivateKeyMapper>(),
            get<_i19.IdentityDTOMapper>(),
            get<_i32.PrivateIdentityDTOMapper>(),
            get<_i69.RhsNodeMapper>(),
          ));
  gh.factory<_i82.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i74.ProofRepositoryImpl>()));
  gh.factory<_i83.RemoveClaimsUseCase>(
      () => _i83.RemoveClaimsUseCase(get<_i76.CredentialRepository>()));
  gh.factory<_i84.UpdateClaimUseCase>(
      () => _i84.UpdateClaimUseCase(get<_i76.CredentialRepository>()));
  gh.factory<_i85.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i80.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i86.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i81.IdentityRepositoryImpl>()));
  gh.factory<_i87.IsProofCircuitSupportedUseCase>(
      () => _i87.IsProofCircuitSupportedUseCase(get<_i82.ProofRepository>()));
  gh.factoryAsync<_i88.SignMessageUseCase>(() async =>
      _i88.SignMessageUseCase(await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i89.CreateIdentityUseCase>(() async =>
      _i89.CreateIdentityUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i90.FetchIdentityStateUseCase>(
      () async => _i90.FetchIdentityStateUseCase(
            await get.getAsync<_i86.IdentityRepository>(),
            get<_i78.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i91.FetchStateRootsUseCase>(() async =>
      _i91.FetchStateRootsUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i92.GenerateNonRevProofUseCase>(
      () async => _i92.GenerateNonRevProofUseCase(
            await get.getAsync<_i86.IdentityRepository>(),
            get<_i76.CredentialRepository>(),
            get<_i78.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i93.GetAuthTokenUseCase>(
      () async => _i93.GetAuthTokenUseCase(
            get<_i85.Iden3commRepository>(),
            get<_i82.ProofRepository>(),
            await get.getAsync<_i86.IdentityRepository>(),
          ));
  gh.factoryAsync<_i94.GetClaimRevocationStatusUseCase>(
      () async => _i94.GetClaimRevocationStatusUseCase(
            get<_i76.CredentialRepository>(),
            await get.getAsync<_i86.IdentityRepository>(),
            await get.getAsync<_i92.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i95.GetDidIdentifierUseCase>(() async =>
      _i95.GetDidIdentifierUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i96.GetIdentityUseCase>(() async =>
      _i96.GetIdentityUseCase(await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i97.IdentityWallet>(() async => _i97.IdentityWallet(
        await get.getAsync<_i89.CreateIdentityUseCase>(),
        await get.getAsync<_i96.GetIdentityUseCase>(),
        await get.getAsync<_i88.SignMessageUseCase>(),
        await get.getAsync<_i90.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i98.FetchAndSaveClaimsUseCase>(
      () async => _i98.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i93.GetAuthTokenUseCase>(),
            get<_i76.CredentialRepository>(),
          ));
  gh.factoryAsync<_i99.GenerateProofUseCase>(
      () async => _i99.GenerateProofUseCase(
            get<_i82.ProofRepository>(),
            get<_i76.CredentialRepository>(),
            await get.getAsync<_i94.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i100.GetProofsUseCase>(() async => _i100.GetProofsUseCase(
        get<_i82.ProofRepository>(),
        await get.getAsync<_i86.IdentityRepository>(),
        get<_i77.GetClaimsUseCase>(),
        await get.getAsync<_i99.GenerateProofUseCase>(),
        get<_i87.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i101.ProofGeneration>(() async =>
      _i101.ProofGeneration(await get.getAsync<_i99.GenerateProofUseCase>()));
  gh.factoryAsync<_i102.AuthenticateUseCase>(
      () async => _i102.AuthenticateUseCase(
            get<_i85.Iden3commRepository>(),
            await get.getAsync<_i100.GetProofsUseCase>(),
            await get.getAsync<_i93.GetAuthTokenUseCase>(),
            get<_i78.GetEnvConfigUseCase>(),
            await get.getAsync<_i73.GetPackageNameUseCase>(),
            await get.getAsync<_i95.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i103.CredentialWallet>(() async => _i103.CredentialWallet(
        await get.getAsync<_i98.FetchAndSaveClaimsUseCase>(),
        get<_i77.GetClaimsUseCase>(),
        get<_i83.RemoveClaimsUseCase>(),
        get<_i84.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i104.Iden3comm>(() async => _i104.Iden3comm(
        get<_i79.GetVocabsUseCase>(),
        await get.getAsync<_i102.AuthenticateUseCase>(),
        await get.getAsync<_i100.GetProofsUseCase>(),
        get<_i63.Iden3MessageMapper>(),
        get<_i70.SchemaInfoMapper>(),
      ));
  return get;
}

class _$NetworkModule extends _i105.NetworkModule {}

class _$DatabaseModule extends _i105.DatabaseModule {}

class _$PackageInfoModule extends _i105.PackageInfoModule {}

class _$Sdk extends _i105.Sdk {}

class _$RepositoriesModule extends _i105.RepositoriesModule {}
