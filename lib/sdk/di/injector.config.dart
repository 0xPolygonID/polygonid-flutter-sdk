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
import '../../common/data/repositories/env_config_repository_impl.dart' as _i72;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i31;
import '../../common/domain/repositories/config_repository.dart' as _i78;
import '../../common/domain/repositories/package_info_repository.dart' as _i67;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i81;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i74;
import '../../credential/data/credential_repository_impl.dart' as _i73;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i42;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i58;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i57;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i16;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i45;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i79;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i106;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i94;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i80;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i82;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i86;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i89;
import '../../env/sdk_env.dart' as _i47;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i39;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i43;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i56;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i61;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i18;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i28;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i36;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i37;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i38;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i68;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i83;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i98;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i105;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i102;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i103;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i21;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i22;
import '../../identity/data/data_sources/lib_pidcore_data_source.dart' as _i65;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i24;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i44;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i69;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i64;
import '../../identity/data/data_sources/storage_identity_state_data_source.dart'
    as _i63;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i49;
import '../../identity/data/mappers/hash_mapper.dart' as _i14;
import '../../identity/data/mappers/hex_mapper.dart' as _i15;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i20;
import '../../identity/data/mappers/node_mapper.dart' as _i66;
import '../../identity/data/mappers/node_type_mapper.dart' as _i27;
import '../../identity/data/mappers/private_key_mapper.dart' as _i33;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i70;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i46;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i48;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i75;
import '../../identity/data/repositories/smt_storage_repository_impl.dart'
    as _i77;
