// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i31;
import 'package:sembast/sembast.dart' as _i10;
import 'package:web3dart/web3dart.dart' as _i48;

import '../../common/data/data_sources/env_datasource.dart' as _i56;
import '../../common/data/data_sources/package_info_datasource.dart' as _i32;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i62;
import '../../common/data/repositories/package_info_repository_impl.dart'
    as _i33;
import '../../common/domain/repositories/config_repository.dart' as _i66;
import '../../common/domain/repositories/package_info_repository.dart' as _i59;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i70;
import '../../common/domain/use_cases/get_package_name_use_case.dart' as _i64;
import '../../credential/data/credential_repository_impl.dart' as _i63;
import '../../credential/data/data_sources/db_destination_path_data_source.dart'
    as _i11;
import '../../credential/data/data_sources/encryption_db_data_source.dart'
    as _i13;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i40;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i55;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i7;
import '../../credential/data/mappers/claim_mapper.dart' as _i54;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i14;
import '../../credential/data/mappers/filters_mapper.dart' as _i15;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i22;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i43;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i67;
import '../../credential/domain/use_cases/export_encrypted_claims_db_use_case.dart'
    as _i68;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i93;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i88;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i69;
import '../../credential/domain/use_cases/get_fetch_requests_use_case.dart'
    as _i16;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i71;
import '../../credential/domain/use_cases/import_encrypted_claims_db_use_case.dart'
    as _i74;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i77;
import '../../env/sdk_env.dart' as _i45;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i41;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i4;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i37;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i72;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i78;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i97;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i87;
import '../../iden3comm/domain/use_cases/get_iden3message_type_use_case.dart'
    as _i17;
import '../../iden3comm/domain/use_cases/get_iden3message_use_case.dart'
    as _i18;
import '../../iden3comm/domain/use_cases/get_proof_query_use_case.dart' as _i19;
import '../../iden3comm/domain/use_cases/get_proof_requests_use_case.dart'
    as _i20;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i95;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i26;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i27;
import '../../identity/data/data_sources/local_contract_files_data_source.dart'
    as _i28;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i42;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i60;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i57;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i58;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i47;
import '../../identity/data/mappers/did_mapper.dart' as _i12;
import '../../identity/data/mappers/hex_mapper.dart' as _i21;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i25;
import '../../identity/data/mappers/private_key_mapper.dart' as _i34;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i61;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i44;
import '../../identity/data/mappers/state_identifier_mapper.dart' as _i46;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i73;
import '../../identity/domain/repositories/identity_repository.dart' as _i79;
import '../../identity/domain/use_cases/create_and_save_identity_use_case.dart'
    as _i83;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i84;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i85;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i86;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/get_identifier_use_case.dart' as _i90;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i91;
import '../../identity/domain/use_cases/remove_identity_use_case.dart' as _i81;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i82;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i23;
import '../../identity/libs/smt/node.dart' as _i30;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i53;
import '../../proof_generation/data/data_sources/local_proof_files_data_source.dart'
    as _i29;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i35;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i39;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i50;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i6;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i36;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i65;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i75;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i94;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i80;
