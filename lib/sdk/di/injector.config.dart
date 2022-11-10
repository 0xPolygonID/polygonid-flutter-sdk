// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i27;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i46;

import '../../common/data/data_sources/env_datasource.dart' as _i56;
import '../../common/data/data_sources/package_info_datasource.dart' as _i28;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i66;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i29;
import '../../common/domain/repositories/config_repository.dart' as _i70;
import '../../common/domain/repositories/package_info_repository.dart' as _i61;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i73;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i68;
import '../../credential/data/credential_repository_impl.dart' as _i67;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i39;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i54;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i53;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i15;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i42;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i71;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i96;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i91;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i72;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i74;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i78;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i79;
import '../../env/sdk_env.dart' as _i44;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i36;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i40;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i52;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i55;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i17;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i26;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i62;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i75;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i80;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i100;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i90;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i98;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i20;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i21;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i22;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i41;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i63;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i59;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i45;
import '../../identity/data/mappers/hex_mapper.dart' as _i14;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i19;
import '../../identity/data/mappers/private_key_mapper.dart' as _i30;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i64;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i43;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i76;
import '../../identity/domain/repositories/identity_repository.dart' as _i81;
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
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i83;
import '../../identity/domain/use_cases/replace_identity_use_case.dart' as _i84;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i85;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i16;
import '../../identity/libs/smt/node.dart' as _i25;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i51;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i31;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i38;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i48;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i32;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i69;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i77;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i97;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i82;
import '../../proof_generation/libs/prover/prover.dart' as _i37;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i47;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i50;
import '../credential_wallet.dart' as _i101;
import '../iden3comm.dart' as _i102;
import '../identity_wallet.dart' as _i95;
import '../mappers/iden3_message_mapper.dart' as _i58;
import '../mappers/iden3_message_type_mapper.dart' as _i18;
import '../mappers/schema_info_mapper.dart' as _i65;
import '../proof_generation.dart' as _i99;
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
  gh.factory<_i25.Node>(() => _i25.Node(
        get<_i25.NodeType>(),
        get<_i16.Iden3CoreLib>(),
      ));
  gh.factory<_i26.OfferRequestMapper>(
      () => _i26.OfferRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i27.PackageInfo>(() => packageInfoModule.packageInfo);
  gh.factoryAsync<_i28.PackageInfoDataSource>(() async =>
      _i28.PackageInfoDataSource(await get.getAsync<_i27.PackageInfo>()));
  gh.factoryAsync<_i29.PackageInfoRepositoryImpl>(() async =>
      _i29.PackageInfoRepositoryImpl(
          await get.getAsync<_i28.PackageInfoDataSource>()));
  gh.factory<_i30.PrivateKeyMapper>(() => _i30.PrivateKeyMapper());
  gh.factory<_i31.ProofCircuitDataSource>(() => _i31.ProofCircuitDataSource());
  gh.factory<_i32.ProofMapper>(() => _i32.ProofMapper());
  gh.factory<_i33.ProofQueryMapper>(() => _i33.ProofQueryMapper());
  gh.factory<_i34.ProofQueryParamMapper>(() => _i34.ProofQueryParamMapper());
  gh.factory<_i35.ProofRequestFiltersMapper>(
      () => _i35.ProofRequestFiltersMapper(get<_i33.ProofQueryMapper>()));
  gh.factory<_i36.ProofScopeDataSource>(() => _i36.ProofScopeDataSource());
  gh.factory<_i37.ProverLib>(() => _i37.ProverLib());
  gh.factory<_i38.ProverLibWrapper>(() => _i38.ProverLibWrapper());
  gh.factory<_i39.RemoteClaimDataSource>(
      () => _i39.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i40.RemoteIden3commDataSource>(
      () => _i40.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i41.RemoteIdentityDataSource>(
      () => _i41.RemoteIdentityDataSource());
  gh.factory<_i42.RevocationStatusMapper>(() => _i42.RevocationStatusMapper());
  gh.factory<_i43.RhsNodeTypeMapper>(() => _i43.RhsNodeTypeMapper());
  gh.lazySingleton<_i44.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i45.WalletLibWrapper>(() => _i45.WalletLibWrapper());
  gh.factory<_i46.Web3Client>(
      () => networkModule.web3Client(get<_i44.SdkEnv>()));
  gh.factory<_i47.WitnessAuthLib>(() => _i47.WitnessAuthLib());
  gh.factory<_i48.WitnessIsolatesWrapper>(() => _i48.WitnessIsolatesWrapper());
  gh.factory<_i49.WitnessMtpLib>(() => _i49.WitnessMtpLib());
  gh.factory<_i50.WitnessSigLib>(() => _i50.WitnessSigLib());
  gh.factory<_i51.AtomicQueryInputsWrapper>(
      () => _i51.AtomicQueryInputsWrapper(get<_i16.Iden3CoreLib>()));
  gh.factory<_i52.AuthRequestMapper>(
      () => _i52.AuthRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i53.ClaimMapper>(() => _i53.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i54.ClaimStoreRefWrapper>(() => _i54.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i55.ContractRequestMapper>(
      () => _i55.ContractRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i56.EnvDataSource>(() => _i56.EnvDataSource(get<_i44.SdkEnv>()));
  gh.factory<_i57.FetchRequestMapper>(
      () => _i57.FetchRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.Iden3MessageMapper>(
      () => _i58.Iden3MessageMapper(get<_i18.Iden3MessageTypeMapper>()));
  gh.factory<_i59.IdentityStoreRefWrapper>(() => _i59.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i60.KeyValueStoreRefWrapper>(() => _i60.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i61.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i29.PackageInfoRepositoryImpl>()));
  gh.factory<_i62.ProofRequestsMapper>(() => _i62.ProofRequestsMapper(
        get<_i52.AuthRequestMapper>(),
        get<_i57.FetchRequestMapper>(),
        get<_i26.OfferRequestMapper>(),
        get<_i55.ContractRequestMapper>(),
        get<_i34.ProofQueryParamMapper>(),
      ));
  gh.factory<_i38.ProverLibDataSource>(
      () => _i38.ProverLibDataSource(get<_i38.ProverLibWrapper>()));
  gh.factory<_i63.RPCDataSource>(
      () => _i63.RPCDataSource(get<_i46.Web3Client>()));
  gh.factory<_i64.RhsNodeMapper>(
      () => _i64.RhsNodeMapper(get<_i43.RhsNodeTypeMapper>()));
  gh.factory<_i65.SchemaInfoMapper>(() => _i65.SchemaInfoMapper(
        get<_i52.AuthRequestMapper>(),
        get<_i55.ContractRequestMapper>(),
      ));
  gh.factory<_i54.StorageClaimDataSource>(
      () => _i54.StorageClaimDataSource(get<_i54.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i60.StorageKeyValueDataSource>(
      () async => _i60.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i60.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i45.WalletDataSource>(
      () => _i45.WalletDataSource(get<_i45.WalletLibWrapper>()));
  gh.factory<_i48.WitnessDataSource>(
      () => _i48.WitnessDataSource(get<_i48.WitnessIsolatesWrapper>()));
  gh.factory<_i51.AtomicQueryInputsDataSource>(() =>
      _i51.AtomicQueryInputsDataSource(get<_i51.AtomicQueryInputsWrapper>()));
  gh.factory<_i66.ConfigRepositoryImpl>(
      () => _i66.ConfigRepositoryImpl(get<_i56.EnvDataSource>()));
  gh.factory<_i67.CredentialRepositoryImpl>(() => _i67.CredentialRepositoryImpl(
        get<_i39.RemoteClaimDataSource>(),
        get<_i54.StorageClaimDataSource>(),
        get<_i41.RemoteIdentityDataSource>(),
        get<_i10.CredentialRequestMapper>(),
        get<_i53.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i15.IdFilterMapper>(),
        get<_i42.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i68.GetPackageNameUseCase>(() async =>
      _i68.GetPackageNameUseCase(
          await get.getAsync<_i61.PackageInfoRepository>()));
  gh.factory<_i20.JWZDataSource>(() => _i20.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i45.WalletDataSource>(),
        get<_i20.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i69.ProofRepositoryImpl>(() => _i69.ProofRepositoryImpl(
        get<_i48.WitnessDataSource>(),
        get<_i38.ProverLibDataSource>(),
        get<_i51.AtomicQueryInputsDataSource>(),
        get<_i24.LocalProofFilesDataSource>(),
        get<_i31.ProofCircuitDataSource>(),
        get<_i41.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i62.ProofRequestsMapper>(),
        get<_i35.ProofRequestFiltersMapper>(),
        get<_i32.ProofMapper>(),
        get<_i53.ClaimMapper>(),
        get<_i42.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i59.StorageIdentityDataSource>(
      () async => _i59.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i59.IdentityStoreRefWrapper>(),
            await get.getAsync<_i60.StorageKeyValueDataSource>(),
            get<_i45.WalletDataSource>(),
            get<_i14.HexMapper>(),
          ));
  gh.factory<_i70.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i66.ConfigRepositoryImpl>()));
  gh.factory<_i71.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i67.CredentialRepositoryImpl>()));
  gh.factory<_i72.GetClaimsUseCase>(
      () => _i72.GetClaimsUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i73.GetEnvConfigUseCase>(
      () => _i73.GetEnvConfigUseCase(get<_i70.ConfigRepository>()));
  gh.factory<_i74.GetVocabsUseCase>(
      () => _i74.GetVocabsUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i75.Iden3commRepositoryImpl>(() => _i75.Iden3commRepositoryImpl(
        get<_i40.RemoteIden3commDataSource>(),
        get<_i20.JWZDataSource>(),
        get<_i14.HexMapper>(),
        get<_i3.AuthResponseMapper>(),
        get<_i52.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i76.IdentityRepositoryImpl>(
      () async => _i76.IdentityRepositoryImpl(
            get<_i45.WalletDataSource>(),
            get<_i21.LibIdentityDataSource>(),
            get<_i23.LocalIdentityDataSource>(),
            get<_i41.RemoteIdentityDataSource>(),
            await get.getAsync<_i59.StorageIdentityDataSource>(),
            await get.getAsync<_i60.StorageKeyValueDataSource>(),
            get<_i63.RPCDataSource>(),
            get<_i22.LocalContractFilesDataSource>(),
            get<_i14.HexMapper>(),
            get<_i30.PrivateKeyMapper>(),
            get<_i19.IdentityDTOMapper>(),
            get<_i64.RhsNodeMapper>(),
          ));
  gh.factory<_i77.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i69.ProofRepositoryImpl>()));
  gh.factory<_i78.RemoveClaimsUseCase>(
      () => _i78.RemoveClaimsUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i79.UpdateClaimUseCase>(
      () => _i79.UpdateClaimUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i80.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i75.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i81.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i76.IdentityRepositoryImpl>()));
  gh.factory<_i82.IsProofCircuitSupportedUseCase>(
      () => _i82.IsProofCircuitSupportedUseCase(get<_i77.ProofRepository>()));
  gh.factoryAsync<_i83.RemoveIdentityUseCase>(() async =>
      _i83.RemoveIdentityUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i84.ReplaceIdentityUseCase>(() async =>
      _i84.ReplaceIdentityUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i85.SignMessageUseCase>(() async =>
      _i85.SignMessageUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i86.CreateAndSaveIdentityUseCase>(() async =>
      _i86.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i87.FetchIdentityStateUseCase>(
      () async => _i87.FetchIdentityStateUseCase(
            await get.getAsync<_i81.IdentityRepository>(),
            get<_i73.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i88.FetchStateRootsUseCase>(() async =>
      _i88.FetchStateRootsUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i89.GenerateNonRevProofUseCase>(
      () async => _i89.GenerateNonRevProofUseCase(
            await get.getAsync<_i81.IdentityRepository>(),
            get<_i71.CredentialRepository>(),
            get<_i73.GetEnvConfigUseCase>(),
            await get.getAsync<_i87.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i90.GetAuthTokenUseCase>(
      () async => _i90.GetAuthTokenUseCase(
            get<_i80.Iden3commRepository>(),
            get<_i77.ProofRepository>(),
            await get.getAsync<_i81.IdentityRepository>(),
          ));
  gh.factoryAsync<_i91.GetClaimRevocationStatusUseCase>(
      () async => _i91.GetClaimRevocationStatusUseCase(
            get<_i71.CredentialRepository>(),
            await get.getAsync<_i81.IdentityRepository>(),
            await get.getAsync<_i89.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i92.GetDidIdentifierUseCase>(() async =>
      _i92.GetDidIdentifierUseCase(
          await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i93.GetIdentifierUseCase>(() async =>
      _i93.GetIdentifierUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i94.GetIdentityUseCase>(() async =>
      _i94.GetIdentityUseCase(await get.getAsync<_i81.IdentityRepository>()));
  gh.factoryAsync<_i95.IdentityWallet>(() async => _i95.IdentityWallet(
        await get.getAsync<_i86.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i84.ReplaceIdentityUseCase>(),
        await get.getAsync<_i94.GetIdentityUseCase>(),
        await get.getAsync<_i83.RemoveIdentityUseCase>(),
        await get.getAsync<_i93.GetIdentifierUseCase>(),
        await get.getAsync<_i85.SignMessageUseCase>(),
        await get.getAsync<_i87.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i96.FetchAndSaveClaimsUseCase>(
      () async => _i96.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i90.GetAuthTokenUseCase>(),
            get<_i71.CredentialRepository>(),
          ));
  gh.factoryAsync<_i97.GenerateProofUseCase>(
      () async => _i97.GenerateProofUseCase(
            get<_i77.ProofRepository>(),
            get<_i71.CredentialRepository>(),
            await get.getAsync<_i91.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i98.GetProofsUseCase>(() async => _i98.GetProofsUseCase(
        get<_i77.ProofRepository>(),
        await get.getAsync<_i81.IdentityRepository>(),
        get<_i72.GetClaimsUseCase>(),
        await get.getAsync<_i97.GenerateProofUseCase>(),
        get<_i82.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i99.ProofGeneration>(() async =>
      _i99.ProofGeneration(await get.getAsync<_i97.GenerateProofUseCase>()));
  gh.factoryAsync<_i100.AuthenticateUseCase>(
      () async => _i100.AuthenticateUseCase(
            get<_i80.Iden3commRepository>(),
            await get.getAsync<_i98.GetProofsUseCase>(),
            await get.getAsync<_i90.GetAuthTokenUseCase>(),
            get<_i73.GetEnvConfigUseCase>(),
            await get.getAsync<_i68.GetPackageNameUseCase>(),
            await get.getAsync<_i92.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i101.CredentialWallet>(() async => _i101.CredentialWallet(
        await get.getAsync<_i96.FetchAndSaveClaimsUseCase>(),
        get<_i72.GetClaimsUseCase>(),
        get<_i78.RemoveClaimsUseCase>(),
        get<_i79.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i102.Iden3comm>(() async => _i102.Iden3comm(
        get<_i74.GetVocabsUseCase>(),
        await get.getAsync<_i100.AuthenticateUseCase>(),
        await get.getAsync<_i98.GetProofsUseCase>(),
        get<_i58.Iden3MessageMapper>(),
        get<_i65.SchemaInfoMapper>(),
      ));
  return get;
}

class _$NetworkModule extends _i103.NetworkModule {}

class _$DatabaseModule extends _i103.DatabaseModule {}

class _$PackageInfoModule extends _i103.PackageInfoModule {}

class _$Sdk extends _i103.Sdk {}

class _$RepositoriesModule extends _i103.RepositoriesModule {}
