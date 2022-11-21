// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i32;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i53;

import '../../common/data/data_sources/env_datasource.dart' as _i63;
import '../../common/data/data_sources/package_info_datasource.dart' as _i33;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i75;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i34;
import '../../common/domain/repositories/config_repository.dart' as _i80;
import '../../common/domain/repositories/package_info_repository.dart' as _i69;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i83;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i77;
import '../../credential/data/credential_repository_impl.dart' as _i76;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i45;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i61;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i60;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i16;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i48;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i81;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i108;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i96;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i82;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i84;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i88;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i91;
import '../../env/sdk_env.dart' as _i50;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i42;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i46;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i62;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i64;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i18;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i39;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i40;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i41;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i70;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i85;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i100;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i107;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i104;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i105;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i22;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i23;
import '../../identity/data/data_sources/lib_pidcore_data_source.dart' as _i67;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i24;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i25;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i47;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i71;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i66;
import '../../identity/data/data_sources/storage_identity_smt_data_source.dart'
    as _i21;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i52;
import '../../identity/data/mappers/hash_mapper.dart' as _i14;
import '../../identity/data/mappers/hex_mapper.dart' as _i15;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i20;
import '../../identity/data/mappers/node_mapper.dart' as _i68;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i28;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i29;
import '../../identity/data/mappers/node_type_mapper.dart' as _i30;
import '../../identity/data/mappers/private_key_mapper.dart' as _i36;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i72;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i49;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i51;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i78;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i73;
import '../../identity/domain/repositories/identity_repository.dart' as _i86;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i92;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i94;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i97;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i98;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i99;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i89;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i90;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i17;
import '../../identity/libs/polygonidcore/polygonidcore.dart' as _i35;
import '../../identity/libs/smt/node.dart' as _i27;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i58;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i26;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i37;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i44;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i55;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i38;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i79;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i87;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i103;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i102;
import '../../proof_generation/libs/prover/prover.dart' as _i43;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i54;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i56;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i57;
import '../credential.dart' as _i110;
import '../iden3comm.dart' as _i109;
import '../identity.dart' as _i101;
import '../mappers/iden3_message_mapper.dart' as _i65;
import '../mappers/iden3_message_type_mapper.dart' as _i19;
import '../mappers/schema_info_mapper.dart' as _i74;
import '../proof.dart' as _i106;
import 'injector.dart' as _i111; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i21.IdentitySMTStoreRefWrapper>(
      () => _i21.IdentitySMTStoreRefWrapper());
  gh.factory<_i22.JWZIsolatesWrapper>(() => _i22.JWZIsolatesWrapper());
  gh.factory<_i23.LibIdentityDataSource>(
      () => _i23.LibIdentityDataSource(get<_i17.Iden3CoreLib>()));
  gh.factory<_i24.LocalContractFilesDataSource>(
      () => _i24.LocalContractFilesDataSource());
  gh.factory<_i25.LocalIdentityDataSource>(
      () => _i25.LocalIdentityDataSource());
  gh.factory<_i26.LocalProofFilesDataSource>(
      () => _i26.LocalProofFilesDataSource());
  gh.factory<_i27.Node>(() => _i27.Node(
        get<_i27.NodeType>(),
        get<_i17.Iden3CoreLib>(),
      ));
  gh.factory<_i28.NodeTypeDTOMapper>(() => _i28.NodeTypeDTOMapper());
  gh.factory<_i29.NodeTypeEntityMapper>(() => _i29.NodeTypeEntityMapper());
  gh.factory<_i30.NodeTypeMapper>(() => _i30.NodeTypeMapper());
  gh.factory<_i31.OfferRequestMapper>(
      () => _i31.OfferRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i32.PackageInfo>(() => packageInfoModule.packageInfo);
  gh.factoryAsync<_i33.PackageInfoDataSource>(() async =>
      _i33.PackageInfoDataSource(await get.getAsync<_i32.PackageInfo>()));
  gh.factoryAsync<_i34.PackageInfoRepositoryImpl>(() async =>
      _i34.PackageInfoRepositoryImpl(
          await get.getAsync<_i33.PackageInfoDataSource>()));
  gh.factory<_i35.PolygonIdCoreLib>(() => _i35.PolygonIdCoreLib());
  gh.factory<_i36.PrivateKeyMapper>(() => _i36.PrivateKeyMapper());
  gh.factory<_i37.ProofCircuitDataSource>(() => _i37.ProofCircuitDataSource());
  gh.factory<_i38.ProofMapper>(() => _i38.ProofMapper());
  gh.factory<_i39.ProofQueryMapper>(() => _i39.ProofQueryMapper());
  gh.factory<_i40.ProofQueryParamMapper>(() => _i40.ProofQueryParamMapper());
  gh.factory<_i41.ProofRequestFiltersMapper>(
      () => _i41.ProofRequestFiltersMapper(get<_i39.ProofQueryMapper>()));
  gh.factory<_i42.ProofScopeDataSource>(() => _i42.ProofScopeDataSource());
  gh.factory<_i43.ProverLib>(() => _i43.ProverLib());
  gh.factory<_i44.ProverLibWrapper>(() => _i44.ProverLibWrapper());
  gh.factory<_i45.RemoteClaimDataSource>(
      () => _i45.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i46.RemoteIden3commDataSource>(
      () => _i46.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i47.RemoteIdentityDataSource>(
      () => _i47.RemoteIdentityDataSource());
  gh.factory<_i48.RevocationStatusMapper>(() => _i48.RevocationStatusMapper());
  gh.factory<_i49.RhsNodeTypeMapper>(() => _i49.RhsNodeTypeMapper());
  gh.lazySingleton<_i50.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i51.StateIdentifierMapper>(() => _i51.StateIdentifierMapper());
  gh.factory<_i21.StorageIdentitySMTDataSource>(() =>
      _i21.StorageIdentitySMTDataSource(
          get<_i21.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.rootsTreeStore,
    instanceName: 'rootsTreeStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimsTreeStore,
    instanceName: 'claimsTreeStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.revocationTreeStore,
    instanceName: 'revocationTreeStore',
  );
  gh.factory<_i52.WalletLibWrapper>(() => _i52.WalletLibWrapper());
  gh.factory<_i53.Web3Client>(
      () => networkModule.web3Client(get<_i50.SdkEnv>()));
  gh.factory<_i54.WitnessAuthLib>(() => _i54.WitnessAuthLib());
  gh.factory<_i55.WitnessIsolatesWrapper>(() => _i55.WitnessIsolatesWrapper());
  gh.factory<_i56.WitnessMtpLib>(() => _i56.WitnessMtpLib());
  gh.factory<_i57.WitnessSigLib>(() => _i57.WitnessSigLib());
  gh.factory<_i58.AtomicQueryInputsWrapper>(
      () => _i58.AtomicQueryInputsWrapper(get<_i17.Iden3CoreLib>()));
  gh.factory<_i59.AuthRequestMapper>(
      () => _i59.AuthRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.ClaimMapper>(() => _i60.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i61.ClaimStoreRefWrapper>(() => _i61.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i62.ContractRequestMapper>(
      () => _i62.ContractRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i63.EnvDataSource>(() => _i63.EnvDataSource(get<_i50.SdkEnv>()));
  gh.factory<_i64.FetchRequestMapper>(
      () => _i64.FetchRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i65.Iden3MessageMapper>(
      () => _i65.Iden3MessageMapper(get<_i19.Iden3MessageTypeMapper>()));
  gh.factory<_i66.IdentityStoreRefWrapper>(() => _i66.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i67.LibPolygonIdCoreDataSource>(
      () => _i67.LibPolygonIdCoreDataSource(get<_i35.PolygonIdCoreLib>()));
  gh.factory<_i68.NodeMapper>(() => _i68.NodeMapper(
        get<_i30.NodeTypeMapper>(),
        get<_i29.NodeTypeEntityMapper>(),
        get<_i28.NodeTypeDTOMapper>(),
        get<_i14.HashMapper>(),
      ));
  gh.factoryAsync<_i69.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i34.PackageInfoRepositoryImpl>()));
  gh.factory<_i70.ProofRequestsMapper>(() => _i70.ProofRequestsMapper(
        get<_i59.AuthRequestMapper>(),
        get<_i64.FetchRequestMapper>(),
        get<_i31.OfferRequestMapper>(),
        get<_i62.ContractRequestMapper>(),
        get<_i40.ProofQueryParamMapper>(),
      ));
  gh.factory<_i44.ProverLibDataSource>(
      () => _i44.ProverLibDataSource(get<_i44.ProverLibWrapper>()));
  gh.factory<_i71.RPCDataSource>(
      () => _i71.RPCDataSource(get<_i53.Web3Client>()));
  gh.factory<_i72.RhsNodeMapper>(
      () => _i72.RhsNodeMapper(get<_i49.RhsNodeTypeMapper>()));
  gh.factory<_i73.SMTRepositoryImpl>(() => _i73.SMTRepositoryImpl(
        get<_i21.StorageIdentitySMTDataSource>(),
        get<_i23.LibIdentityDataSource>(),
        get<_i68.NodeMapper>(),
        get<_i14.HashMapper>(),
      ));
  gh.factory<_i74.SchemaInfoMapper>(() => _i74.SchemaInfoMapper(
        get<_i59.AuthRequestMapper>(),
        get<_i62.ContractRequestMapper>(),
      ));
  gh.factory<_i61.StorageClaimDataSource>(
      () => _i61.StorageClaimDataSource(get<_i61.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i66.StorageIdentityDataSource>(
      () async => _i66.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i66.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i52.WalletDataSource>(
      () => _i52.WalletDataSource(get<_i52.WalletLibWrapper>()));
  gh.factory<_i55.WitnessDataSource>(
      () => _i55.WitnessDataSource(get<_i55.WitnessIsolatesWrapper>()));
  gh.factory<_i58.AtomicQueryInputsDataSource>(() =>
      _i58.AtomicQueryInputsDataSource(get<_i58.AtomicQueryInputsWrapper>()));
  gh.factory<_i75.ConfigRepositoryImpl>(
      () => _i75.ConfigRepositoryImpl(get<_i63.EnvDataSource>()));
  gh.factory<_i76.CredentialRepositoryImpl>(() => _i76.CredentialRepositoryImpl(
        get<_i45.RemoteClaimDataSource>(),
        get<_i61.StorageClaimDataSource>(),
        get<_i47.RemoteIdentityDataSource>(),
        get<_i23.LibIdentityDataSource>(),
        get<_i10.CredentialRequestMapper>(),
        get<_i60.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i16.IdFilterMapper>(),
        get<_i48.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i77.GetPackageNameUseCase>(() async =>
      _i77.GetPackageNameUseCase(
          await get.getAsync<_i69.PackageInfoRepository>()));
  gh.factoryAsync<_i78.IdentityRepositoryImpl>(
      () async => _i78.IdentityRepositoryImpl(
            get<_i52.WalletDataSource>(),
            get<_i23.LibIdentityDataSource>(),
            get<_i67.LibPolygonIdCoreDataSource>(),
            get<_i25.LocalIdentityDataSource>(),
            get<_i47.RemoteIdentityDataSource>(),
            await get.getAsync<_i66.StorageIdentityDataSource>(),
            get<_i71.RPCDataSource>(),
            get<_i24.LocalContractFilesDataSource>(),
            get<_i15.HexMapper>(),
            get<_i36.PrivateKeyMapper>(),
            get<_i20.IdentityDTOMapper>(),
            get<_i72.RhsNodeMapper>(),
            get<_i51.StateIdentifierMapper>(),
          ));
  gh.factory<_i22.JWZDataSource>(() => _i22.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i52.WalletDataSource>(),
        get<_i22.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i79.ProofRepositoryImpl>(() => _i79.ProofRepositoryImpl(
        get<_i55.WitnessDataSource>(),
        get<_i44.ProverLibDataSource>(),
        get<_i58.AtomicQueryInputsDataSource>(),
        get<_i26.LocalProofFilesDataSource>(),
        get<_i37.ProofCircuitDataSource>(),
        get<_i47.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i70.ProofRequestsMapper>(),
        get<_i41.ProofRequestFiltersMapper>(),
        get<_i38.ProofMapper>(),
        get<_i60.ClaimMapper>(),
        get<_i48.RevocationStatusMapper>(),
      ));
  gh.factory<_i80.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i75.ConfigRepositoryImpl>()));
  gh.factory<_i81.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i76.CredentialRepositoryImpl>()));
  gh.factory<_i82.GetClaimsUseCase>(
      () => _i82.GetClaimsUseCase(get<_i81.CredentialRepository>()));
  gh.factory<_i83.GetEnvConfigUseCase>(
      () => _i83.GetEnvConfigUseCase(get<_i80.ConfigRepository>()));
  gh.factory<_i84.GetVocabsUseCase>(
      () => _i84.GetVocabsUseCase(get<_i81.CredentialRepository>()));
  gh.factory<_i85.Iden3commRepositoryImpl>(() => _i85.Iden3commRepositoryImpl(
        get<_i46.RemoteIden3commDataSource>(),
        get<_i22.JWZDataSource>(),
        get<_i15.HexMapper>(),
        get<_i3.AuthResponseMapper>(),
        get<_i59.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i86.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i78.IdentityRepositoryImpl>()));
  gh.factory<_i87.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i79.ProofRepositoryImpl>()));
  gh.factory<_i88.RemoveClaimsUseCase>(
      () => _i88.RemoveClaimsUseCase(get<_i81.CredentialRepository>()));
  gh.factoryAsync<_i89.RemoveIdentityUseCase>(() async =>
      _i89.RemoveIdentityUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i90.SignMessageUseCase>(() async =>
      _i90.SignMessageUseCase(await get.getAsync<_i86.IdentityRepository>()));
  gh.factory<_i91.UpdateClaimUseCase>(
      () => _i91.UpdateClaimUseCase(get<_i81.CredentialRepository>()));
  gh.factoryAsync<_i92.CreateAndSaveIdentityUseCase>(() async =>
      _i92.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i93.FetchIdentityStateUseCase>(
      () async => _i93.FetchIdentityStateUseCase(
            await get.getAsync<_i86.IdentityRepository>(),
            get<_i83.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i94.FetchStateRootsUseCase>(() async =>
      _i94.FetchStateRootsUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i95.GenerateNonRevProofUseCase>(
      () async => _i95.GenerateNonRevProofUseCase(
            await get.getAsync<_i86.IdentityRepository>(),
            get<_i81.CredentialRepository>(),
            get<_i83.GetEnvConfigUseCase>(),
            await get.getAsync<_i93.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i96.GetClaimRevocationStatusUseCase>(
      () async => _i96.GetClaimRevocationStatusUseCase(
            get<_i81.CredentialRepository>(),
            await get.getAsync<_i86.IdentityRepository>(),
            await get.getAsync<_i95.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i97.GetDidIdentifierUseCase>(() async =>
      _i97.GetDidIdentifierUseCase(
          await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i98.GetIdentifierUseCase>(() async =>
      _i98.GetIdentifierUseCase(await get.getAsync<_i86.IdentityRepository>()));
  gh.factoryAsync<_i99.GetIdentityUseCase>(() async =>
      _i99.GetIdentityUseCase(await get.getAsync<_i86.IdentityRepository>()));
  gh.factory<_i100.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i85.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i101.Identity>(() async => _i101.Identity(
        await get.getAsync<_i92.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i99.GetIdentityUseCase>(),
        await get.getAsync<_i89.RemoveIdentityUseCase>(),
        await get.getAsync<_i98.GetIdentifierUseCase>(),
        await get.getAsync<_i90.SignMessageUseCase>(),
        await get.getAsync<_i93.FetchIdentityStateUseCase>(),
      ));
  gh.factory<_i102.IsProofCircuitSupportedUseCase>(
      () => _i102.IsProofCircuitSupportedUseCase(get<_i87.ProofRepository>()));
  gh.factoryAsync<_i103.GenerateProofUseCase>(
      () async => _i103.GenerateProofUseCase(
            get<_i87.ProofRepository>(),
            get<_i81.CredentialRepository>(),
            await get.getAsync<_i96.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i104.GetAuthTokenUseCase>(
      () async => _i104.GetAuthTokenUseCase(
            get<_i100.Iden3commRepository>(),
            get<_i87.ProofRepository>(),
            get<_i81.CredentialRepository>(),
            await get.getAsync<_i86.IdentityRepository>(),
          ));
  gh.factoryAsync<_i105.GetProofsUseCase>(() async => _i105.GetProofsUseCase(
        get<_i87.ProofRepository>(),
        await get.getAsync<_i86.IdentityRepository>(),
        get<_i82.GetClaimsUseCase>(),
        await get.getAsync<_i103.GenerateProofUseCase>(),
        get<_i102.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i106.Proof>(() async =>
      _i106.Proof(await get.getAsync<_i103.GenerateProofUseCase>()));
  gh.factoryAsync<_i107.AuthenticateUseCase>(
      () async => _i107.AuthenticateUseCase(
            get<_i100.Iden3commRepository>(),
            await get.getAsync<_i105.GetProofsUseCase>(),
            await get.getAsync<_i104.GetAuthTokenUseCase>(),
            get<_i83.GetEnvConfigUseCase>(),
            await get.getAsync<_i77.GetPackageNameUseCase>(),
            await get.getAsync<_i97.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i108.FetchAndSaveClaimsUseCase>(
      () async => _i108.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i104.GetAuthTokenUseCase>(),
            get<_i81.CredentialRepository>(),
          ));
  gh.factoryAsync<_i109.Iden3comm>(() async => _i109.Iden3comm(
        get<_i84.GetVocabsUseCase>(),
        await get.getAsync<_i107.AuthenticateUseCase>(),
        await get.getAsync<_i105.GetProofsUseCase>(),
        get<_i65.Iden3MessageMapper>(),
        get<_i74.SchemaInfoMapper>(),
      ));
  gh.factoryAsync<_i110.Credential>(() async => _i110.Credential(
        await get.getAsync<_i108.FetchAndSaveClaimsUseCase>(),
        get<_i82.GetClaimsUseCase>(),
        get<_i88.RemoveClaimsUseCase>(),
        get<_i91.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$NetworkModule extends _i111.NetworkModule {}

class _$DatabaseModule extends _i111.DatabaseModule {}

class _$PackageInfoModule extends _i111.PackageInfoModule {}

class _$Sdk extends _i111.Sdk {}

class _$RepositoriesModule extends _i111.RepositoriesModule {}
