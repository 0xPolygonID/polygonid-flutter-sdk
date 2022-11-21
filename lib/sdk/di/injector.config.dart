// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i28;
import 'package:sembast/sembast.dart' as _i12;
import 'package:web3dart/web3dart.dart' as _i48;

import '../../common/data/data_sources/env_datasource.dart' as _i58;
import '../../common/data/data_sources/package_info_datasource.dart' as _i29;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i68;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i30;
import '../../common/domain/repositories/config_repository.dart' as _i72;
import '../../common/domain/repositories/package_info_repository.dart' as _i63;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i75;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i70;
import '../../credential/data/credential_repository_impl.dart' as _i69;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i40;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i56;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i55;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i11;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i17;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i43;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i73;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i97;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i92;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i74;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i76;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i80;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i81;
import '../../env/sdk_env.dart' as _i45;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i37;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i41;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i54;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i10;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i19;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i27;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i36;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i64;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i77;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i82;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i101;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i91;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i99;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i22;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i23;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i24;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i42;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i65;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i62;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i47;
import '../../identity/data/mappers/did_mapper.dart' as _i13;
import '../../identity/data/mappers/hex_mapper.dart' as _i16;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i21;
import '../../identity/data/mappers/private_key_mapper.dart' as _i31;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i66;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i44;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i46;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i78;
import '../../identity/domain/repositories/identity_repository.dart' as _i83;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i94;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i95;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i85;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i86;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i18;
import '../../identity/libs/smt/node.dart' as _i26;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i53;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i25;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i32;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i50;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i33;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i71;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i79;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i98;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i84;
import '../../proof_generation/libs/prover/prover.dart' as _i38;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i52;
import '../credential.dart' as _i102;
import '../iden3comm.dart' as _i103;
import '../identity.dart' as _i96;
import '../mappers/iden3_message_mapper.dart' as _i60;
import '../mappers/iden3_message_type_mapper.dart' as _i20;
import '../mappers/schema_info_mapper.dart' as _i67;
import '../proof.dart' as _i100;
import 'injector.dart' as _i104; // ignore_for_file: unnecessary_lambdas

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
        databaseModule.claimDatabase(
      identifier,
      privateKey,
    ),
    instanceName: 'polygonIdSdkClaims',
  );
  gh.factory<_i13.DidMapper>(() => _i13.DidMapper());
  gh.factory<_i14.FilterMapper>(() => _i14.FilterMapper());
  gh.factory<_i15.FiltersMapper>(
      () => _i15.FiltersMapper(get<_i14.FilterMapper>()));
  gh.factory<_i16.HexMapper>(() => _i16.HexMapper());
  gh.factory<_i17.IdFilterMapper>(() => _i17.IdFilterMapper());
  gh.factory<_i18.Iden3CoreLib>(() => _i18.Iden3CoreLib());
  gh.factory<_i19.Iden3MessageTypeDataMapper>(
      () => _i19.Iden3MessageTypeDataMapper());
  gh.factory<_i20.Iden3MessageTypeMapper>(() => _i20.Iden3MessageTypeMapper());
  gh.factory<_i21.IdentityDTOMapper>(() => _i21.IdentityDTOMapper());
  gh.factory<_i22.JWZIsolatesWrapper>(() => _i22.JWZIsolatesWrapper());
  gh.factory<_i23.LibIdentityDataSource>(
      () => _i23.LibIdentityDataSource(get<_i18.Iden3CoreLib>()));
  gh.factory<_i24.LocalContractFilesDataSource>(
      () => _i24.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i25.LocalProofFilesDataSource>(
      () => _i25.LocalProofFilesDataSource());
  gh.factory<_i26.Node>(() => _i26.Node(
        get<_i26.NodeType>(),
        get<_i18.Iden3CoreLib>(),
      ));
  gh.factory<_i27.OfferRequestMapper>(
      () => _i27.OfferRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.lazySingletonAsync<_i28.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i29.PackageInfoDataSource>(() async =>
      _i29.PackageInfoDataSource(await get.getAsync<_i28.PackageInfo>()));
  gh.factoryAsync<_i30.PackageInfoRepositoryImpl>(() async =>
      _i30.PackageInfoRepositoryImpl(
          await get.getAsync<_i29.PackageInfoDataSource>()));
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
      () => _i40.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i41.RemoteIden3commDataSource>(
      () => _i41.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i42.RemoteIdentityDataSource>(
      () => _i42.RemoteIdentityDataSource());
  gh.factory<_i43.RevocationStatusMapper>(() => _i43.RevocationStatusMapper());
  gh.factory<_i44.RhsNodeTypeMapper>(() => _i44.RhsNodeTypeMapper());
  gh.lazySingleton<_i45.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i46.StateIdentifierMapper>(() => _i46.StateIdentifierMapper());
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i12.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i47.WalletLibWrapper>(() => _i47.WalletLibWrapper());
  gh.factory<_i48.Web3Client>(
      () => networkModule.web3Client(get<_i45.SdkEnv>()));
  gh.factory<_i49.WitnessAuthLib>(() => _i49.WitnessAuthLib());
  gh.factory<_i50.WitnessIsolatesWrapper>(() => _i50.WitnessIsolatesWrapper());
  gh.factory<_i51.WitnessMtpLib>(() => _i51.WitnessMtpLib());
  gh.factory<_i52.WitnessSigLib>(() => _i52.WitnessSigLib());
  gh.factory<_i53.AtomicQueryInputsWrapper>(
      () => _i53.AtomicQueryInputsWrapper(get<_i18.Iden3CoreLib>()));
  gh.factory<_i54.AuthRequestMapper>(
      () => _i54.AuthRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i55.ClaimMapper>(() => _i55.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i56.ClaimStoreRefWrapper>(() => _i56.ClaimStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i57.ContractRequestMapper>(
      () => _i57.ContractRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.EnvDataSource>(() => _i58.EnvDataSource(get<_i45.SdkEnv>()));
  gh.factory<_i59.FetchRequestMapper>(
      () => _i59.FetchRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.Iden3MessageMapper>(
      () => _i60.Iden3MessageMapper(get<_i20.Iden3MessageTypeMapper>()));
  gh.factory<_i61.IdentityStoreRefWrapper>(() => _i61.IdentityStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i62.KeyValueStoreRefWrapper>(() => _i62.KeyValueStoreRefWrapper(
      get<_i12.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i63.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i30.PackageInfoRepositoryImpl>()));
  gh.factory<_i64.ProofRequestsMapper>(() => _i64.ProofRequestsMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i59.FetchRequestMapper>(),
        get<_i27.OfferRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
        get<_i35.ProofQueryParamMapper>(),
      ));
  gh.factory<_i39.ProverLibDataSource>(
      () => _i39.ProverLibDataSource(get<_i39.ProverLibWrapper>()));
  gh.factory<_i65.RPCDataSource>(
      () => _i65.RPCDataSource(get<_i48.Web3Client>()));
  gh.factory<_i66.RhsNodeMapper>(
      () => _i66.RhsNodeMapper(get<_i44.RhsNodeTypeMapper>()));
  gh.factory<_i67.SchemaInfoMapper>(() => _i67.SchemaInfoMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
      ));
  gh.factory<_i56.StorageClaimDataSource>(
      () => _i56.StorageClaimDataSource(get<_i56.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i62.StorageKeyValueDataSource>(
      () async => _i62.StorageKeyValueDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i62.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i47.WalletDataSource>(
      () => _i47.WalletDataSource(get<_i47.WalletLibWrapper>()));
  gh.factory<_i50.WitnessDataSource>(
      () => _i50.WitnessDataSource(get<_i50.WitnessIsolatesWrapper>()));
  gh.factory<_i53.AtomicQueryInputsDataSource>(() =>
      _i53.AtomicQueryInputsDataSource(get<_i53.AtomicQueryInputsWrapper>()));
  gh.factory<_i68.ConfigRepositoryImpl>(
      () => _i68.ConfigRepositoryImpl(get<_i58.EnvDataSource>()));
  gh.factory<_i69.CredentialRepositoryImpl>(() => _i69.CredentialRepositoryImpl(
        get<_i40.RemoteClaimDataSource>(),
        get<_i56.StorageClaimDataSource>(),
        get<_i23.LibIdentityDataSource>(),
        get<_i11.CredentialRequestMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i17.IdFilterMapper>(),
        get<_i43.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i70.GetPackageNameUseCase>(() async =>
      _i70.GetPackageNameUseCase(
          await get.getAsync<_i63.PackageInfoRepository>()));
  gh.factory<_i22.JWZDataSource>(() => _i22.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i47.WalletDataSource>(),
        get<_i22.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i71.ProofRepositoryImpl>(() => _i71.ProofRepositoryImpl(
        get<_i50.WitnessDataSource>(),
        get<_i39.ProverLibDataSource>(),
        get<_i53.AtomicQueryInputsDataSource>(),
        get<_i25.LocalProofFilesDataSource>(),
        get<_i32.ProofCircuitDataSource>(),
        get<_i42.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i64.ProofRequestsMapper>(),
        get<_i36.ProofRequestFiltersMapper>(),
        get<_i33.ProofMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i43.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i61.StorageIdentityDataSource>(
      () async => _i61.StorageIdentityDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i61.IdentityStoreRefWrapper>(),
            await get.getAsync<_i62.StorageKeyValueDataSource>(),
            get<_i47.WalletDataSource>(),
            get<_i16.HexMapper>(),
          ));
  gh.factory<_i72.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i68.ConfigRepositoryImpl>()));
  gh.factory<_i73.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i69.CredentialRepositoryImpl>()));
  gh.factory<_i74.GetClaimsUseCase>(
      () => _i74.GetClaimsUseCase(get<_i73.CredentialRepository>()));
  gh.factory<_i75.GetEnvConfigUseCase>(
      () => _i75.GetEnvConfigUseCase(get<_i72.ConfigRepository>()));
  gh.factory<_i76.GetVocabsUseCase>(
      () => _i76.GetVocabsUseCase(get<_i73.CredentialRepository>()));
  gh.factory<_i77.Iden3commRepositoryImpl>(() => _i77.Iden3commRepositoryImpl(
        get<_i41.RemoteIden3commDataSource>(),
        get<_i22.JWZDataSource>(),
        get<_i16.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
        get<_i54.AuthRequestMapper>(),
      ));
  gh.factoryAsync<_i78.IdentityRepositoryImpl>(
      () async => _i78.IdentityRepositoryImpl(
            get<_i47.WalletDataSource>(),
            get<_i23.LibIdentityDataSource>(),
            get<_i42.RemoteIdentityDataSource>(),
            await get.getAsync<_i61.StorageIdentityDataSource>(),
            get<_i65.RPCDataSource>(),
            get<_i24.LocalContractFilesDataSource>(),
            get<_i16.HexMapper>(),
            get<_i31.PrivateKeyMapper>(),
            get<_i21.IdentityDTOMapper>(),
            get<_i66.RhsNodeMapper>(),
            get<_i46.StateIdentifierMapper>(),
            get<_i13.DidMapper>(),
          ));
  gh.factory<_i79.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i71.ProofRepositoryImpl>()));
  gh.factory<_i80.RemoveClaimsUseCase>(
      () => _i80.RemoveClaimsUseCase(get<_i73.CredentialRepository>()));
  gh.factory<_i81.UpdateClaimUseCase>(
      () => _i81.UpdateClaimUseCase(get<_i73.CredentialRepository>()));
  gh.factory<_i82.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i77.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i83.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i78.IdentityRepositoryImpl>()));
  gh.factory<_i84.IsProofCircuitSupportedUseCase>(
      () => _i84.IsProofCircuitSupportedUseCase(get<_i79.ProofRepository>()));
  gh.factoryAsync<_i85.RemoveIdentityUseCase>(() async =>
      _i85.RemoveIdentityUseCase(
          await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i86.SignMessageUseCase>(() async =>
      _i86.SignMessageUseCase(await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i87.CreateAndSaveIdentityUseCase>(() async =>
      _i87.CreateAndSaveIdentityUseCase(
          await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i88.FetchIdentityStateUseCase>(
      () async => _i88.FetchIdentityStateUseCase(
            await get.getAsync<_i83.IdentityRepository>(),
            get<_i75.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i89.FetchStateRootsUseCase>(() async =>
      _i89.FetchStateRootsUseCase(
          await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i90.GenerateNonRevProofUseCase>(
      () async => _i90.GenerateNonRevProofUseCase(
            await get.getAsync<_i83.IdentityRepository>(),
            get<_i73.CredentialRepository>(),
            get<_i75.GetEnvConfigUseCase>(),
            await get.getAsync<_i88.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i91.GetAuthTokenUseCase>(
      () async => _i91.GetAuthTokenUseCase(
            get<_i82.Iden3commRepository>(),
            get<_i79.ProofRepository>(),
            get<_i73.CredentialRepository>(),
            await get.getAsync<_i83.IdentityRepository>(),
          ));
  gh.factoryAsync<_i92.GetClaimRevocationStatusUseCase>(
      () async => _i92.GetClaimRevocationStatusUseCase(
            get<_i73.CredentialRepository>(),
            await get.getAsync<_i83.IdentityRepository>(),
            await get.getAsync<_i90.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i93.GetDidIdentifierUseCase>(() async =>
      _i93.GetDidIdentifierUseCase(
          await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i94.GetIdentifierUseCase>(() async =>
      _i94.GetIdentifierUseCase(await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i95.GetIdentityUseCase>(() async =>
      _i95.GetIdentityUseCase(await get.getAsync<_i83.IdentityRepository>()));
  gh.factoryAsync<_i96.Identity>(() async => _i96.Identity(
        await get.getAsync<_i87.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i95.GetIdentityUseCase>(),
        await get.getAsync<_i85.RemoveIdentityUseCase>(),
        await get.getAsync<_i94.GetIdentifierUseCase>(),
        await get.getAsync<_i86.SignMessageUseCase>(),
        await get.getAsync<_i88.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i97.FetchAndSaveClaimsUseCase>(
      () async => _i97.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i91.GetAuthTokenUseCase>(),
            get<_i73.CredentialRepository>(),
          ));
  gh.factoryAsync<_i98.GenerateProofUseCase>(
      () async => _i98.GenerateProofUseCase(
            get<_i79.ProofRepository>(),
            get<_i73.CredentialRepository>(),
            await get.getAsync<_i92.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i99.GetProofsUseCase>(() async => _i99.GetProofsUseCase(
        get<_i79.ProofRepository>(),
        await get.getAsync<_i83.IdentityRepository>(),
        get<_i74.GetClaimsUseCase>(),
        await get.getAsync<_i98.GenerateProofUseCase>(),
        get<_i84.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i100.Proof>(
      () async => _i100.Proof(await get.getAsync<_i98.GenerateProofUseCase>()));
  gh.factoryAsync<_i101.AuthenticateUseCase>(
      () async => _i101.AuthenticateUseCase(
            get<_i82.Iden3commRepository>(),
            await get.getAsync<_i99.GetProofsUseCase>(),
            await get.getAsync<_i91.GetAuthTokenUseCase>(),
            get<_i75.GetEnvConfigUseCase>(),
            await get.getAsync<_i70.GetPackageNameUseCase>(),
            await get.getAsync<_i93.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i102.Credential>(() async => _i102.Credential(
        await get.getAsync<_i97.FetchAndSaveClaimsUseCase>(),
        get<_i74.GetClaimsUseCase>(),
        get<_i80.RemoveClaimsUseCase>(),
        get<_i81.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i103.Iden3comm>(() async => _i103.Iden3comm(
        get<_i76.GetVocabsUseCase>(),
        await get.getAsync<_i101.AuthenticateUseCase>(),
        await get.getAsync<_i99.GetProofsUseCase>(),
        get<_i60.Iden3MessageMapper>(),
        get<_i67.SchemaInfoMapper>(),
      ));
  return get;
}

class _$PlatformModule extends _i104.PlatformModule {}

class _$NetworkModule extends _i104.NetworkModule {}

class _$DatabaseModule extends _i104.DatabaseModule {}

class _$Sdk extends _i104.Sdk {}

class _$RepositoriesModule extends _i104.RepositoriesModule {}
