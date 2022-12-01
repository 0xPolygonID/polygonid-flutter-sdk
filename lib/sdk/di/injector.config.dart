// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i29;
import 'package:sembast/sembast.dart' as _i10;
import 'package:web3dart/web3dart.dart' as _i46;

import '../../common/data/data_sources/env_datasource.dart' as _i54;
import '../../common/data/data_sources/package_info_datasource.dart' as _i30;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i60;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i31;
import '../../common/domain/repositories/config_repository.dart' as _i64;
import '../../common/domain/repositories/package_info_repository.dart' as _i57;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i67;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i62;
import '../../credential/data/credential_repository_impl.dart' as _i61;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i38;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i53;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i52;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i20;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i41;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i65;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i89;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i84;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i66;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i14;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i68;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i72;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i73;
import '../../env/sdk_env.dart' as _i43;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i39;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i35;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i69;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i74;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i93;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i83;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i15;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i16;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i17;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i18;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i91;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i24;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i25;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i26;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i40;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i58;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i55;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i56;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i45;
import '../../identity/data/mappers/did_mapper.dart' as _i11;
import '../../identity/data/mappers/hex_mapper.dart' as _i19;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i23;
import '../../identity/data/mappers/private_key_mapper.dart' as _i32;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i59;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i42;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i44;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i70;
import '../../identity/domain/repositories/identity_repository.dart' as _i75;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i79;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i80;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i81;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i82;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i85;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i86;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i87;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i77;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i78;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i21;
import '../../identity/libs/smt/node.dart' as _i28;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i51;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i33;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i37;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i48;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i34;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i63;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i71;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i90;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i76;
import '../../proof_generation/libs/prover/prover.dart' as _i36;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i47;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i50;
import '../credential.dart' as _i94;
import '../iden3comm.dart' as _i95;
import '../identity.dart' as _i88;
import '../mappers/iden3_message_type_mapper.dart' as _i22;
import '../proof.dart' as _i92;
import 'injector.dart' as _i96; // ignore_for_file: unnecessary_lambdas

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
  gh.factoryParamAsync<_i10.Database, String?, String?>(
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
  gh.lazySingletonAsync<_i10.Database>(() => databaseModule.database());
  gh.factory<_i11.DidMapper>(() => _i11.DidMapper());
  gh.factory<_i12.FilterMapper>(() => _i12.FilterMapper());
  gh.factory<_i13.FiltersMapper>(
      () => _i13.FiltersMapper(get<_i12.FilterMapper>()));
  gh.factory<_i14.GetFetchRequestsUseCase>(
      () => _i14.GetFetchRequestsUseCase());
  gh.factory<_i15.GetIden3MessageTypeUseCase>(
      () => _i15.GetIden3MessageTypeUseCase());
  gh.factory<_i16.GetIden3MessageUseCase>(() =>
      _i16.GetIden3MessageUseCase(get<_i15.GetIden3MessageTypeUseCase>()));
  gh.factory<_i17.GetProofQueryUseCase>(() => _i17.GetProofQueryUseCase());
  gh.factory<_i18.GetProofRequestsUseCase>(
      () => _i18.GetProofRequestsUseCase(get<_i17.GetProofQueryUseCase>()));
  gh.factory<_i19.HexMapper>(() => _i19.HexMapper());
  gh.factory<_i20.IdFilterMapper>(() => _i20.IdFilterMapper());
  gh.factory<_i21.Iden3CoreLib>(() => _i21.Iden3CoreLib());
  gh.factory<_i22.Iden3MessageTypeMapper>(() => _i22.Iden3MessageTypeMapper());
  gh.factory<_i23.IdentityDTOMapper>(() => _i23.IdentityDTOMapper());
  gh.factory<_i24.JWZIsolatesWrapper>(() => _i24.JWZIsolatesWrapper());
  gh.factory<_i25.LibIdentityDataSource>(
      () => _i25.LibIdentityDataSource(get<_i21.Iden3CoreLib>()));
  gh.factory<_i26.LocalContractFilesDataSource>(
      () => _i26.LocalContractFilesDataSource(get<_i3.AssetBundle>()));
  gh.factory<_i27.LocalProofFilesDataSource>(
      () => _i27.LocalProofFilesDataSource());
  gh.factory<_i28.Node>(() => _i28.Node(
        get<_i28.NodeType>(),
        get<_i21.Iden3CoreLib>(),
      ));
  gh.lazySingletonAsync<_i29.PackageInfo>(() => platformModule.packageInfo);
  gh.factoryAsync<_i30.PackageInfoDataSource>(() async =>
      _i30.PackageInfoDataSource(await get.getAsync<_i29.PackageInfo>()));
  gh.factoryAsync<_i31.PackageInfoRepositoryImpl>(() async =>
      _i31.PackageInfoRepositoryImpl(
          await get.getAsync<_i30.PackageInfoDataSource>()));
  gh.factory<_i32.PrivateKeyMapper>(() => _i32.PrivateKeyMapper());
  gh.factory<_i33.ProofCircuitDataSource>(() => _i33.ProofCircuitDataSource());
  gh.factory<_i34.ProofMapper>(() => _i34.ProofMapper());
  gh.factory<_i35.ProofRequestFiltersMapper>(
      () => _i35.ProofRequestFiltersMapper());
  gh.factory<_i36.ProverLib>(() => _i36.ProverLib());
  gh.factory<_i37.ProverLibWrapper>(() => _i37.ProverLibWrapper());
  gh.factory<_i38.RemoteClaimDataSource>(
      () => _i38.RemoteClaimDataSource(get<_i9.Client>()));
  gh.factory<_i39.RemoteIden3commDataSource>(
      () => _i39.RemoteIden3commDataSource(get<_i9.Client>()));
  gh.factory<_i40.RemoteIdentityDataSource>(
      () => _i40.RemoteIdentityDataSource());
  gh.factory<_i41.RevocationStatusMapper>(() => _i41.RevocationStatusMapper());
  gh.factory<_i42.RhsNodeTypeMapper>(() => _i42.RhsNodeTypeMapper());
  gh.lazySingleton<_i43.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i44.StateIdentifierMapper>(() => _i44.StateIdentifierMapper());
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i10.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i45.WalletLibWrapper>(() => _i45.WalletLibWrapper());
  gh.factory<_i46.Web3Client>(
      () => networkModule.web3Client(get<_i43.SdkEnv>()));
  gh.factory<_i47.WitnessAuthLib>(() => _i47.WitnessAuthLib());
  gh.factory<_i48.WitnessIsolatesWrapper>(() => _i48.WitnessIsolatesWrapper());
  gh.factory<_i49.WitnessMtpLib>(() => _i49.WitnessMtpLib());
  gh.factory<_i50.WitnessSigLib>(() => _i50.WitnessSigLib());
  gh.factory<_i51.AtomicQueryInputsWrapper>(
      () => _i51.AtomicQueryInputsWrapper(get<_i21.Iden3CoreLib>()));
  gh.factory<_i52.ClaimMapper>(() => _i52.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i53.ClaimStoreRefWrapper>(() => _i53.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i54.EnvDataSource>(() => _i54.EnvDataSource(get<_i43.SdkEnv>()));
  gh.factory<_i55.IdentityStoreRefWrapper>(() => _i55.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i56.KeyValueStoreRefWrapper>(() => _i56.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i57.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i31.PackageInfoRepositoryImpl>()));
  gh.factory<_i37.ProverLibDataSource>(
      () => _i37.ProverLibDataSource(get<_i37.ProverLibWrapper>()));
  gh.factory<_i58.RPCDataSource>(
      () => _i58.RPCDataSource(get<_i46.Web3Client>()));
  gh.factory<_i59.RhsNodeMapper>(
      () => _i59.RhsNodeMapper(get<_i42.RhsNodeTypeMapper>()));
  gh.factory<_i53.StorageClaimDataSource>(
      () => _i53.StorageClaimDataSource(get<_i53.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i56.StorageKeyValueDataSource>(
      () async => _i56.StorageKeyValueDataSource(
            await get.getAsync<_i10.Database>(),
            get<_i56.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i45.WalletDataSource>(
      () => _i45.WalletDataSource(get<_i45.WalletLibWrapper>()));
  gh.factory<_i48.WitnessDataSource>(
      () => _i48.WitnessDataSource(get<_i48.WitnessIsolatesWrapper>()));
  gh.factory<_i51.AtomicQueryInputsDataSource>(() =>
      _i51.AtomicQueryInputsDataSource(get<_i51.AtomicQueryInputsWrapper>()));
  gh.factory<_i60.ConfigRepositoryImpl>(
      () => _i60.ConfigRepositoryImpl(get<_i54.EnvDataSource>()));
  gh.factory<_i61.CredentialRepositoryImpl>(() => _i61.CredentialRepositoryImpl(
        get<_i38.RemoteClaimDataSource>(),
        get<_i53.StorageClaimDataSource>(),
        get<_i25.LibIdentityDataSource>(),
        get<_i52.ClaimMapper>(),
        get<_i13.FiltersMapper>(),
        get<_i20.IdFilterMapper>(),
        get<_i41.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i62.GetPackageNameUseCase>(() async =>
      _i62.GetPackageNameUseCase(
          await get.getAsync<_i57.PackageInfoRepository>()));
  gh.factory<_i24.JWZDataSource>(() => _i24.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i45.WalletDataSource>(),
        get<_i24.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i63.ProofRepositoryImpl>(() => _i63.ProofRepositoryImpl(
        get<_i48.WitnessDataSource>(),
        get<_i37.ProverLibDataSource>(),
        get<_i51.AtomicQueryInputsDataSource>(),
        get<_i27.LocalProofFilesDataSource>(),
        get<_i33.ProofCircuitDataSource>(),
        get<_i40.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i35.ProofRequestFiltersMapper>(),
        get<_i34.ProofMapper>(),
        get<_i52.ClaimMapper>(),
        get<_i41.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i55.StorageIdentityDataSource>(
      () async => _i55.StorageIdentityDataSource(
            await get.getAsync<_i10.Database>(),
            get<_i55.IdentityStoreRefWrapper>(),
            await get.getAsync<_i56.StorageKeyValueDataSource>(),
            get<_i45.WalletDataSource>(),
            get<_i19.HexMapper>(),
          ));
  gh.factory<_i64.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i60.ConfigRepositoryImpl>()));
  gh.factory<_i65.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i61.CredentialRepositoryImpl>()));
  gh.factory<_i66.GetClaimsUseCase>(
      () => _i66.GetClaimsUseCase(get<_i65.CredentialRepository>()));
  gh.factory<_i67.GetEnvConfigUseCase>(
      () => _i67.GetEnvConfigUseCase(get<_i64.ConfigRepository>()));
  gh.factory<_i68.GetVocabsUseCase>(
      () => _i68.GetVocabsUseCase(get<_i65.CredentialRepository>()));
  gh.factory<_i69.Iden3commRepositoryImpl>(() => _i69.Iden3commRepositoryImpl(
        get<_i39.RemoteIden3commDataSource>(),
        get<_i24.JWZDataSource>(),
        get<_i19.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i70.IdentityRepositoryImpl>(
      () async => _i70.IdentityRepositoryImpl(
            get<_i45.WalletDataSource>(),
            get<_i25.LibIdentityDataSource>(),
            get<_i40.RemoteIdentityDataSource>(),
            await get.getAsync<_i55.StorageIdentityDataSource>(),
            get<_i58.RPCDataSource>(),
            get<_i26.LocalContractFilesDataSource>(),
            get<_i19.HexMapper>(),
            get<_i32.PrivateKeyMapper>(),
            get<_i23.IdentityDTOMapper>(),
            get<_i59.RhsNodeMapper>(),
            get<_i44.StateIdentifierMapper>(),
            get<_i11.DidMapper>(),
          ));
  gh.factory<_i71.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i63.ProofRepositoryImpl>()));
  gh.factory<_i72.RemoveClaimsUseCase>(
      () => _i72.RemoveClaimsUseCase(get<_i65.CredentialRepository>()));
  gh.factory<_i73.UpdateClaimUseCase>(
      () => _i73.UpdateClaimUseCase(get<_i65.CredentialRepository>()));
  gh.factory<_i74.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i69.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i75.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i70.IdentityRepositoryImpl>()));
  gh.factory<_i76.IsProofCircuitSupportedUseCase>(
      () => _i76.IsProofCircuitSupportedUseCase(get<_i71.ProofRepository>()));
  gh.factoryAsync<_i77.RemoveIdentityUseCase>(() async =>
      _i77.RemoveIdentityUseCase(
          await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i78.SignMessageUseCase>(() async =>
      _i78.SignMessageUseCase(await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i79.CreateAndSaveIdentityUseCase>(
      () async => _i79.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i75.IdentityRepository>(),
            get<_i67.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i80.FetchIdentityStateUseCase>(
      () async => _i80.FetchIdentityStateUseCase(
            await get.getAsync<_i75.IdentityRepository>(),
            get<_i67.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i81.FetchStateRootsUseCase>(() async =>
      _i81.FetchStateRootsUseCase(
          await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i82.GenerateNonRevProofUseCase>(
      () async => _i82.GenerateNonRevProofUseCase(
            await get.getAsync<_i75.IdentityRepository>(),
            get<_i65.CredentialRepository>(),
            get<_i67.GetEnvConfigUseCase>(),
            await get.getAsync<_i80.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i83.GetAuthTokenUseCase>(
      () async => _i83.GetAuthTokenUseCase(
            get<_i74.Iden3commRepository>(),
            get<_i71.ProofRepository>(),
            get<_i65.CredentialRepository>(),
            await get.getAsync<_i75.IdentityRepository>(),
          ));
  gh.factoryAsync<_i84.GetClaimRevocationStatusUseCase>(
      () async => _i84.GetClaimRevocationStatusUseCase(
            get<_i65.CredentialRepository>(),
            await get.getAsync<_i75.IdentityRepository>(),
            await get.getAsync<_i82.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i85.GetDidIdentifierUseCase>(() async =>
      _i85.GetDidIdentifierUseCase(
          await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i86.GetIdentifierUseCase>(() async =>
      _i86.GetIdentifierUseCase(await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i87.GetIdentityUseCase>(() async =>
      _i87.GetIdentityUseCase(await get.getAsync<_i75.IdentityRepository>()));
  gh.factoryAsync<_i88.Identity>(() async => _i88.Identity(
        await get.getAsync<_i79.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i87.GetIdentityUseCase>(),
        await get.getAsync<_i77.RemoveIdentityUseCase>(),
        await get.getAsync<_i86.GetIdentifierUseCase>(),
        await get.getAsync<_i78.SignMessageUseCase>(),
        await get.getAsync<_i80.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i89.FetchAndSaveClaimsUseCase>(
      () async => _i89.FetchAndSaveClaimsUseCase(
            get<_i14.GetFetchRequestsUseCase>(),
            await get.getAsync<_i83.GetAuthTokenUseCase>(),
            get<_i65.CredentialRepository>(),
          ));
  gh.factoryAsync<_i90.GenerateProofUseCase>(
      () async => _i90.GenerateProofUseCase(
            get<_i71.ProofRepository>(),
            get<_i65.CredentialRepository>(),
            await get.getAsync<_i84.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i91.GetProofsUseCase>(() async => _i91.GetProofsUseCase(
        get<_i71.ProofRepository>(),
        await get.getAsync<_i75.IdentityRepository>(),
        get<_i66.GetClaimsUseCase>(),
        await get.getAsync<_i90.GenerateProofUseCase>(),
        get<_i76.IsProofCircuitSupportedUseCase>(),
        get<_i18.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i92.Proof>(
      () async => _i92.Proof(await get.getAsync<_i90.GenerateProofUseCase>()));
  gh.factoryAsync<_i93.AuthenticateUseCase>(
      () async => _i93.AuthenticateUseCase(
            get<_i74.Iden3commRepository>(),
            await get.getAsync<_i91.GetProofsUseCase>(),
            await get.getAsync<_i83.GetAuthTokenUseCase>(),
            get<_i67.GetEnvConfigUseCase>(),
            await get.getAsync<_i62.GetPackageNameUseCase>(),
            await get.getAsync<_i85.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i94.Credential>(() async => _i94.Credential(
        await get.getAsync<_i89.FetchAndSaveClaimsUseCase>(),
        get<_i66.GetClaimsUseCase>(),
        get<_i72.RemoveClaimsUseCase>(),
        get<_i73.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i95.Iden3comm>(() async => _i95.Iden3comm(
        get<_i68.GetVocabsUseCase>(),
        await get.getAsync<_i93.AuthenticateUseCase>(),
        await get.getAsync<_i91.GetProofsUseCase>(),
        get<_i16.GetIden3MessageUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i96.PlatformModule {}

class _$NetworkModule extends _i96.NetworkModule {}

class _$DatabaseModule extends _i96.DatabaseModule {}

class _$Sdk extends _i96.Sdk {}

class _$RepositoriesModule extends _i96.RepositoriesModule {}