import '../../identity/domain/repositories/identity_repository.dart' as _i84;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i92;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i96;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i97;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i87;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i88;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i17;
import '../../identity/libs/polygonidcore/polygonidcore.dart' as _i32;
import '../../identity/libs/smt/node.dart' as _i26;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i55;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i25;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i34;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i41;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i52;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i35;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i76;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i85;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i101;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i100;
import '../../proof_generation/libs/prover/prover.dart' as _i40;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i53;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i54;
import '../credential.dart' as _i108;
import '../iden3comm.dart' as _i107;
import '../identity.dart' as _i99;
import '../mappers/iden3_message_mapper.dart' as _i62;
import '../mappers/iden3_message_type_mapper.dart' as _i19;
import '../mappers/schema_info_mapper.dart' as _i71;
import '../proof.dart' as _i104;
import 'injector.dart' as _i109; // ignore_for_file: unnecessary_lambdas

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
        databaseModule.identityDatabase(
      identifier,
      privateKey,
    ),
    instanceName: 'polygonIdSdkIdentity',
  );
  gh.lazySingletonAsync<_i11.Database>(() => databaseModule.database());
  gh.factory<_i12.FilterMapper>(() => _i12.FilterMapper());
  gh.factory<_i13.FiltersMapper>(
      () => _i13.FiltersMapper(get<_i12.FilterMapper>()));
  gh.factory<_i14.HashMapper>(() => _i14.HashMapper());
  gh.factory<_i15.HexMapper>(() => _i15.HexMapper());
  gh.factory<_i16.IdFilterMapper>(() => _i16.IdFilterMapper());
  gh.factory<_i17.Iden3CoreLib>(() => _i17.Iden3CoreLib());
  gh.factory<_i18.Iden3MessageTypeDataMapper>(
      () => _i18.Iden3MessageTypeDataMapper());
  gh.factory<_i19.Iden3MessageTypeMapper>(() => _i19.Iden3MessageTypeMapper());
  gh.factory<_i20.IdentityDTOMapper>(() => _i20.IdentityDTOMapper());
  gh.factory<_i21.JWZIsolatesWrapper>(() => _i21.JWZIsolatesWrapper());
  gh.factory<_i22.LibIdentityDataSource>(
      () => _i22.LibIdentityDataSource(get<_i17.Iden3CoreLib>()));
  gh.factory<_i23.LocalContractFilesDataSource>(
      () => _i23.LocalContractFilesDataSource());
  gh.factory<_i24.LocalIdentityDataSource>(
      () => _i24.LocalIdentityDataSource());
  gh.factory<_i25.LocalProofFilesDataSource>(
      () => _i25.LocalProofFilesDataSource());
  gh.factory<_i26.Node>(() => _i26.Node(
        get<_i26.NodeType>(),
        get<_i17.Iden3CoreLib>(),
      ));
  gh.factory<_i27.NodeTypeMapper>(() => _i27.NodeTypeMapper());
  gh.factory<_i28.OfferRequestMapper>(
      () => _i28.OfferRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i29.PackageInfo>(() => packageInfoModule.packageInfo);
  gh.factoryAsync<_i30.PackageInfoDataSource>(() async =>
      _i30.PackageInfoDataSource(await get.getAsync<_i29.PackageInfo>()));
  gh.factoryAsync<_i31.PackageInfoRepositoryImpl>(() async =>
      _i31.PackageInfoRepositoryImpl(
          await get.getAsync<_i30.PackageInfoDataSource>()));
  gh.factory<_i32.PolygonIdCoreLib>(() => _i32.PolygonIdCoreLib());
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
  gh.lazySingleton<_i47.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i48.StateIdentifierMapper>(() => _i48.StateIdentifierMapper());
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i49.WalletLibWrapper>(() => _i49.WalletLibWrapper());
  gh.factory<_i50.Web3Client>(
      () => networkModule.web3Client(get<_i47.SdkEnv>()));
  gh.factory<_i51.WitnessAuthLib>(() => _i51.WitnessAuthLib());
  gh.factory<_i52.WitnessIsolatesWrapper>(() => _i52.WitnessIsolatesWrapper());
  gh.factory<_i53.WitnessMtpLib>(() => _i53.WitnessMtpLib());
  gh.factory<_i54.WitnessSigLib>(() => _i54.WitnessSigLib());
  gh.factory<_i55.AtomicQueryInputsWrapper>(
      () => _i55.AtomicQueryInputsWrapper(get<_i17.Iden3CoreLib>()));
  gh.factory<_i56.AuthRequestMapper>(
      () => _i56.AuthRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i57.ClaimMapper>(() => _i57.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i58.ClaimStoreRefWrapper>(() => _i58.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i59.ContractRequestMapper>(
      () => _i59.ContractRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.EnvDataSource>(() => _i60.EnvDataSource(get<_i47.SdkEnv>()));
  gh.factory<_i61.FetchRequestMapper>(
      () => _i61.FetchRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i62.Iden3MessageMapper>(
      () => _i62.Iden3MessageMapper(get<_i19.Iden3MessageTypeMapper>()));
  gh.factory<_i63.IdentityStoreRefWrapper>(() => _i63.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i64.IdentityStoreRefWrapper>(() => _i64.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i65.LibPolygonIdCoreDataSource>(
      () => _i65.LibPolygonIdCoreDataSource(get<_i32.PolygonIdCoreLib>()));
  gh.factory<_i66.NodeMapper>(() => _i66.NodeMapper(
        get<_i27.NodeTypeMapper>(),
        get<_i14.HashMapper>(),
      ));
  gh.factoryAsync<_i67.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i31.PackageInfoRepositoryImpl>()));
  gh.factory<_i68.ProofRequestsMapper>(() => _i68.ProofRequestsMapper(
        get<_i56.AuthRequestMapper>(),
        get<_i61.FetchRequestMapper>(),
        get<_i28.OfferRequestMapper>(),
        get<_i59.ContractRequestMapper>(),
        get<_i37.ProofQueryParamMapper>(),
      ));
  gh.factory<_i41.ProverLibDataSource>(
      () => _i41.ProverLibDataSource(get<_i41.ProverLibWrapper>()));
  gh.factory<_i69.RPCDataSource>(
      () => _i69.RPCDataSource(get<_i50.Web3Client>()));
  gh.factory<_i70.RhsNodeMapper>(
      () => _i70.RhsNodeMapper(get<_i46.RhsNodeTypeMapper>()));
  gh.factory<_i71.SchemaInfoMapper>(() => _i71.SchemaInfoMapper(
        get<_i56.AuthRequestMapper>(),
        get<_i59.ContractRequestMapper>(),
      ));
  gh.factory<_i58.StorageClaimDataSource>(
      () => _i58.StorageClaimDataSource(get<_i58.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i64.StorageIdentityDataSource>(
      () async => _i64.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i64.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i63.StorageIdentityStateDataSource>(() =>
      _i63.StorageIdentityStateDataSource(get<_i63.IdentityStoreRefWrapper>()));
  gh.factory<_i49.WalletDataSource>(
      () => _i49.WalletDataSource(get<_i49.WalletLibWrapper>()));
  gh.factory<_i52.WitnessDataSource>(
      () => _i52.WitnessDataSource(get<_i52.WitnessIsolatesWrapper>()));
  gh.factory<_i55.AtomicQueryInputsDataSource>(() =>
      _i55.AtomicQueryInputsDataSource(get<_i55.AtomicQueryInputsWrapper>()));
  gh.factory<_i72.ConfigRepositoryImpl>(
      () => _i72.ConfigRepositoryImpl(get<_i60.EnvDataSource>()));
  gh.factory<_i73.CredentialRepositoryImpl>(() => _i73.CredentialRepositoryImpl(
        get<_i42.RemoteClaimDataSource>(),
        get<_i58.StorageClaimDataSource>(),
        get<_i44.RemoteIdentityDataSource>(),
        get<_i22.LibIdentityDataSource>(),
        get<_i10.CredentialRequestMapper>(),
        get<_i57.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i16.IdFilterMapper>(),
        get<_i45.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i74.GetPackageNameUseCase>(() async =>
      _i74.GetPackageNameUseCase(
          await get.getAsync<_i67.PackageInfoRepository>()));
  gh.factoryAsync<_i75.IdentityRepositoryImpl>(
      () async => _i75.IdentityRepositoryImpl(
            get<_i49.WalletDataSource>(),
            get<_i22.LibIdentityDataSource>(),
            get<_i65.LibPolygonIdCoreDataSource>(),
            get<_i24.LocalIdentityDataSource>(),
            get<_i44.RemoteIdentityDataSource>(),
            await get.getAsync<_i64.StorageIdentityDataSource>(),
            get<_i69.RPCDataSource>(),
            get<_i23.LocalContractFilesDataSource>(),
            get<_i15.HexMapper>(),
            get<_i33.PrivateKeyMapper>(),
            get<_i20.IdentityDTOMapper>(),
            get<_i70.RhsNodeMapper>(),
            get<_i48.StateIdentifierMapper>(),
          ));
  gh.factory<_i21.JWZDataSource>(() => _i21.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i49.WalletDataSource>(),
        get<_i21.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i76.ProofRepositoryImpl>(() => _i76.ProofRepositoryImpl(
        get<_i52.WitnessDataSource>(),
        get<_i41.ProverLibDataSource>(),
        get<_i55.AtomicQueryInputsDataSource>(),
        get<_i25.LocalProofFilesDataSource>(),
        get<_i34.ProofCircuitDataSource>(),
        get<_i44.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i68.ProofRequestsMapper>(),
        get<_i38.ProofRequestFiltersMapper>(),
        get<_i35.ProofMapper>(),
        get<_i57.ClaimMapper>(),
        get<_i45.RevocationStatusMapper>(),
      ));
  gh.factory<_i77.SMTStorageRepositoryImpl>(() => _i77.SMTStorageRepositoryImpl(
        get<_i63.StorageIdentityStateDataSource>(),
        get<_i66.NodeMapper>(),
        get<_i14.HashMapper>(),
      ));
  gh.factory<_i78.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i72.ConfigRepositoryImpl>()));
  gh.factory<_i79.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i73.CredentialRepositoryImpl>()));
  gh.factory<_i80.GetClaimsUseCase>(
      () => _i80.GetClaimsUseCase(get<_i79.CredentialRepository>()));
  gh.factory<_i81.GetEnvConfigUseCase>(
      () => _i81.GetEnvConfigUseCase(get<_i78.ConfigRepository>()));
  gh.factory<_i82.GetVocabsUseCase>(
      () => _i82.GetVocabsUseCase(get<_i79.CredentialRepository>()));
  gh.factory<_i83.Iden3commRepositoryImpl>(() => _i83.Iden3commRepositoryImpl(
        get<_i43.RemoteIden3commDataSource>(),
        get<_i21.JWZDataSource>(),
        get<_i15.HexMapper>(),
        get<_i3.AuthResponseMapper>(),
        get<_i56.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i84.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i75.IdentityRepositoryImpl>()));
  gh.factory<_i85.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i76.ProofRepositoryImpl>()));
  gh.factory<_i86.RemoveClaimsUseCase>(
      () => _i86.RemoveClaimsUseCase(get<_i79.CredentialRepository>()));
  gh.factoryAsync<_i87.RemoveIdentityUseCase>(() async =>
      _i87.RemoveIdentityUseCase(
          await get.getAsync<_i84.IdentityRepository>()));
  gh.factoryAsync<_i88.SignMessageUseCase>(() async =>
      _i88.SignMessageUseCase(await get.getAsync<_i84.IdentityRepository>()));
  gh.factory<_i89.UpdateClaimUseCase>(
      () => _i89.UpdateClaimUseCase(get<_i79.CredentialRepository>()));
  gh.factoryAsync<_i90.CreateAndSaveIdentityUseCase>(() async =>
      _i90.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i84.IdentityRepository>()));
  gh.factoryAsync<_i91.FetchIdentityStateUseCase>(
      () async => _i91.FetchIdentityStateUseCase(
            await get.getAsync<_i84.IdentityRepository>(),
            get<_i81.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i92.FetchStateRootsUseCase>(() async =>
      _i92.FetchStateRootsUseCase(
          await get.getAsync<_i84.IdentityRepository>()));
  gh.factoryAsync<_i93.GenerateNonRevProofUseCase>(
      () async => _i93.GenerateNonRevProofUseCase(
            await get.getAsync<_i84.IdentityRepository>(),
            get<_i79.CredentialRepository>(),
            get<_i81.GetEnvConfigUseCase>(),
            await get.getAsync<_i91.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i94.GetClaimRevocationStatusUseCase>(
      () async => _i94.GetClaimRevocationStatusUseCase(
            get<_i79.CredentialRepository>(),
            await get.getAsync<_i84.IdentityRepository>(),
            await get.getAsync<_i93.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i95.GetDidIdentifierUseCase>(() async =>
      _i95.GetDidIdentifierUseCase(
          await get.getAsync<_i84.IdentityRepository>()));
  gh.factoryAsync<_i96.GetIdentifierUseCase>(() async =>
      _i96.GetIdentifierUseCase(await get.getAsync<_i84.IdentityRepository>()));
  gh.factoryAsync<_i97.GetIdentityUseCase>(() async =>
      _i97.GetIdentityUseCase(await get.getAsync<_i84.IdentityRepository>()));
  gh.factory<_i98.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i83.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i99.Identity>(() async => _i99.Identity(
        await get.getAsync<_i90.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i97.GetIdentityUseCase>(),
        await get.getAsync<_i87.RemoveIdentityUseCase>(),
        await get.getAsync<_i96.GetIdentifierUseCase>(),
        await get.getAsync<_i88.SignMessageUseCase>(),
        await get.getAsync<_i91.FetchIdentityStateUseCase>(),
      ));
  gh.factory<_i100.IsProofCircuitSupportedUseCase>(
      () => _i100.IsProofCircuitSupportedUseCase(get<_i85.ProofRepository>()));
  gh.factoryAsync<_i101.GenerateProofUseCase>(
      () async => _i101.GenerateProofUseCase(
            get<_i85.ProofRepository>(),
            get<_i79.CredentialRepository>(),
            await get.getAsync<_i94.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i102.GetAuthTokenUseCase>(
      () async => _i102.GetAuthTokenUseCase(
            get<_i98.Iden3commRepository>(),
            get<_i85.ProofRepository>(),
            get<_i79.CredentialRepository>(),
            await get.getAsync<_i84.IdentityRepository>(),
          ));
  gh.factoryAsync<_i103.GetProofsUseCase>(() async => _i103.GetProofsUseCase(
        get<_i85.ProofRepository>(),
        await get.getAsync<_i84.IdentityRepository>(),
        get<_i80.GetClaimsUseCase>(),
        await get.getAsync<_i101.GenerateProofUseCase>(),
        get<_i100.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i104.Proof>(() async =>
      _i104.Proof(await get.getAsync<_i101.GenerateProofUseCase>()));
  gh.factoryAsync<_i105.AuthenticateUseCase>(
      () async => _i105.AuthenticateUseCase(
            get<_i98.Iden3commRepository>(),
            await get.getAsync<_i103.GetProofsUseCase>(),
            await get.getAsync<_i102.GetAuthTokenUseCase>(),
            get<_i81.GetEnvConfigUseCase>(),
            await get.getAsync<_i74.GetPackageNameUseCase>(),
            await get.getAsync<_i95.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i106.FetchAndSaveClaimsUseCase>(
      () async => _i106.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i102.GetAuthTokenUseCase>(),
            get<_i79.CredentialRepository>(),
          ));
  gh.factoryAsync<_i107.Iden3comm>(() async => _i107.Iden3comm(
        get<_i82.GetVocabsUseCase>(),
        await get.getAsync<_i105.AuthenticateUseCase>(),
        await get.getAsync<_i103.GetProofsUseCase>(),
        get<_i62.Iden3MessageMapper>(),
        get<_i71.SchemaInfoMapper>(),
      ));
  gh.factoryAsync<_i108.Credential>(() async => _i108.Credential(
        await get.getAsync<_i106.FetchAndSaveClaimsUseCase>(),
        get<_i80.GetClaimsUseCase>(),
        get<_i86.RemoveClaimsUseCase>(),
        get<_i89.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$NetworkModule extends _i109.NetworkModule {}

class _$DatabaseModule extends _i109.DatabaseModule {}

class _$PackageInfoModule extends _i109.PackageInfoModule {}

class _$Sdk extends _i109.Sdk {}

class _$RepositoriesModule extends _i109.RepositoriesModule {}
