// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i31;
import 'package:sembast/sembast.dart' as _i12;
import 'package:web3dart/web3dart.dart' as _i49;

import '../../common/data/data_sources/env_datasource.dart' as _i57;
import '../../common/data/data_sources/package_info_datasource.dart' as _i32;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i65;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i33;
import '../../common/domain/repositories/config_repository.dart' as _i70;
import '../../common/domain/repositories/package_info_repository.dart' as _i62;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i74;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i67;
import '../../credential/data/credential_repository_impl.dart' as _i66;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i41;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i56;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i9;
import '../../credential/data/mappers/claim_mapper.dart' as _i55;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i22;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i44;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i71;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i103;
import '../../credential/domain/use_cases/get_auth_claim_use_case.dart' as _i72;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i92;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i73;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i16;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i75;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i79;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i80;
import '../../env/sdk_env.dart' as _i46;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i42;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i5;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i37;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i59;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i68;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i102;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i99;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i17;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i18;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i19;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i100;
import '../../identity/data/data_sources/babyjubjub_lib_data_source.dart'
    as _i7;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i24;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i28;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i43;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i63;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i48;
import '../../identity/data/mappers/auth_inputs_mapper.dart' as _i4;
import '../../identity/data/mappers/did_mapper.dart' as _i13;
import '../../identity/data/mappers/hash_mapper.dart' as _i58;
import '../../identity/data/mappers/hex_mapper.dart' as _i21;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i26;
import '../../identity/data/mappers/private_key_mapper.dart' as _i34;
import '../../identity/data/mappers/q_mapper.dart' as _i40;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i64;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i45;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i47;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i76;
import '../../identity/domain/repositories/identity_repository.dart' as _i82;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/get_auth_challenge_use_case.dart'
    as _i91;
import '../../identity/domain/use_cases/get_auth_inputs_use_case.dart' as _i98;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i93;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i94;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i95;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i85;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i86;
import '../../identity/libs/bjj/bjj.dart' as _i6;
import '../../identity/libs/iden3core/iden3core.dart' as _i23;
import '../../identity/libs/smt/node.dart' as _i30;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i54;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i29;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i35;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i51;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i8;
import '../../proof_generation/data/mappers/jwz_mapper.dart' as _i27;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i36;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i69;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i77;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i97;
import '../../proof_generation/domain/use_cases/get_jwz_use_case.dart' as _i81;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i83;
import '../../proof_generation/domain/use_cases/load_circuit_use_case.dart'
    as _i84;
