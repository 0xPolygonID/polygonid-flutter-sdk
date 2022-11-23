// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i33;
import 'package:sembast/sembast.dart' as _i12;
import 'package:web3dart/web3dart.dart' as _i55;

import '../../common/data/data_sources/env_datasource.dart' as _i65;
import '../../common/data/data_sources/package_info_datasource.dart' as _i34;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i78;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i35;
import '../../common/domain/repositories/config_repository.dart' as _i83;
import '../../common/domain/repositories/package_info_repository.dart' as _i71;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i86;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i80;
import '../../credential/data/credential_repository_impl.dart' as _i79;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i47;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i63;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i62;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i11;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i18;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i50;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i84;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i111;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i99;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i85;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i87;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i91;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i94;
import '../../env/sdk_env.dart' as _i52;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i44;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i48;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i61;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i10;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i64;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i66;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i20;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i41;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i42;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i43;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i72;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i88;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i103;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i110;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i107;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i108;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i24;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i25;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i26;
import '../../identity/data/data_sources/lib_pidcore_data_source.dart' as _i69;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i27;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i49;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i73;
import '../../identity/data/data_sources/smt_data_source.dart' as _i75;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i68;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i23;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i54;
import '../../identity/data/mappers/did_mapper.dart' as _i13;
import '../../identity/data/mappers/hash_mapper.dart' as _i16;
import '../../identity/data/mappers/hex_mapper.dart' as _i17;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i22;
import '../../identity/data/mappers/node_mapper.dart' as _i70;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i29;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i30;
import '../../identity/data/mappers/node_type_mapper.dart' as _i31;
import '../../identity/data/mappers/private_key_mapper.dart' as _i37;
import '../../identity/data/mappers/proof_mapper.dart' as _i39;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i74;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i51;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i53;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i81;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i76;
import '../../identity/domain/repositories/identity_repository.dart' as _i89;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i95;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i96;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i97;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i98;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i100;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i101;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i102;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i92;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i93;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i19;
import '../../identity/libs/polygonidcore/polygonidcore.dart' as _i36;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i60;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i28;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i38;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i46;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i57;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i40;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i82;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i90;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i106;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i105;
import '../../proof_generation/libs/prover/prover.dart' as _i45;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i56;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i58;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i59;
import '../credential.dart' as _i113;
import '../iden3comm.dart' as _i112;
import '../identity.dart' as _i104;
import '../mappers/iden3_message_mapper.dart' as _i67;
import '../mappers/iden3_message_type_mapper.dart' as _i21;
import '../mappers/schema_info_mapper.dart' as _i77;
import '../proof.dart' as _i109;
import 'injector.dart' as _i114; // ignore_for_file: unnecessary_lambdas

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
  final sdk = _$Sdk();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i3.AssetBundle>(() => platformModule.assetBundle);
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.CircuitTypeMapper>(() => _i6.CircuitTypeMapper());
  gh.factory<_i7.ClaimInfoMapper>(() => _i7.ClaimInfoMapper());
  gh.factory<_i8.ClaimStateMapper>(() => _i8.ClaimStateMapper());
  gh.factory<_i9.Client>(() => networkModule.client);
  gh.factory<_i10.ContractFuncCallMapper>(() => _i10.ContractFuncCallMapper());
  gh.factory<_i11.CredentialRequestMapper>(
      () => _i11.CredentialRequestMapper());
  gh.factoryParamAsync<_i12.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i12.Database>(() => databaseModule.database());
  gh.factory<_i13.DidMapper>(() => _i13.DidMapper());
  gh.factory<_i14.FilterMapper>(() => _i14.FilterMapper());
  gh.factory<_i15.FiltersMapper>(
      () => _i15.FiltersMapper(get<_i14.FilterMapper>()));
  gh.factory<_i16.HashMapper>(() => _i16.HashMapper());
  gh.factory<_i17.HexMapper>(() => _i17.HexMapper());
  gh.factory<_i18.IdFilterMapper>(() => _i18.IdFilterMapper());
  gh.factory<_i19.Iden3CoreLib>(() => _i19.Iden3CoreLib());
  gh.factory<_i20.Iden3MessageTypeDataMapper>(
      () => _i20.Iden3MessageTypeDataMapper());
  gh.factory<_i21.Iden3MessageTypeMapper>(() => _i21.Iden3MessageTypeMapper());
  gh.factory<_i22.IdentityDTOMapper>(() => _i22.IdentityDTOMapper());
  gh.factory<_i23.IdentitySMTStoreRefWrapper>(
      () => _i23.IdentitySMTStoreRefWrapper());
  gh.factory<_i24.JWZIsolatesWrapper>(() => _i24.JWZIsolatesWrapper());
  gh.factory<_i25.LibBabyJubJubDataSource>(
      () => _i25.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i26.LibIdentityDataSource>(
      () => _i26.LibIdentityDataSource(get<_i19.Iden3CoreLib>()));
  gh.factory<_i27.LocalContractFilesDataSource>(
      () => _i27.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i28.LocalProofFilesDataSource>(
      () => _i28.LocalProofFilesDataSource());
  gh.factory<_i29.NodeTypeDTOMapper>(() => _i29.NodeTypeDTOMapper());
  gh.factory<_i30.NodeTypeEntityMapper>(() => _i30.NodeTypeEntityMapper());
  gh.factory<_i31.NodeTypeMapper>(() => _i31.NodeTypeMapper());
  gh.factory<_i32.OfferRequestMapper>(
      () => _i32.OfferRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i33.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i34.PackageInfoDataSource>(() async =>
      _i34.PackageInfoDataSource(await get.getAsync<_i33.PackageInfo>()));
  gh.factoryAsync<_i35.PackageInfoRepositoryImpl>(() async =>
      _i35.PackageInfoRepositoryImpl(
          await get.getAsync<_i34.PackageInfoDataSource>()));
  gh.factory<_i36.PolygonIdCoreLib>(() => _i36.PolygonIdCoreLib());
  gh.factory<_i37.PrivateKeyMapper>(() => _i37.PrivateKeyMapper());
  gh.factory<_i38.ProofCircuitDataSource>(() => _i38.ProofCircuitDataSource());
  gh.factory<_i39.ProofMapper>(() => _i39.ProofMapper(get<_i16.HashMapper>()));
  gh.factory<_i40.ProofMapper>(() => _i40.ProofMapper());
  gh.factory<_i41.ProofQueryMapper>(() => _i41.ProofQueryMapper());
  gh.factory<_i42.ProofQueryParamMapper>(() => _i42.ProofQueryParamMapper());
  gh.factory<_i43.ProofRequestFiltersMapper>(
      () => _i43.ProofRequestFiltersMapper(get<_i41.ProofQueryMapper>()));
  gh.factory<_i44.ProofScopeDataSource>(() => _i44.ProofScopeDataSource());
  gh.factory<_i45.ProverLib>(() => _i45.ProverLib());
  gh.factory<_i46.ProverLibWrapper>(() => _i46.ProverLibWrapper());
  gh.factory<_i47.RemoteClaimDataSource>(
      () => _i47.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i48.RemoteIden3commDataSource>(
      () => _i48.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i49.RemoteIdentityDataSource>(
      () => _i49.RemoteIdentityDataSource());
  gh.factory<_i50.RevocationStatusMapper>(() => _i50.RevocationStatusMapper());
  gh.factory<_i51.RhsNodeTypeMapper>(() => _i51.RhsNodeTypeMapper());
  gh.lazySingleton<_i52.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i53.StateIdentifierMapper>(() => _i53.StateIdentifierMapper());
  gh.factory<_i23.StorageSMTDataSource>(
      () => _i23.StorageSMTDataSource(get<_i23.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.rootsTreeStore,
    instanceName: 'rootsTreeStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.revocationTreeStore,
    instanceName: 'revocationTreeStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimsTreeStore,
    instanceName: 'claimsTreeStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i54.WalletLibWrapper>(() => _i54.WalletLibWrapper());
  gh.factory<_i55.Web3Client>(
      () => networkModule.web3Client(get<_i52.SdkEnv>()));
  gh.factory<_i56.WitnessAuthLib>(() => _i56.WitnessAuthLib());
  gh.factory<_i57.WitnessIsolatesWrapper>(() => _i57.WitnessIsolatesWrapper());
  gh.factory<_i58.WitnessMtpLib>(() => _i58.WitnessMtpLib());
  gh.factory<_i59.WitnessSigLib>(() => _i59.WitnessSigLib());
  gh.factory<_i60.AtomicQueryInputsWrapper>(
      () => _i60.AtomicQueryInputsWrapper(get<_i19.Iden3CoreLib>()));
  gh.factory<_i61.AuthRequestMapper>(
      () => _i61.AuthRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i62.ClaimMapper>(() => _i62.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i63.ClaimStoreRefWrapper>(() => _i63.ClaimStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i64.ContractRequestMapper>(
      () => _i64.ContractRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i65.EnvDataSource>(() => _i65.EnvDataSource(get<_i52.SdkEnv>()));
  gh.factory<_i66.FetchRequestMapper>(
      () => _i66.FetchRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i67.Iden3MessageMapper>(
      () => _i67.Iden3MessageMapper(get<_i21.Iden3MessageTypeMapper>()));
  gh.factory<_i68.IdentityStoreRefWrapper>(() => _i68.IdentityStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i69.LibPolygonIdCoreDataSource>(
      () => _i69.LibPolygonIdCoreDataSource(get<_i36.PolygonIdCoreLib>()));
  gh.factory<_i70.NodeMapper>(() => _i70.NodeMapper(
        get<_i31.NodeTypeMapper>(),
        get<_i30.NodeTypeEntityMapper>(),
        get<_i29.NodeTypeDTOMapper>(),
        get<_i16.HashMapper>(),
      ));
  gh.factoryAsync<_i71.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i35.PackageInfoRepositoryImpl>()));
  gh.factory<_i72.ProofRequestsMapper>(() => _i72.ProofRequestsMapper(
        get<_i61.AuthRequestMapper>(),
        get<_i66.FetchRequestMapper>(),
        get<_i32.OfferRequestMapper>(),
        get<_i64.ContractRequestMapper>(),
        get<_i42.ProofQueryParamMapper>(),
      ));
  gh.factory<_i46.ProverLibDataSource>(
      () => _i46.ProverLibDataSource(get<_i46.ProverLibWrapper>()));
  gh.factory<_i73.RPCDataSource>(
      () => _i73.RPCDataSource(get<_i55.Web3Client>()));
  gh.factory<_i74.RhsNodeMapper>(
      () => _i74.RhsNodeMapper(get<_i51.RhsNodeTypeMapper>()));
  gh.factory<_i75.SMTDataSource>(() => _i75.SMTDataSource(
        get<_i17.HexMapper>(),
        get<_i25.LibBabyJubJubDataSource>(),
        get<_i23.StorageSMTDataSource>(),
      ));
  gh.factory<_i76.SMTRepositoryImpl>(() => _i76.SMTRepositoryImpl(
        get<_i75.SMTDataSource>(),
        get<_i23.StorageSMTDataSource>(),
        get<_i26.LibIdentityDataSource>(),
        get<_i70.NodeMapper>(),
        get<_i16.HashMapper>(),
        get<_i39.ProofMapper>(),
      ));
  gh.factory<_i77.SchemaInfoMapper>(() => _i77.SchemaInfoMapper(
        get<_i61.AuthRequestMapper>(),
        get<_i64.ContractRequestMapper>(),
      ));
  gh.factory<_i63.StorageClaimDataSource>(
      () => _i63.StorageClaimDataSource(get<_i63.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i68.StorageIdentityDataSource>(
      () async => _i68.StorageIdentityDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i68.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i54.WalletDataSource>(
      () => _i54.WalletDataSource(get<_i54.WalletLibWrapper>()));
  gh.factory<_i57.WitnessDataSource>(
      () => _i57.WitnessDataSource(get<_i57.WitnessIsolatesWrapper>()));
  gh.factory<_i60.AtomicQueryInputsDataSource>(() =>
      _i60.AtomicQueryInputsDataSource(get<_i60.AtomicQueryInputsWrapper>()));
  gh.factory<_i78.ConfigRepositoryImpl>(
      () => _i78.ConfigRepositoryImpl(get<_i65.EnvDataSource>()));
  gh.factory<_i79.CredentialRepositoryImpl>(() => _i79.CredentialRepositoryImpl(
        get<_i47.RemoteClaimDataSource>(),
        get<_i63.StorageClaimDataSource>(),
        get<_i26.LibIdentityDataSource>(),
        get<_i11.CredentialRequestMapper>(),
        get<_i62.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i18.IdFilterMapper>(),
        get<_i50.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i80.GetPackageNameUseCase>(() async =>
      _i80.GetPackageNameUseCase(
          await get.getAsync<_i71.PackageInfoRepository>()));
  gh.factoryAsync<_i81.IdentityRepositoryImpl>(
      () async => _i81.IdentityRepositoryImpl(
            get<_i54.WalletDataSource>(),
            get<_i26.LibIdentityDataSource>(),
            get<_i69.LibPolygonIdCoreDataSource>(),
            get<_i49.RemoteIdentityDataSource>(),
            await get.getAsync<_i68.StorageIdentityDataSource>(),
            get<_i73.RPCDataSource>(),
            get<_i27.LocalContractFilesDataSource>(),
            get<_i17.HexMapper>(),
            get<_i37.PrivateKeyMapper>(),
            get<_i22.IdentityDTOMapper>(),
            get<_i74.RhsNodeMapper>(),
            get<_i53.StateIdentifierMapper>(),
            get<_i13.DidMapper>(),
          ));
  gh.factory<_i24.JWZDataSource>(() => _i24.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i54.WalletDataSource>(),
        get<_i24.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i82.ProofRepositoryImpl>(() => _i82.ProofRepositoryImpl(
        get<_i57.WitnessDataSource>(),
        get<_i46.ProverLibDataSource>(),
        get<_i60.AtomicQueryInputsDataSource>(),
        get<_i28.LocalProofFilesDataSource>(),
        get<_i38.ProofCircuitDataSource>(),
        get<_i49.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i72.ProofRequestsMapper>(),
        get<_i43.ProofRequestFiltersMapper>(),
        get<_i40.ProofMapper>(),
        get<_i62.ClaimMapper>(),
        get<_i50.RevocationStatusMapper>(),
      ));
  gh.factory<_i83.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i78.ConfigRepositoryImpl>()));
  gh.factory<_i84.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i79.CredentialRepositoryImpl>()));
  gh.factory<_i85.GetClaimsUseCase>(
      () => _i85.GetClaimsUseCase(get<_i84.CredentialRepository>()));
  gh.factory<_i86.GetEnvConfigUseCase>(
      () => _i86.GetEnvConfigUseCase(get<_i83.ConfigRepository>()));
  gh.factory<_i87.GetVocabsUseCase>(
      () => _i87.GetVocabsUseCase(get<_i84.CredentialRepository>()));
  gh.factory<_i88.Iden3commRepositoryImpl>(() => _i88.Iden3commRepositoryImpl(
        get<_i48.RemoteIden3commDataSource>(),
        get<_i24.JWZDataSource>(),
        get<_i17.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
        get<_i61.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i89.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i81.IdentityRepositoryImpl>()));
  gh.factory<_i90.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i82.ProofRepositoryImpl>()));
  gh.factory<_i91.RemoveClaimsUseCase>(
      () => _i91.RemoveClaimsUseCase(get<_i84.CredentialRepository>()));
  gh.factoryAsync<_i92.RemoveIdentityUseCase>(() async =>
      _i92.RemoveIdentityUseCase(
          await get.getAsync<_i89.IdentityRepository>()));
  gh.factoryAsync<_i93.SignMessageUseCase>(() async =>
      _i93.SignMessageUseCase(await get.getAsync<_i89.IdentityRepository>()));
  gh.factory<_i94.UpdateClaimUseCase>(
      () => _i94.UpdateClaimUseCase(get<_i84.CredentialRepository>()));
  gh.factoryAsync<_i95.CreateAndSaveIdentityUseCase>(() async =>
      _i95.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i89.IdentityRepository>()));
  gh.factoryAsync<_i96.FetchIdentityStateUseCase>(
      () async => _i96.FetchIdentityStateUseCase(
            await get.getAsync<_i89.IdentityRepository>(),
            get<_i86.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i97.FetchStateRootsUseCase>(() async =>
      _i97.FetchStateRootsUseCase(
          await get.getAsync<_i89.IdentityRepository>()));
  gh.factoryAsync<_i98.GenerateNonRevProofUseCase>(
      () async => _i98.GenerateNonRevProofUseCase(
            await get.getAsync<_i89.IdentityRepository>(),
            get<_i84.CredentialRepository>(),
            get<_i86.GetEnvConfigUseCase>(),
            await get.getAsync<_i96.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i99.GetClaimRevocationStatusUseCase>(
      () async => _i99.GetClaimRevocationStatusUseCase(
            get<_i84.CredentialRepository>(),
            await get.getAsync<_i89.IdentityRepository>(),
            await get.getAsync<_i98.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i100.GetDidIdentifierUseCase>(() async =>
      _i100.GetDidIdentifierUseCase(
          await get.getAsync<_i89.IdentityRepository>()));
  gh.factoryAsync<_i101.GetIdentifierUseCase>(() async =>
      _i101.GetIdentifierUseCase(
          await get.getAsync<_i89.IdentityRepository>()));
  gh.factoryAsync<_i102.GetIdentityUseCase>(() async =>
      _i102.GetIdentityUseCase(await get.getAsync<_i89.IdentityRepository>()));
  gh.factory<_i103.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i88.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i104.Identity>(() async => _i104.Identity(
        await get.getAsync<_i95.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i102.GetIdentityUseCase>(),
        await get.getAsync<_i92.RemoveIdentityUseCase>(),
        await get.getAsync<_i101.GetIdentifierUseCase>(),
        await get.getAsync<_i93.SignMessageUseCase>(),
        await get.getAsync<_i96.FetchIdentityStateUseCase>(),
      ));
  gh.factory<_i105.IsProofCircuitSupportedUseCase>(
      () => _i105.IsProofCircuitSupportedUseCase(get<_i90.ProofRepository>()));
  gh.factoryAsync<_i106.GenerateProofUseCase>(
      () async => _i106.GenerateProofUseCase(
            get<_i90.ProofRepository>(),
            get<_i84.CredentialRepository>(),
            await get.getAsync<_i99.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i107.GetAuthTokenUseCase>(
      () async => _i107.GetAuthTokenUseCase(
            get<_i103.Iden3commRepository>(),
            get<_i90.ProofRepository>(),
            get<_i84.CredentialRepository>(),
            await get.getAsync<_i89.IdentityRepository>(),
          ));
  gh.factoryAsync<_i108.GetProofsUseCase>(() async => _i108.GetProofsUseCase(
        get<_i90.ProofRepository>(),
        await get.getAsync<_i89.IdentityRepository>(),
        get<_i85.GetClaimsUseCase>(),
        await get.getAsync<_i106.GenerateProofUseCase>(),
        get<_i105.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i109.Proof>(() async =>
      _i109.Proof(await get.getAsync<_i106.GenerateProofUseCase>()));
  gh.factoryAsync<_i110.AuthenticateUseCase>(
      () async => _i110.AuthenticateUseCase(
            get<_i103.Iden3commRepository>(),
            await get.getAsync<_i108.GetProofsUseCase>(),
            await get.getAsync<_i107.GetAuthTokenUseCase>(),
            get<_i86.GetEnvConfigUseCase>(),
            await get.getAsync<_i80.GetPackageNameUseCase>(),
            await get.getAsync<_i100.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i111.FetchAndSaveClaimsUseCase>(
      () async => _i111.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i107.GetAuthTokenUseCase>(),
            get<_i84.CredentialRepository>(),
          ));
  gh.factoryAsync<_i112.Iden3comm>(() async => _i112.Iden3comm(
        get<_i87.GetVocabsUseCase>(),
        await get.getAsync<_i110.AuthenticateUseCase>(),
        await get.getAsync<_i108.GetProofsUseCase>(),
        get<_i67.Iden3MessageMapper>(),
        get<_i77.SchemaInfoMapper>(),
      ));
  gh.factoryAsync<_i113.Credential>(() async => _i113.Credential(
        await get.getAsync<_i111.FetchAndSaveClaimsUseCase>(),
        get<_i85.GetClaimsUseCase>(),
        get<_i91.RemoveClaimsUseCase>(),
        get<_i94.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i114.PlatformModule {}

class _$NetworkModule extends _i114.NetworkModule {}

class _$DatabaseModule extends _i114.DatabaseModule {}

class _$Sdk extends _i114.Sdk {}

class _$RepositoriesModule extends _i114.RepositoriesModule {}
