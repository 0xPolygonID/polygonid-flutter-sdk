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
import 'package:web3dart/web3dart.dart' as _i48;

import '../../common/data/data_sources/env_datasource.dart' as _i58;
import '../../common/data/data_sources/package_info_datasource.dart' as _i28;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i69;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i29;
import '../../common/domain/repositories/config_repository.dart' as _i74;
import '../../common/domain/repositories/package_info_repository.dart' as _i64;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i77;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i71;
import '../../credential/data/credential_repository_impl.dart' as _i70;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i40;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i56;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i55;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i15;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i43;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i75;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i102;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i90;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i78;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i82;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i85;
import '../../env/sdk_env.dart' as _i45;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i37;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i41;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i54;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i17;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i26;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i36;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i65;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i79;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i94;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i101;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i98;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i99;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i20;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i21;
import '../../identity/data/data_sources/lib_pidcore_data_source.dart' as _i63;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i22;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i42;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i66;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i62;
import '../../identity/data/data_sources/storage_identity_state_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i47;
import '../../identity/data/mappers/hex_mapper.dart' as _i14;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i19;
import '../../identity/data/mappers/private_key_mapper.dart' as _i31;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i67;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i44;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i46;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i72;
import '../../identity/domain/repositories/identity_repository.dart' as _i80;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i86;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i92;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i93;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i83;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i84;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i16;
import '../../identity/libs/polygonidcore/polygonidcore.dart' as _i30;
import '../../identity/libs/smt/node.dart' as _i25;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i53;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i32;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i50;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i33;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i73;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i81;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i97;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i96;
import '../../proof_generation/libs/prover/prover.dart' as _i38;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i52;
import '../credential.dart' as _i104;
import '../iden3comm.dart' as _i103;
import '../identity.dart' as _i95;
import '../mappers/iden3_message_mapper.dart' as _i60;
import '../mappers/iden3_message_type_mapper.dart' as _i18;
import '../mappers/schema_info_mapper.dart' as _i68;
import '../proof.dart' as _i100;
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
  gh.factory<_i30.PolygonIdCoreLib>(() => _i30.PolygonIdCoreLib());
  gh.factory<_i31.PrivateKeyMapper>(() => _i31.PrivateKeyMapper());
  gh.factory<_i32.ProofCircuitDataSource>(() => _i32.ProofCircuitDataSource());
  gh.factory<_i33.ProofMapper>(() => _i33.ProofMapper());
  gh.factory<_i34.ProofQueryMapper>(() => _i34.ProofQueryMapper());
  gh.factory<_i35.ProofQueryParamMapper>(() => _i35.ProofQueryParamMapper());
  gh.factory<_i36.ProofRequestFiltersMapper>(
      () => _i36.ProofRequestFiltersMapper(get<_i34.ProofQueryMapper>()));
  gh.factory<_i37.ProofScopeDataSource>(() => _i37.ProofScopeDataSource());
  gh.factory<_i38.ProverLib>(() => _i38.ProverLib());
  gh.factory<_i39.ProverLibWrapper>(() => _i39.ProverLibWrapper());
  gh.factory<_i40.RemoteClaimDataSource>(
      () => _i40.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i41.RemoteIden3commDataSource>(
      () => _i41.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i42.RemoteIdentityDataSource>(
      () => _i42.RemoteIdentityDataSource());
  gh.factory<_i43.RevocationStatusMapper>(() => _i43.RevocationStatusMapper());
  gh.factory<_i44.RhsNodeTypeMapper>(() => _i44.RhsNodeTypeMapper());
  gh.lazySingleton<_i45.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i46.StateIdentifierMapper>(() => _i46.StateIdentifierMapper());
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i47.WalletLibWrapper>(() => _i47.WalletLibWrapper());
  gh.factory<_i48.Web3Client>(
      () => networkModule.web3Client(get<_i45.SdkEnv>()));
  gh.factory<_i49.WitnessAuthLib>(() => _i49.WitnessAuthLib());
  gh.factory<_i50.WitnessIsolatesWrapper>(() => _i50.WitnessIsolatesWrapper());
  gh.factory<_i51.WitnessMtpLib>(() => _i51.WitnessMtpLib());
  gh.factory<_i52.WitnessSigLib>(() => _i52.WitnessSigLib());
  gh.factory<_i53.AtomicQueryInputsWrapper>(
      () => _i53.AtomicQueryInputsWrapper(get<_i16.Iden3CoreLib>()));
  gh.factory<_i54.AuthRequestMapper>(
      () => _i54.AuthRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i55.ClaimMapper>(() => _i55.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i56.ClaimStoreRefWrapper>(() => _i56.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i57.ContractRequestMapper>(
      () => _i57.ContractRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.EnvDataSource>(() => _i58.EnvDataSource(get<_i45.SdkEnv>()));
  gh.factory<_i59.FetchRequestMapper>(
      () => _i59.FetchRequestMapper(get<_i17.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.Iden3MessageMapper>(
      () => _i60.Iden3MessageMapper(get<_i18.Iden3MessageTypeMapper>()));
  gh.factory<_i61.IdentityStoreRefWrapper>(() => _i61.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i62.IdentityStoreRefWrapper>(() => _i62.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i63.LibPolygonIdCoreDataSource>(
      () => _i63.LibPolygonIdCoreDataSource(get<_i30.PolygonIdCoreLib>()));
  gh.factoryAsync<_i64.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i29.PackageInfoRepositoryImpl>()));
  gh.factory<_i65.ProofRequestsMapper>(() => _i65.ProofRequestsMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i59.FetchRequestMapper>(),
        get<_i26.OfferRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
        get<_i35.ProofQueryParamMapper>(),
      ));
  gh.factory<_i39.ProverLibDataSource>(
      () => _i39.ProverLibDataSource(get<_i39.ProverLibWrapper>()));
  gh.factory<_i66.RPCDataSource>(
      () => _i66.RPCDataSource(get<_i48.Web3Client>()));
  gh.factory<_i67.RhsNodeMapper>(
      () => _i67.RhsNodeMapper(get<_i44.RhsNodeTypeMapper>()));
  gh.factory<_i68.SchemaInfoMapper>(() => _i68.SchemaInfoMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
      ));
  gh.factory<_i56.StorageClaimDataSource>(
      () => _i56.StorageClaimDataSource(get<_i56.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i62.StorageIdentityDataSource>(
      () async => _i62.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i62.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i61.StorageIdentityStateDataSource>(() =>
      _i61.StorageIdentityStateDataSource(get<_i61.IdentityStoreRefWrapper>()));
  gh.factory<_i47.WalletDataSource>(
      () => _i47.WalletDataSource(get<_i47.WalletLibWrapper>()));
  gh.factory<_i50.WitnessDataSource>(
      () => _i50.WitnessDataSource(get<_i50.WitnessIsolatesWrapper>()));
  gh.factory<_i53.AtomicQueryInputsDataSource>(() =>
      _i53.AtomicQueryInputsDataSource(get<_i53.AtomicQueryInputsWrapper>()));
  gh.factory<_i69.ConfigRepositoryImpl>(
      () => _i69.ConfigRepositoryImpl(get<_i58.EnvDataSource>()));
  gh.factory<_i70.CredentialRepositoryImpl>(() => _i70.CredentialRepositoryImpl(
        get<_i40.RemoteClaimDataSource>(),
        get<_i56.StorageClaimDataSource>(),
        get<_i42.RemoteIdentityDataSource>(),
        get<_i21.LibIdentityDataSource>(),
        get<_i10.CredentialRequestMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i15.IdFilterMapper>(),
        get<_i43.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i71.GetPackageNameUseCase>(() async =>
      _i71.GetPackageNameUseCase(
          await get.getAsync<_i64.PackageInfoRepository>()));
  gh.factoryAsync<_i72.IdentityRepositoryImpl>(
      () async => _i72.IdentityRepositoryImpl(
            get<_i47.WalletDataSource>(),
            get<_i21.LibIdentityDataSource>(),
            get<_i23.LocalIdentityDataSource>(),
            get<_i42.RemoteIdentityDataSource>(),
            await get.getAsync<_i62.StorageIdentityDataSource>(),
            get<_i66.RPCDataSource>(),
            get<_i22.LocalContractFilesDataSource>(),
            get<_i14.HexMapper>(),
            get<_i31.PrivateKeyMapper>(),
            get<_i19.IdentityDTOMapper>(),
            get<_i67.RhsNodeMapper>(),
            get<_i46.StateIdentifierMapper>(),
          ));
  gh.factory<_i20.JWZDataSource>(() => _i20.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i47.WalletDataSource>(),
        get<_i20.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i73.ProofRepositoryImpl>(() => _i73.ProofRepositoryImpl(
        get<_i50.WitnessDataSource>(),
        get<_i39.ProverLibDataSource>(),
        get<_i53.AtomicQueryInputsDataSource>(),
        get<_i24.LocalProofFilesDataSource>(),
        get<_i32.ProofCircuitDataSource>(),
        get<_i42.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i65.ProofRequestsMapper>(),
        get<_i36.ProofRequestFiltersMapper>(),
        get<_i33.ProofMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i43.RevocationStatusMapper>(),
      ));
  gh.factory<_i74.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i69.ConfigRepositoryImpl>()));
  gh.factory<_i75.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i70.CredentialRepositoryImpl>()));
  gh.factory<_i76.GetClaimsUseCase>(
      () => _i76.GetClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i77.GetEnvConfigUseCase>(
      () => _i77.GetEnvConfigUseCase(get<_i74.ConfigRepository>()));
  gh.factory<_i78.GetVocabsUseCase>(
      () => _i78.GetVocabsUseCase(get<_i75.CredentialRepository>()));
  gh.factory<_i79.Iden3commRepositoryImpl>(() => _i79.Iden3commRepositoryImpl(
        get<_i41.RemoteIden3commDataSource>(),
        get<_i20.JWZDataSource>(),
        get<_i14.HexMapper>(),
        get<_i3.AuthResponseMapper>(),
        get<_i54.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i80.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i72.IdentityRepositoryImpl>()));
  gh.factory<_i81.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i73.ProofRepositoryImpl>()));
  gh.factory<_i82.RemoveClaimsUseCase>(
      () => _i82.RemoveClaimsUseCase(get<_i75.CredentialRepository>()));
  gh.factoryAsync<_i83.RemoveIdentityUseCase>(() async =>
      _i83.RemoveIdentityUseCase(
          await get.getAsync<_i80.IdentityRepository>()));
  gh.factoryAsync<_i84.SignMessageUseCase>(() async =>
      _i84.SignMessageUseCase(await get.getAsync<_i80.IdentityRepository>()));
  gh.factory<_i85.UpdateClaimUseCase>(
      () => _i85.UpdateClaimUseCase(get<_i75.CredentialRepository>()));
  gh.factoryAsync<_i86.CreateAndSaveIdentityUseCase>(() async =>
      _i86.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i80.IdentityRepository>()));
  gh.factoryAsync<_i87.FetchIdentityStateUseCase>(
      () async => _i87.FetchIdentityStateUseCase(
            await get.getAsync<_i80.IdentityRepository>(),
            get<_i77.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i88.FetchStateRootsUseCase>(() async =>
      _i88.FetchStateRootsUseCase(
          await get.getAsync<_i80.IdentityRepository>()));
  gh.factoryAsync<_i89.GenerateNonRevProofUseCase>(
      () async => _i89.GenerateNonRevProofUseCase(
            await get.getAsync<_i80.IdentityRepository>(),
            get<_i75.CredentialRepository>(),
            get<_i77.GetEnvConfigUseCase>(),
            await get.getAsync<_i87.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i90.GetClaimRevocationStatusUseCase>(
      () async => _i90.GetClaimRevocationStatusUseCase(
            get<_i75.CredentialRepository>(),
            await get.getAsync<_i80.IdentityRepository>(),
            await get.getAsync<_i89.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i91.GetDidIdentifierUseCase>(() async =>
      _i91.GetDidIdentifierUseCase(
          await get.getAsync<_i80.IdentityRepository>()));
  gh.factoryAsync<_i92.GetIdentifierUseCase>(() async =>
      _i92.GetIdentifierUseCase(await get.getAsync<_i80.IdentityRepository>()));
  gh.factoryAsync<_i93.GetIdentityUseCase>(() async =>
      _i93.GetIdentityUseCase(await get.getAsync<_i80.IdentityRepository>()));
  gh.factory<_i94.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i79.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i95.Identity>(() async => _i95.Identity(
        await get.getAsync<_i86.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i93.GetIdentityUseCase>(),
        await get.getAsync<_i83.RemoveIdentityUseCase>(),
        await get.getAsync<_i92.GetIdentifierUseCase>(),
        await get.getAsync<_i84.SignMessageUseCase>(),
        await get.getAsync<_i87.FetchIdentityStateUseCase>(),
      ));
  gh.factory<_i96.IsProofCircuitSupportedUseCase>(
      () => _i96.IsProofCircuitSupportedUseCase(get<_i81.ProofRepository>()));
  gh.factoryAsync<_i97.GenerateProofUseCase>(
      () async => _i97.GenerateProofUseCase(
            get<_i81.ProofRepository>(),
            get<_i75.CredentialRepository>(),
            await get.getAsync<_i90.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i98.GetAuthTokenUseCase>(
      () async => _i98.GetAuthTokenUseCase(
            get<_i94.Iden3commRepository>(),
            get<_i81.ProofRepository>(),
            get<_i75.CredentialRepository>(),
            await get.getAsync<_i80.IdentityRepository>(),
          ));
  gh.factoryAsync<_i99.GetProofsUseCase>(() async => _i99.GetProofsUseCase(
        get<_i81.ProofRepository>(),
        await get.getAsync<_i80.IdentityRepository>(),
        get<_i76.GetClaimsUseCase>(),
        await get.getAsync<_i97.GenerateProofUseCase>(),
        get<_i96.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i100.Proof>(
      () async => _i100.Proof(await get.getAsync<_i97.GenerateProofUseCase>()));
  gh.factoryAsync<_i101.AuthenticateUseCase>(
      () async => _i101.AuthenticateUseCase(
            get<_i94.Iden3commRepository>(),
            await get.getAsync<_i99.GetProofsUseCase>(),
            await get.getAsync<_i98.GetAuthTokenUseCase>(),
            get<_i77.GetEnvConfigUseCase>(),
            await get.getAsync<_i71.GetPackageNameUseCase>(),
            await get.getAsync<_i91.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i102.FetchAndSaveClaimsUseCase>(
      () async => _i102.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i98.GetAuthTokenUseCase>(),
            get<_i75.CredentialRepository>(),
          ));
  gh.factoryAsync<_i103.Iden3comm>(() async => _i103.Iden3comm(
        get<_i78.GetVocabsUseCase>(),
        await get.getAsync<_i101.AuthenticateUseCase>(),
        await get.getAsync<_i99.GetProofsUseCase>(),
        get<_i60.Iden3MessageMapper>(),
        get<_i68.SchemaInfoMapper>(),
      ));
  gh.factoryAsync<_i104.Credential>(() async => _i104.Credential(
        await get.getAsync<_i102.FetchAndSaveClaimsUseCase>(),
        get<_i76.GetClaimsUseCase>(),
        get<_i82.RemoveClaimsUseCase>(),
        get<_i85.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$NetworkModule extends _i105.NetworkModule {}

class _$DatabaseModule extends _i105.DatabaseModule {}

class _$PackageInfoModule extends _i105.PackageInfoModule {}

class _$Sdk extends _i105.Sdk {}

class _$RepositoriesModule extends _i105.RepositoriesModule {}