import '../../proof_generation/domain/use_cases/prove_use_case.dart' as _i78;
import '../../proof_generation/libs/prover/prover.dart' as _i38;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i50;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i52;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i53;
import '../credential.dart' as _i105;
import '../iden3comm.dart' as _i104;
import '../identity.dart' as _i96;
import '../mappers/iden3_message_type_mapper.dart' as _i25;
import '../proof.dart' as _i101;
import 'injector.dart' as _i106; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.AuthInputsMapper>(() => _i4.AuthInputsMapper());
  gh.factory<_i5.AuthResponseMapper>(() => _i5.AuthResponseMapper());
  gh.factory<_i6.BabyjubjubLib>(() => _i6.BabyjubjubLib());
  gh.factory<_i7.BabyjubjubLibDataSource>(
      () => _i7.BabyjubjubLibDataSource(get<_i6.BabyjubjubLib>()));
  gh.factory<_i8.CircuitTypeMapper>(() => _i8.CircuitTypeMapper());
  gh.factory<_i9.ClaimInfoMapper>(() => _i9.ClaimInfoMapper());
  gh.factory<_i10.ClaimStateMapper>(() => _i10.ClaimStateMapper());
  gh.factory<_i11.Client>(() => networkModule.client);
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
  gh.lazySingletonAsync<_i12.Database>(() => databaseModule.database());
  gh.factory<_i13.DidMapper>(() => _i13.DidMapper());
  gh.factory<_i14.FilterMapper>(() => _i14.FilterMapper());
  gh.factory<_i15.FiltersMapper>(
      () => _i15.FiltersMapper(get<_i14.FilterMapper>()));
  gh.factory<_i16.GetFetchRequestsUseCase>(
      () => _i16.GetFetchRequestsUseCase());
  gh.factory<_i17.GetIden3MessageTypeUseCase>(
      () => _i17.GetIden3MessageTypeUseCase());
  gh.factory<_i18.GetIden3MessageUseCase>(() =>
      _i18.GetIden3MessageUseCase(get<_i17.GetIden3MessageTypeUseCase>()));
  gh.factory<_i19.GetProofQueryUseCase>(() => _i19.GetProofQueryUseCase());
  gh.factory<_i20.GetProofRequestsUseCase>(
      () => _i20.GetProofRequestsUseCase(get<_i19.GetProofQueryUseCase>()));
  gh.factory<_i21.HexMapper>(() => _i21.HexMapper());
  gh.factory<_i22.IdFilterMapper>(() => _i22.IdFilterMapper());
  gh.factory<_i23.Iden3CoreLib>(() => _i23.Iden3CoreLib());
  gh.factory<_i24.Iden3LibIsolatesWrapper>(
      () => _i24.Iden3LibIsolatesWrapper());
  gh.factory<_i25.Iden3MessageTypeMapper>(() => _i25.Iden3MessageTypeMapper());
  gh.factory<_i26.IdentityDTOMapper>(() => _i26.IdentityDTOMapper());
  gh.factory<_i27.JWZMapper>(() => _i27.JWZMapper());
  gh.factory<_i24.LibIdentityDataSource>(() => _i24.LibIdentityDataSource(
        get<_i23.Iden3CoreLib>(),
        get<_i24.Iden3LibIsolatesWrapper>(),
      ));
  gh.factory<_i28.LocalContractFilesDataSource>(
      () => _i28.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i29.LocalProofFilesDataSource>(
      () => _i29.LocalProofFilesDataSource());
  gh.factory<_i30.Node>(() => _i30.Node(
        get<_i30.NodeType>(),
        get<_i23.Iden3CoreLib>(),
      ));
  gh.lazySingletonAsync<_i31.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i32.PackageInfoDataSource>(() async =>
      _i32.PackageInfoDataSource(await get.getAsync<_i31.PackageInfo>()));
  gh.factoryAsync<_i33.PackageInfoRepositoryImpl>(() async =>
      _i33.PackageInfoRepositoryImpl(
          await get.getAsync<_i32.PackageInfoDataSource>()));
  gh.factory<_i34.PrivateKeyMapper>(() => _i34.PrivateKeyMapper());
  gh.factory<_i35.ProofCircuitDataSource>(() => _i35.ProofCircuitDataSource());
  gh.factory<_i36.ProofMapper>(() => _i36.ProofMapper());
  gh.factory<_i37.ProofRequestFiltersMapper>(
      () => _i37.ProofRequestFiltersMapper());
  gh.factory<_i38.ProverLib>(() => _i38.ProverLib());
  gh.factory<_i39.ProverLibWrapper>(() => _i39.ProverLibWrapper());
  gh.factory<_i40.QMapper>(() => _i40.QMapper());
  gh.factory<_i41.RemoteClaimDataSource>(
      () => _i41.RemoteClaimDataSource(get<_i11.Client>()));
  gh.factory<_i42.RemoteIden3commDataSource>(
      () => _i42.RemoteIden3commDataSource(get<_i11.Client>()));
  gh.factory<_i43.RemoteIdentityDataSource>(
      () => _i43.RemoteIdentityDataSource());
  gh.factory<_i44.RevocationStatusMapper>(() => _i44.RevocationStatusMapper());
  gh.factory<_i45.RhsNodeTypeMapper>(() => _i45.RhsNodeTypeMapper());
  gh.lazySingleton<_i46.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i47.StateIdentifierMapper>(() => _i47.StateIdentifierMapper());
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i12.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i12.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i48.WalletLibWrapper>(() => _i48.WalletLibWrapper());
  gh.factory<_i49.Web3Client>(
      () => networkModule.web3Client(get<_i46.SdkEnv>()));
  gh.factory<_i50.WitnessAuthLib>(() => _i50.WitnessAuthLib());
  gh.factory<_i51.WitnessIsolatesWrapper>(() => _i51.WitnessIsolatesWrapper());
  gh.factory<_i52.WitnessMtpLib>(() => _i52.WitnessMtpLib());
  gh.factory<_i53.WitnessSigLib>(() => _i53.WitnessSigLib());
  gh.factory<_i54.AtomicQueryInputsWrapper>(
      () => _i54.AtomicQueryInputsWrapper(get<_i23.Iden3CoreLib>()));
  gh.factory<_i55.ClaimMapper>(() => _i55.ClaimMapper(
        get<_i10.ClaimStateMapper>(),
        get<_i9.ClaimInfoMapper>(),
      ));
  gh.factory<_i56.ClaimStoreRefWrapper>(() => _i56.ClaimStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i57.EnvDataSource>(() => _i57.EnvDataSource(get<_i46.SdkEnv>()));
  gh.factory<_i58.HashMapper>(() => _i58.HashMapper(get<_i21.HexMapper>()));
  gh.factory<_i59.Iden3commRepositoryImpl>(() => _i59.Iden3commRepositoryImpl(
        get<_i42.RemoteIden3commDataSource>(),
        get<_i21.HexMapper>(),
        get<_i5.AuthResponseMapper>(),
      ));
  gh.factory<_i60.IdentityStoreRefWrapper>(() => _i60.IdentityStoreRefWrapper(
      get<_i12.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i61.KeyValueStoreRefWrapper>(() => _i61.KeyValueStoreRefWrapper(
      get<_i12.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i62.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i33.PackageInfoRepositoryImpl>()));
  gh.factory<_i39.ProverLibDataSource>(
      () => _i39.ProverLibDataSource(get<_i39.ProverLibWrapper>()));
  gh.factory<_i63.RPCDataSource>(
      () => _i63.RPCDataSource(get<_i49.Web3Client>()));
  gh.factory<_i64.RhsNodeMapper>(
      () => _i64.RhsNodeMapper(get<_i45.RhsNodeTypeMapper>()));
  gh.factory<_i56.StorageClaimDataSource>(
      () => _i56.StorageClaimDataSource(get<_i56.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i61.StorageKeyValueDataSource>(
      () async => _i61.StorageKeyValueDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i61.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i48.WalletDataSource>(
      () => _i48.WalletDataSource(get<_i48.WalletLibWrapper>()));
  gh.factory<_i51.WitnessDataSource>(
      () => _i51.WitnessDataSource(get<_i51.WitnessIsolatesWrapper>()));
  gh.factory<_i54.AtomicQueryInputsDataSource>(() =>
      _i54.AtomicQueryInputsDataSource(get<_i54.AtomicQueryInputsWrapper>()));
  gh.factory<_i65.ConfigRepositoryImpl>(
      () => _i65.ConfigRepositoryImpl(get<_i57.EnvDataSource>()));
  gh.factory<_i66.CredentialRepositoryImpl>(() => _i66.CredentialRepositoryImpl(
        get<_i41.RemoteClaimDataSource>(),
        get<_i56.StorageClaimDataSource>(),
        get<_i24.LibIdentityDataSource>(),
        get<_i55.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i22.IdFilterMapper>(),
        get<_i44.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i67.GetPackageNameUseCase>(() async =>
      _i67.GetPackageNameUseCase(
          await get.getAsync<_i62.PackageInfoRepository>()));
  gh.factory<_i68.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i59.Iden3commRepositoryImpl>()));
  gh.factory<_i69.ProofRepositoryImpl>(() => _i69.ProofRepositoryImpl(
        get<_i51.WitnessDataSource>(),
        get<_i39.ProverLibDataSource>(),
        get<_i54.AtomicQueryInputsDataSource>(),
        get<_i29.LocalProofFilesDataSource>(),
        get<_i35.ProofCircuitDataSource>(),
        get<_i43.RemoteIdentityDataSource>(),
        get<_i8.CircuitTypeMapper>(),
        get<_i37.ProofRequestFiltersMapper>(),
        get<_i36.ProofMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i44.RevocationStatusMapper>(),
        get<_i27.JWZMapper>(),
      ));
  gh.factoryAsync<_i60.StorageIdentityDataSource>(
      () async => _i60.StorageIdentityDataSource(
            await get.getAsync<_i12.Database>(),
            get<_i60.IdentityStoreRefWrapper>(),
            await get.getAsync<_i61.StorageKeyValueDataSource>(),
            get<_i48.WalletDataSource>(),
            get<_i21.HexMapper>(),
          ));
  gh.factory<_i70.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i65.ConfigRepositoryImpl>()));
  gh.factory<_i71.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i66.CredentialRepositoryImpl>()));
  gh.factory<_i72.GetAuthClaimUseCase>(
      () => _i72.GetAuthClaimUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i73.GetClaimsUseCase>(
      () => _i73.GetClaimsUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i74.GetEnvConfigUseCase>(
      () => _i74.GetEnvConfigUseCase(get<_i70.ConfigRepository>()));
  gh.factory<_i75.GetVocabsUseCase>(
      () => _i75.GetVocabsUseCase(get<_i71.CredentialRepository>()));
  gh.factoryAsync<_i76.IdentityRepositoryImpl>(
      () async => _i76.IdentityRepositoryImpl(
            get<_i48.WalletDataSource>(),
            get<_i24.LibIdentityDataSource>(),
            get<_i43.RemoteIdentityDataSource>(),
            await get.getAsync<_i60.StorageIdentityDataSource>(),
            get<_i63.RPCDataSource>(),
            get<_i28.LocalContractFilesDataSource>(),
            get<_i7.BabyjubjubLibDataSource>(),
            get<_i21.HexMapper>(),
            get<_i34.PrivateKeyMapper>(),
            get<_i26.IdentityDTOMapper>(),
            get<_i64.RhsNodeMapper>(),
            get<_i47.StateIdentifierMapper>(),
            get<_i13.DidMapper>(),
            get<_i58.HashMapper>(),
            get<_i4.AuthInputsMapper>(),
            get<_i40.QMapper>(),
          ));
  gh.factory<_i77.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i69.ProofRepositoryImpl>()));
  gh.factory<_i78.ProveUseCase>(
      () => _i78.ProveUseCase(get<_i77.ProofRepository>()));
  gh.factory<_i79.RemoveClaimsUseCase>(
      () => _i79.RemoveClaimsUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i80.UpdateClaimUseCase>(
      () => _i80.UpdateClaimUseCase(get<_i71.CredentialRepository>()));
  gh.factory<_i81.GetJWZUseCase>(
      () => _i81.GetJWZUseCase(get<_i77.ProofRepository>()));
  gh.factoryAsync<_i82.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i76.IdentityRepositoryImpl>()));
  gh.factory<_i83.IsProofCircuitSupportedUseCase>(
      () => _i83.IsProofCircuitSupportedUseCase(get<_i77.ProofRepository>()));
  gh.factory<_i84.LoadCircuitUseCase>(
      () => _i84.LoadCircuitUseCase(get<_i77.ProofRepository>()));
  gh.factoryAsync<_i85.RemoveIdentityUseCase>(() async =>
      _i85.RemoveIdentityUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i86.SignMessageUseCase>(() async =>
      _i86.SignMessageUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i87.CreateAndSaveIdentityUseCase>(
      () async => _i87.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i74.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i88.FetchIdentityStateUseCase>(
      () async => _i88.FetchIdentityStateUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i74.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i89.FetchStateRootsUseCase>(() async =>
      _i89.FetchStateRootsUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i90.GenerateNonRevProofUseCase>(
      () async => _i90.GenerateNonRevProofUseCase(
            await get.getAsync<_i82.IdentityRepository>(),
            get<_i71.CredentialRepository>(),
            get<_i74.GetEnvConfigUseCase>(),
            await get.getAsync<_i88.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i91.GetAuthChallengeUseCase>(() async =>
      _i91.GetAuthChallengeUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i92.GetClaimRevocationStatusUseCase>(
      () async => _i92.GetClaimRevocationStatusUseCase(
            get<_i71.CredentialRepository>(),
            await get.getAsync<_i82.IdentityRepository>(),
            await get.getAsync<_i90.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i93.GetDidIdentifierUseCase>(() async =>
      _i93.GetDidIdentifierUseCase(
          await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i94.GetIdentifierUseCase>(() async =>
      _i94.GetIdentifierUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i95.GetIdentityUseCase>(() async =>
      _i95.GetIdentityUseCase(await get.getAsync<_i82.IdentityRepository>()));
  gh.factoryAsync<_i96.Identity>(() async => _i96.Identity(
        await get.getAsync<_i87.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i95.GetIdentityUseCase>(),
        await get.getAsync<_i85.RemoveIdentityUseCase>(),
        await get.getAsync<_i94.GetIdentifierUseCase>(),
        await get.getAsync<_i86.SignMessageUseCase>(),
        await get.getAsync<_i88.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i97.GenerateProofUseCase>(
      () async => _i97.GenerateProofUseCase(
            get<_i77.ProofRepository>(),
            await get.getAsync<_i92.GetClaimRevocationStatusUseCase>(),
            get<_i78.ProveUseCase>(),
          ));
  gh.factoryAsync<_i98.GetAuthInputsUseCase>(
      () async => _i98.GetAuthInputsUseCase(
            await get.getAsync<_i95.GetIdentityUseCase>(),
            get<_i72.GetAuthClaimUseCase>(),
            await get.getAsync<_i86.SignMessageUseCase>(),
            await get.getAsync<_i82.IdentityRepository>(),
          ));
  gh.factoryAsync<_i99.GetAuthTokenUseCase>(
      () async => _i99.GetAuthTokenUseCase(
            get<_i84.LoadCircuitUseCase>(),
            get<_i81.GetJWZUseCase>(),
            await get.getAsync<_i91.GetAuthChallengeUseCase>(),
            await get.getAsync<_i98.GetAuthInputsUseCase>(),
            get<_i78.ProveUseCase>(),
          ));
  gh.factoryAsync<_i100.GetProofsUseCase>(() async => _i100.GetProofsUseCase(
        get<_i77.ProofRepository>(),
        await get.getAsync<_i82.IdentityRepository>(),
        get<_i73.GetClaimsUseCase>(),
        await get.getAsync<_i97.GenerateProofUseCase>(),
        get<_i83.IsProofCircuitSupportedUseCase>(),
        get<_i20.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i101.Proof>(
      () async => _i101.Proof(await get.getAsync<_i97.GenerateProofUseCase>()));
  gh.factoryAsync<_i102.AuthenticateUseCase>(
      () async => _i102.AuthenticateUseCase(
            get<_i68.Iden3commRepository>(),
            await get.getAsync<_i100.GetProofsUseCase>(),
            await get.getAsync<_i99.GetAuthTokenUseCase>(),
            get<_i74.GetEnvConfigUseCase>(),
            await get.getAsync<_i67.GetPackageNameUseCase>(),
            await get.getAsync<_i93.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i103.FetchAndSaveClaimsUseCase>(
      () async => _i103.FetchAndSaveClaimsUseCase(
            get<_i16.GetFetchRequestsUseCase>(),
            await get.getAsync<_i99.GetAuthTokenUseCase>(),
            get<_i71.CredentialRepository>(),
          ));
  gh.factoryAsync<_i104.Iden3comm>(() async => _i104.Iden3comm(
        get<_i75.GetVocabsUseCase>(),
        await get.getAsync<_i102.AuthenticateUseCase>(),
        await get.getAsync<_i100.GetProofsUseCase>(),
        get<_i18.GetIden3MessageUseCase>(),
      ));
  gh.factoryAsync<_i105.Credential>(() async => _i105.Credential(
        await get.getAsync<_i103.FetchAndSaveClaimsUseCase>(),
        get<_i73.GetClaimsUseCase>(),
        get<_i79.RemoveClaimsUseCase>(),
        get<_i80.UpdateClaimUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i106.PlatformModule {}

class _$NetworkModule extends _i106.NetworkModule {}

class _$DatabaseModule extends _i106.DatabaseModule {}

class _$Sdk extends _i106.Sdk {}

class _$RepositoriesModule extends _i106.RepositoriesModule {}
