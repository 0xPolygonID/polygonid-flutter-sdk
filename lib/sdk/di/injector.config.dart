// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i32;
import 'package:sembast/sembast.dart' as _i12;
import 'package:web3dart/web3dart.dart' as _i54;

import '../../common/data/data_sources/env_datasource.dart' as _i64;
import '../../common/data/data_sources/package_info_datasource.dart' as _i33;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i76;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i34;
import '../../common/domain/repositories/config_repository.dart' as _i82;
import '../../common/domain/repositories/package_info_repository.dart' as _i71;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i85;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i78;
import '../../credential/data/credential_repository_impl.dart' as _i77;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i46;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i62;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i61;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i11;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i18;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i49;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i83;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i107;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i102;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i84;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i86;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i90;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i91;
import '../../env/sdk_env.dart' as _i51;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i43;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i47;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i60;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i10;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i63;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i65;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i20;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i40;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i41;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i42;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i72;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i87;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i92;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i111;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i101;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i109;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i23;
import '../../identity/data/data_sources/lib_babyjubjub_data_source.dart'
    as _i24;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i25;
import '../../identity/data/data_sources/lib_pidcore_data_source.dart' as _i69;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i26;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i48;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i73;
import '../../identity/data/data_sources/smt_data_source.dart' as _i80;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i68;
import '../../identity/data/data_sources/storage_smt_data_source.dart' as _i67;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i53;
import '../../identity/data/mappers/did_mapper.dart' as _i13;
import '../../identity/data/mappers/hash_mapper.dart' as _i16;
import '../../identity/data/mappers/hex_mapper.dart' as _i17;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i22;
import '../../identity/data/mappers/node_mapper.dart' as _i70;
import '../../identity/data/mappers/node_type_dto_mapper.dart' as _i28;
import '../../identity/data/mappers/node_type_entity_mapper.dart' as _i29;
import '../../identity/data/mappers/node_type_mapper.dart' as _i30;
import '../../identity/data/mappers/private_key_mapper.dart' as _i36;
import '../../identity/data/mappers/proof_mapper.dart' as _i39;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i74;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i50;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i52;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i88;
import '../../identity/data/repositories/smt_repository_impl.dart' as _i81;
import '../../identity/domain/repositories/identity_repository.dart' as _i93;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i97;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i98;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i99;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i100;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i103;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i104;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i105;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i95;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i96;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i19;
import '../../identity/libs/polygonidcore/polygonidcore.dart' as _i35;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i59;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i37;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i45;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i56;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i38;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i79;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i89;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i108;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i94;
import '../../proof_generation/libs/prover/prover.dart' as _i44;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i55;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i57;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i58;
import '../credential.dart' as _i112;
import '../iden3comm.dart' as _i113;
import '../identity.dart' as _i106;
import '../mappers/iden3_message_mapper.dart' as _i66;
import '../mappers/iden3_message_type_mapper.dart' as _i21;
import '../mappers/schema_info_mapper.dart' as _i75;
import '../proof.dart' as _i110;
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
  gh.lazySingletonAsync<_i12.Database>(() => databaseModule.database());
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
  gh.factory<_i23.JWZIsolatesWrapper>(() => _i23.JWZIsolatesWrapper());
  gh.factory<_i24.LibBabyJubJubDataSource>(
      () => _i24.LibBabyJubJubDataSource(get<_i5.BabyjubjubLib>()));
  gh.factory<_i25.LibIdentityDataSource>(
      () => _i25.LibIdentityDataSource(get<_i19.Iden3CoreLib>()));
  gh.factory<_i26.LocalContractFilesDataSource>(
      () => _i26.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i27.LocalProofFilesDataSource>(
      () => _i27.LocalProofFilesDataSource());
  gh.factory<Map<String, _i12.StoreRef<String, Map<String, Object?>>>>(
    () => databaseModule.securedStore,
    instanceName: 'securedStore',
  );
  gh.factory<_i28.NodeTypeDTOMapper>(() => _i28.NodeTypeDTOMapper());
  gh.factory<_i29.NodeTypeEntityMapper>(() => _i29.NodeTypeEntityMapper());
  gh.factory<_i30.NodeTypeMapper>(() => _i30.NodeTypeMapper());
  gh.factory<_i31.OfferRequestMapper>(
      () => _i31.OfferRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i32.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i33.PackageInfoDataSource>(() async =>
      _i33.PackageInfoDataSource(await get.getAsync<_i32.PackageInfo>()));
  gh.factoryAsync<_i34.PackageInfoRepositoryImpl>(() async =>
      _i34.PackageInfoRepositoryImpl(
          await get.getAsync<_i33.PackageInfoDataSource>()));
  gh.factory<_i35.PolygonIdCoreLib>(() => _i35.PolygonIdCoreLib());
  gh.factory<_i36.PrivateKeyMapper>(() => _i36.PrivateKeyMapper());
  gh.factory<_i37.ProofCircuitDataSource>(() => _i37.ProofCircuitDataSource());
  gh.factory<_i38.ProofMapper>(() => _i38.ProofMapper());
  gh.factory<_i39.ProofMapper>(() => _i39.ProofMapper(get<_i16.HashMapper>()));
  gh.factory<_i40.ProofQueryMapper>(() => _i40.ProofQueryMapper());
  gh.factory<_i41.ProofQueryParamMapper>(() => _i41.ProofQueryParamMapper());
  gh.factory<_i42.ProofRequestFiltersMapper>(
      () => _i42.ProofRequestFiltersMapper(get<_i40.ProofQueryMapper>()));
  gh.factory<_i43.ProofScopeDataSource>(() => _i43.ProofScopeDataSource());
  gh.factory<_i44.ProverLib>(() => _i44.ProverLib());
  gh.factory<_i45.ProverLibWrapper>(() => _i45.ProverLibWrapper());
  gh.factory<_i46.RemoteClaimDataSource>(
      () => _i46.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i47.RemoteIden3commDataSource>(
      () => _i47.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i48.RemoteIdentityDataSource>(
      () => _i48.RemoteIdentityDataSource());
  gh.factory<_i49.RevocationStatusMapper>(() => _i49.RevocationStatusMapper());
  gh.factory<_i50.RhsNodeTypeMapper>(() => _i50.RhsNodeTypeMapper());
  gh.lazySingleton<_i51.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i52.StateIdentifierMapper>(() => _i52.StateIdentifierMapper());
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i53.WalletLibWrapper>(() => _i53.WalletLibWrapper());
  gh.factory<_i54.Web3Client>(
      () => networkModule.web3Client(get<_i51.SdkEnv>()));
  gh.factory<_i55.WitnessAuthLib>(() => _i55.WitnessAuthLib());
  gh.factory<_i56.WitnessIsolatesWrapper>(() => _i56.WitnessIsolatesWrapper());
  gh.factory<_i57.WitnessMtpLib>(() => _i57.WitnessMtpLib());
  gh.factory<_i58.WitnessSigLib>(() => _i58.WitnessSigLib());
  gh.factory<_i59.AtomicQueryInputsWrapper>(
      () => _i59.AtomicQueryInputsWrapper(get<_i19.Iden3CoreLib>()));
  gh.factory<_i60.AuthRequestMapper>(
      () => _i60.AuthRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i61.ClaimMapper>(() => _i61.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i62.ClaimStoreRefWrapper>(() => _i62.ClaimStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i63.ContractRequestMapper>(
      () => _i63.ContractRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i64.EnvDataSource>(() => _i64.EnvDataSource(get<_i51.SdkEnv>()));
  gh.factory<_i65.FetchRequestMapper>(
      () => _i65.FetchRequestMapper(get<_i20.Iden3MessageTypeDataMapper>()));
  gh.factory<_i66.Iden3MessageMapper>(
      () => _i66.Iden3MessageMapper(get<_i21.Iden3MessageTypeMapper>()));
  gh.factory<_i67.IdentitySMTStoreRefWrapper>(() =>
      _i67.IdentitySMTStoreRefWrapper(
          get<Map<String, _i12.StoreRef<String, Map<String, Object?>>>>(
              instanceName: 'securedStore')));
  gh.factory<_i68.IdentityStoreRefWrapper>(() => _i68.IdentityStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i69.LibPolygonIdCoreDataSource>(
      () => _i69.LibPolygonIdCoreDataSource(get<_i35.PolygonIdCoreLib>()));
  gh.factory<_i70.NodeMapper>(() => _i70.NodeMapper(
        get<_i30.NodeTypeMapper>(),
        get<_i29.NodeTypeEntityMapper>(),
        get<_i28.NodeTypeDTOMapper>(),
        get<_i16.HashMapper>(),
      ));
  gh.factoryAsync<_i71.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i34.PackageInfoRepositoryImpl>()));
  gh.factory<_i72.ProofRequestsMapper>(() => _i72.ProofRequestsMapper(
        get<_i60.AuthRequestMapper>(),
        get<_i65.FetchRequestMapper>(),
        get<_i31.OfferRequestMapper>(),
        get<_i63.ContractRequestMapper>(),
        get<_i41.ProofQueryParamMapper>(),
      ));
  gh.factory<_i45.ProverLibDataSource>(
      () => _i45.ProverLibDataSource(get<_i45.ProverLibWrapper>()));
  gh.factory<_i73.RPCDataSource>(
      () => _i73.RPCDataSource(get<_i54.Web3Client>()));
  gh.factory<_i74.RhsNodeMapper>(
      () => _i74.RhsNodeMapper(get<_i50.RhsNodeTypeMapper>()));
  gh.factory<_i75.SchemaInfoMapper>(() => _i75.SchemaInfoMapper(
        get<_i60.AuthRequestMapper>(),
        get<_i63.ContractRequestMapper>(),
      ));
  gh.factory<_i62.StorageClaimDataSource>(
      () => _i62.StorageClaimDataSource(get<_i62.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i68.StorageIdentityDataSource>(
      () async => _i68.StorageIdentityDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i68.IdentityStoreRefWrapper>(),
          ));
  gh.factory<_i67.StorageSMTDataSource>(
      () => _i67.StorageSMTDataSource(get<_i67.IdentitySMTStoreRefWrapper>()));
  gh.factory<_i53.WalletDataSource>(
      () => _i53.WalletDataSource(get<_i53.WalletLibWrapper>()));
  gh.factory<_i56.WitnessDataSource>(
      () => _i56.WitnessDataSource(get<_i56.WitnessIsolatesWrapper>()));
  gh.factory<_i59.AtomicQueryInputsDataSource>(() =>
      _i59.AtomicQueryInputsDataSource(get<_i59.AtomicQueryInputsWrapper>()));
  gh.factory<_i76.ConfigRepositoryImpl>(
      () => _i76.ConfigRepositoryImpl(get<_i64.EnvDataSource>()));
  gh.factory<_i77.CredentialRepositoryImpl>(() => _i77.CredentialRepositoryImpl(
        get<_i46.RemoteClaimDataSource>(),
        get<_i62.StorageClaimDataSource>(),
        get<_i25.LibIdentityDataSource>(),
        get<_i11.CredentialRequestMapper>(),
        get<_i61.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i18.IdFilterMapper>(),
        get<_i49.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i78.GetPackageNameUseCase>(() async =>
      _i78.GetPackageNameUseCase(
          await get.getAsync<_i71.PackageInfoRepository>()));
  gh.factory<_i23.JWZDataSource>(() => _i23.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i53.WalletDataSource>(),
        get<_i23.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i79.ProofRepositoryImpl>(() => _i79.ProofRepositoryImpl(
        get<_i56.WitnessDataSource>(),
        get<_i45.ProverLibDataSource>(),
        get<_i59.AtomicQueryInputsDataSource>(),
        get<_i27.LocalProofFilesDataSource>(),
        get<_i37.ProofCircuitDataSource>(),
        get<_i48.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i72.ProofRequestsMapper>(),
        get<_i42.ProofRequestFiltersMapper>(),
        get<_i38.ProofMapper>(),
        get<_i61.ClaimMapper>(),
        get<_i49.RevocationStatusMapper>(),
      ));
  gh.factory<_i80.SMTDataSource>(() => _i80.SMTDataSource(
        get<_i17.HexMapper>(),
        get<_i24.LibBabyJubJubDataSource>(),
        get<_i67.StorageSMTDataSource>(),
      ));
  gh.factory<_i81.SMTRepositoryImpl>(() => _i81.SMTRepositoryImpl(
        get<_i80.SMTDataSource>(),
        get<_i67.StorageSMTDataSource>(),
        get<_i25.LibIdentityDataSource>(),
        get<_i70.NodeMapper>(),
        get<_i16.HashMapper>(),
        get<_i39.ProofMapper>(),
      ));
  gh.factory<_i82.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i76.ConfigRepositoryImpl>()));
  gh.factory<_i83.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i77.CredentialRepositoryImpl>()));
  gh.factory<_i84.GetClaimsUseCase>(
      () => _i84.GetClaimsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i85.GetEnvConfigUseCase>(
      () => _i85.GetEnvConfigUseCase(get<_i82.ConfigRepository>()));
  gh.factory<_i86.GetVocabsUseCase>(
      () => _i86.GetVocabsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i87.Iden3commRepositoryImpl>(() => _i87.Iden3commRepositoryImpl(
        get<_i47.RemoteIden3commDataSource>(),
        get<_i23.JWZDataSource>(),
        get<_i17.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
        get<_i60.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i88.IdentityRepositoryImpl>(
      () async => _i88.IdentityRepositoryImpl(
            get<_i53.WalletDataSource>(),
            get<_i25.LibIdentityDataSource>(),
            get<_i24.LibBabyJubJubDataSource>(),
            get<_i69.LibPolygonIdCoreDataSource>(),
            get<_i80.SMTDataSource>(),
            get<_i48.RemoteIdentityDataSource>(),
            await get.getAsync<_i68.StorageIdentityDataSource>(),
            get<_i73.RPCDataSource>(),
            get<_i26.LocalContractFilesDataSource>(),
            get<_i17.HexMapper>(),
            get<_i36.PrivateKeyMapper>(),
            get<_i22.IdentityDTOMapper>(),
            get<_i74.RhsNodeMapper>(),
            get<_i52.StateIdentifierMapper>(),
            get<_i13.DidMapper>(),
          ));
  gh.factory<_i89.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i79.ProofRepositoryImpl>()));
  gh.factory<_i90.RemoveClaimsUseCase>(
      () => _i90.RemoveClaimsUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i91.UpdateClaimUseCase>(
      () => _i91.UpdateClaimUseCase(get<_i83.CredentialRepository>()));
  gh.factory<_i92.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i87.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i93.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i88.IdentityRepositoryImpl>()));
  gh.factory<_i94.IsProofCircuitSupportedUseCase>(
      () => _i94.IsProofCircuitSupportedUseCase(get<_i89.ProofRepository>()));
  gh.factoryAsync<_i95.RemoveIdentityUseCase>(() async =>
      _i95.RemoveIdentityUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i96.SignMessageUseCase>(() async =>
      _i96.SignMessageUseCase(await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i97.CreateAndSaveIdentityUseCase>(() async =>
      _i97.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i98.FetchIdentityStateUseCase>(
      () async => _i98.FetchIdentityStateUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i99.FetchStateRootsUseCase>(() async =>
      _i99.FetchStateRootsUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i100.GenerateNonRevProofUseCase>(
      () async => _i100.GenerateNonRevProofUseCase(
            await get.getAsync<_i93.IdentityRepository>(),
            get<_i83.CredentialRepository>(),
            get<_i85.GetEnvConfigUseCase>(),
            await get.getAsync<_i98.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i101.GetAuthTokenUseCase>(
      () async => _i101.GetAuthTokenUseCase(
            get<_i92.Iden3commRepository>(),
            get<_i89.ProofRepository>(),
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i93.IdentityRepository>(),
          ));
  gh.factoryAsync<_i102.GetClaimRevocationStatusUseCase>(
      () async => _i102.GetClaimRevocationStatusUseCase(
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i93.IdentityRepository>(),
            await get.getAsync<_i100.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i103.GetDidIdentifierUseCase>(() async =>
      _i103.GetDidIdentifierUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i104.GetIdentifierUseCase>(() async =>
      _i104.GetIdentifierUseCase(
          await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i105.GetIdentityUseCase>(() async =>
      _i105.GetIdentityUseCase(await get.getAsync<_i93.IdentityRepository>()));
  gh.factoryAsync<_i106.Identity>(() async => _i106.Identity(
        await get.getAsync<_i97.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i105.GetIdentityUseCase>(),
        await get.getAsync<_i95.RemoveIdentityUseCase>(),
        await get.getAsync<_i104.GetIdentifierUseCase>(),
        await get.getAsync<_i96.SignMessageUseCase>(),
        await get.getAsync<_i98.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i107.FetchAndSaveClaimsUseCase>(
      () async => _i107.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i101.GetAuthTokenUseCase>(),
            get<_i83.CredentialRepository>(),
          ));
  gh.factoryAsync<_i108.GenerateProofUseCase>(
      () async => _i108.GenerateProofUseCase(
            get<_i89.ProofRepository>(),
            get<_i83.CredentialRepository>(),
            await get.getAsync<_i102.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i109.GetProofsUseCase>(() async => _i109.GetProofsUseCase(
        get<_i89.ProofRepository>(),
        await get.getAsync<_i93.IdentityRepository>(),
        get<_i84.GetClaimsUseCase>(),
        await get.getAsync<_i108.GenerateProofUseCase>(),
        get<_i94.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i110.Proof>(() async =>
      _i110.Proof(await get.getAsync<_i108.GenerateProofUseCase>()));
  gh.factoryAsync<_i111.AuthenticateUseCase>(
      () async => _i111.AuthenticateUseCase(
            get<_i92.Iden3commRepository>(),
            await get.getAsync<_i109.GetProofsUseCase>(),
            await get.getAsync<_i101.GetAuthTokenUseCase>(),
            get<_i85.GetEnvConfigUseCase>(),
            await get.getAsync<_i78.GetPackageNameUseCase>(),
            await get.getAsync<_i103.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i112.Credential>(() async => _i112.Credential(
        await get.getAsync<_i107.FetchAndSaveClaimsUseCase>(),
        get<_i84.GetClaimsUseCase>(),
        get<_i90.RemoveClaimsUseCase>(),
        get<_i91.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i113.Iden3comm>(() async => _i113.Iden3comm(
        get<_i86.GetVocabsUseCase>(),
        await get.getAsync<_i111.AuthenticateUseCase>(),
        await get.getAsync<_i109.GetProofsUseCase>(),
        get<_i66.Iden3MessageMapper>(),
        get<_i75.SchemaInfoMapper>(),
      ));
  return get;
}

class _$PlatformModule extends _i114.PlatformModule {}

class _$NetworkModule extends _i114.NetworkModule {}

class _$DatabaseModule extends _i114.DatabaseModule {}

class _$Sdk extends _i114.Sdk {}

class _$RepositoriesModule extends _i114.RepositoriesModule {}