import '../../proof_generation/libs/prover/prover.dart' as _i38;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i52;
import '../credential.dart' as _i98;
import '../iden3comm.dart' as _i99;
import '../identity.dart' as _i92;
import '../mappers/iden3_message_type_mapper.dart' as _i24;
import '../proof.dart' as _i96;
import 'injector.dart' as _i100; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingletonAsync<_i10.Database>(() => databaseModule.database());
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
  gh.factory<_i11.DestinationPathDataSource>(
      () => _i11.DestinationPathDataSource());
  gh.factory<_i12.DidMapper>(() => _i12.DidMapper());
  gh.factory<_i13.EncryptionDbDataSource>(() => _i13.EncryptionDbDataSource());
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
  gh.factory<_i24.Iden3MessageTypeMapper>(() => _i24.Iden3MessageTypeMapper());
  gh.factory<_i25.IdentityDTOMapper>(() => _i25.IdentityDTOMapper());
  gh.factory<_i26.JWZIsolatesWrapper>(() => _i26.JWZIsolatesWrapper());
  gh.factory<_i27.LibIdentityDataSource>(
      () => _i27.LibIdentityDataSource(get<_i23.Iden3CoreLib>()));
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
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i10.StoreRef<String, dynamic>>(
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
      () => _i53.AtomicQueryInputsWrapper(get<_i23.Iden3CoreLib>()));
  gh.factory<_i54.ClaimMapper>(() => _i54.ClaimMapper(
        get<_i8.ClaimStateMapper>(),
        get<_i7.ClaimInfoMapper>(),
      ));
  gh.factory<_i55.ClaimStoreRefWrapper>(() => _i55.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i56.EnvDataSource>(() => _i56.EnvDataSource(get<_i45.SdkEnv>()));
  gh.factory<_i57.IdentityStoreRefWrapper>(() => _i57.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i58.KeyValueStoreRefWrapper>(() => _i58.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i59.PackageInfoRepository>(() async =>
      repositoriesModule.packageInfoRepository(
          await get.getAsync<_i33.PackageInfoRepositoryImpl>()));
  gh.factory<_i39.ProverLibDataSource>(
      () => _i39.ProverLibDataSource(get<_i39.ProverLibWrapper>()));
  gh.factory<_i60.RPCDataSource>(
      () => _i60.RPCDataSource(get<_i48.Web3Client>()));
  gh.factory<_i61.RhsNodeMapper>(
      () => _i61.RhsNodeMapper(get<_i44.RhsNodeTypeMapper>()));
  gh.factory<_i55.StorageClaimDataSource>(
      () => _i55.StorageClaimDataSource(get<_i55.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i58.StorageKeyValueDataSource>(
      () async => _i58.StorageKeyValueDataSource(
            await get.getAsync<_i10.Database>(),
            get<_i58.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i47.WalletDataSource>(
      () => _i47.WalletDataSource(get<_i47.WalletLibWrapper>()));
  gh.factory<_i50.WitnessDataSource>(
      () => _i50.WitnessDataSource(get<_i50.WitnessIsolatesWrapper>()));
  gh.factory<_i53.AtomicQueryInputsDataSource>(() =>
      _i53.AtomicQueryInputsDataSource(get<_i53.AtomicQueryInputsWrapper>()));
  gh.factory<_i62.ConfigRepositoryImpl>(
      () => _i62.ConfigRepositoryImpl(get<_i56.EnvDataSource>()));
  gh.factory<_i63.CredentialRepositoryImpl>(() => _i63.CredentialRepositoryImpl(
        get<_i40.RemoteClaimDataSource>(),
        get<_i55.StorageClaimDataSource>(),
        get<_i27.LibIdentityDataSource>(),
        get<_i54.ClaimMapper>(),
        get<_i15.FiltersMapper>(),
        get<_i22.IdFilterMapper>(),
        get<_i43.RevocationStatusMapper>(),
        get<_i13.EncryptionDbDataSource>(),
        get<_i11.DestinationPathDataSource>(),
      ));
  gh.factoryAsync<_i64.GetPackageNameUseCase>(() async =>
      _i64.GetPackageNameUseCase(
          await get.getAsync<_i59.PackageInfoRepository>()));
  gh.factory<_i26.JWZDataSource>(() => _i26.JWZDataSource(
        get<_i5.BabyjubjubLib>(),
        get<_i47.WalletDataSource>(),
        get<_i26.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i65.ProofRepositoryImpl>(() => _i65.ProofRepositoryImpl(
        get<_i50.WitnessDataSource>(),
        get<_i39.ProverLibDataSource>(),
        get<_i53.AtomicQueryInputsDataSource>(),
        get<_i29.LocalProofFilesDataSource>(),
        get<_i35.ProofCircuitDataSource>(),
        get<_i42.RemoteIdentityDataSource>(),
        get<_i6.CircuitTypeMapper>(),
        get<_i37.ProofRequestFiltersMapper>(),
        get<_i36.ProofMapper>(),
        get<_i54.ClaimMapper>(),
        get<_i43.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i57.StorageIdentityDataSource>(
      () async => _i57.StorageIdentityDataSource(
            await get.getAsync<_i10.Database>(),
            get<_i57.IdentityStoreRefWrapper>(),
            await get.getAsync<_i58.StorageKeyValueDataSource>(),
            get<_i47.WalletDataSource>(),
            get<_i21.HexMapper>(),
          ));
  gh.factory<_i66.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i62.ConfigRepositoryImpl>()));
  gh.factory<_i67.CredentialRepository>(() => repositoriesModule
      .credentialRepository(get<_i63.CredentialRepositoryImpl>()));
  gh.factory<_i68.ExportEncryptedClaimsDbUseCase>(() =>
      _i68.ExportEncryptedClaimsDbUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i69.GetClaimsUseCase>(
      () => _i69.GetClaimsUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i70.GetEnvConfigUseCase>(
      () => _i70.GetEnvConfigUseCase(get<_i66.ConfigRepository>()));
  gh.factory<_i71.GetVocabsUseCase>(
      () => _i71.GetVocabsUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i72.Iden3commRepositoryImpl>(() => _i72.Iden3commRepositoryImpl(
        get<_i41.RemoteIden3commDataSource>(),
        get<_i26.JWZDataSource>(),
        get<_i21.HexMapper>(),
        get<_i4.AuthResponseMapper>(),
      ));
  gh.factoryAsync<_i73.IdentityRepositoryImpl>(
      () async => _i73.IdentityRepositoryImpl(
            get<_i47.WalletDataSource>(),
            get<_i27.LibIdentityDataSource>(),
            get<_i42.RemoteIdentityDataSource>(),
            await get.getAsync<_i57.StorageIdentityDataSource>(),
            get<_i60.RPCDataSource>(),
            get<_i28.LocalContractFilesDataSource>(),
            get<_i21.HexMapper>(),
            get<_i34.PrivateKeyMapper>(),
            get<_i25.IdentityDTOMapper>(),
            get<_i61.RhsNodeMapper>(),
            get<_i46.StateIdentifierMapper>(),
            get<_i12.DidMapper>(),
          ));
  gh.factory<_i74.ImportEncryptedClaimsDbUseCase>(() =>
      _i74.ImportEncryptedClaimsDbUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i75.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i65.ProofRepositoryImpl>()));
  gh.factory<_i76.RemoveClaimsUseCase>(
      () => _i76.RemoveClaimsUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i77.UpdateClaimUseCase>(
      () => _i77.UpdateClaimUseCase(get<_i67.CredentialRepository>()));
  gh.factory<_i78.Iden3commRepository>(() => repositoriesModule
      .iden3commRepository(get<_i72.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i79.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i73.IdentityRepositoryImpl>()));
  gh.factory<_i80.IsProofCircuitSupportedUseCase>(
      () => _i80.IsProofCircuitSupportedUseCase(get<_i75.ProofRepository>()));
  gh.factoryAsync<_i81.RemoveIdentityUseCase>(() async =>
      _i81.RemoveIdentityUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i82.SignMessageUseCase>(() async =>
      _i82.SignMessageUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i83.CreateAndSaveIdentityUseCase>(
      () async => _i83.CreateAndSaveIdentityUseCase(
            await get.getAsync<_i79.IdentityRepository>(),
            get<_i70.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i84.FetchIdentityStateUseCase>(
      () async => _i84.FetchIdentityStateUseCase(
            await get.getAsync<_i79.IdentityRepository>(),
            get<_i70.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i85.FetchStateRootsUseCase>(() async =>
      _i85.FetchStateRootsUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i86.GenerateNonRevProofUseCase>(
      () async => _i86.GenerateNonRevProofUseCase(
            await get.getAsync<_i79.IdentityRepository>(),
            get<_i67.CredentialRepository>(),
            get<_i70.GetEnvConfigUseCase>(),
            await get.getAsync<_i84.FetchIdentityStateUseCase>(),
          ));
  gh.factoryAsync<_i87.GetAuthTokenUseCase>(
      () async => _i87.GetAuthTokenUseCase(
            get<_i78.Iden3commRepository>(),
            get<_i75.ProofRepository>(),
            get<_i67.CredentialRepository>(),
            await get.getAsync<_i79.IdentityRepository>(),
          ));
  gh.factoryAsync<_i88.GetClaimRevocationStatusUseCase>(
      () async => _i88.GetClaimRevocationStatusUseCase(
            get<_i67.CredentialRepository>(),
            await get.getAsync<_i79.IdentityRepository>(),
            await get.getAsync<_i86.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i89.GetDidIdentifierUseCase>(() async =>
      _i89.GetDidIdentifierUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i90.GetIdentifierUseCase>(() async =>
      _i90.GetIdentifierUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i91.GetIdentityUseCase>(() async =>
      _i91.GetIdentityUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i92.Identity>(() async => _i92.Identity(
        await get.getAsync<_i83.CreateAndSaveIdentityUseCase>(),
        await get.getAsync<_i91.GetIdentityUseCase>(),
        await get.getAsync<_i81.RemoveIdentityUseCase>(),
        await get.getAsync<_i90.GetIdentifierUseCase>(),
        await get.getAsync<_i82.SignMessageUseCase>(),
        await get.getAsync<_i84.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i93.FetchAndSaveClaimsUseCase>(
      () async => _i93.FetchAndSaveClaimsUseCase(
            get<_i16.GetFetchRequestsUseCase>(),
            await get.getAsync<_i87.GetAuthTokenUseCase>(),
            get<_i67.CredentialRepository>(),
          ));
  gh.factoryAsync<_i94.GenerateProofUseCase>(
      () async => _i94.GenerateProofUseCase(
            get<_i75.ProofRepository>(),
            get<_i67.CredentialRepository>(),
            await get.getAsync<_i88.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i95.GetProofsUseCase>(() async => _i95.GetProofsUseCase(
        get<_i75.ProofRepository>(),
        await get.getAsync<_i79.IdentityRepository>(),
        get<_i69.GetClaimsUseCase>(),
        await get.getAsync<_i94.GenerateProofUseCase>(),
        get<_i80.IsProofCircuitSupportedUseCase>(),
        get<_i20.GetProofRequestsUseCase>(),
      ));
  gh.factoryAsync<_i96.Proof>(
      () async => _i96.Proof(await get.getAsync<_i94.GenerateProofUseCase>()));
  gh.factoryAsync<_i97.AuthenticateUseCase>(
      () async => _i97.AuthenticateUseCase(
            get<_i78.Iden3commRepository>(),
            await get.getAsync<_i95.GetProofsUseCase>(),
            await get.getAsync<_i87.GetAuthTokenUseCase>(),
            get<_i70.GetEnvConfigUseCase>(),
            await get.getAsync<_i64.GetPackageNameUseCase>(),
            await get.getAsync<_i89.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i98.Credential>(() async => _i98.Credential(
        await get.getAsync<_i93.FetchAndSaveClaimsUseCase>(),
        get<_i69.GetClaimsUseCase>(),
        get<_i76.RemoveClaimsUseCase>(),
        get<_i77.UpdateClaimUseCase>(),
        get<_i68.ExportEncryptedClaimsDbUseCase>(),
        get<_i74.ImportEncryptedClaimsDbUseCase>(),
      ));
  gh.factoryAsync<_i99.Iden3comm>(() async => _i99.Iden3comm(
        get<_i71.GetVocabsUseCase>(),
        await get.getAsync<_i97.AuthenticateUseCase>(),
        await get.getAsync<_i95.GetProofsUseCase>(),
        get<_i18.GetIden3MessageUseCase>(),
      ));
  return get;
}

class _$PlatformModule extends _i100.PlatformModule {}

class _$NetworkModule extends _i100.NetworkModule {}

class _$DatabaseModule extends _i100.DatabaseModule {}

class _$Sdk extends _i100.Sdk {}

class _$RepositoriesModule extends _i100.RepositoriesModule {}
