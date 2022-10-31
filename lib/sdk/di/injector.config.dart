// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i47;

import '../../common/data/data_sources/env_datasource.dart' as _i57;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i66;
import '../../common/domain/repositories/config_repository.dart' as _i15;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i14;
import '../../credential/data/credential_repository_impl.dart' as _i67;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i38;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i55;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i54;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i17;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i41;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i69;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i93;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i87;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i70;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i71;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i75;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i76;
import '../../env/sdk_env.dart' as _i45;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i35;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i39;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i53;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i56;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i58;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i19;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i28;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i62;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i72;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i77;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i97;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i86;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i95;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i22;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i23;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i40;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i63;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i46;
import '../../identity/data/mappers/hex_mapper.dart' as _i16;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i21;
import '../../identity/data/mappers/private_key_mapper.dart' as _i29;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i64;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i42;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i73;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i43;
import '../../identity/domain/repositories/identity_repository.dart' as _i78;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i26;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i82;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i83;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i84;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i85;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i88;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i90;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i91;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i80;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i81;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i18;
import '../../identity/libs/smt/hash.dart' as _i44;
import '../../identity/libs/smt/merkletree.dart' as _i25;
import '../../identity/libs/smt/node.dart' as _i27;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i52;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i30;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i37;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i49;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i31;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i68;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i74;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i94;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i79;
import '../../proof_generation/libs/prover/prover.dart' as _i36;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i48;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i50;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i51;
import '../credential_wallet.dart' as _i98;
import '../iden3comm.dart' as _i99;
import '../identity_wallet.dart' as _i92;
import '../mappers/iden3_message_mapper.dart' as _i59;
import '../mappers/iden3_message_type_mapper.dart' as _i20;
import '../mappers/schema_info_mapper.dart' as _i65;
import '../proof_generation.dart' as _i96;
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
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
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
  gh.lazySingletonAsync<_i11.Database>(() => databaseModule.database());
  gh.factory<_i12.FilterMapper>(() => _i12.FilterMapper());
  gh.factory<_i13.FiltersMapper>(
      () => _i13.FiltersMapper(get<_i12.FilterMapper>()));
  gh.factory<_i14.GetEnvConfigUseCase>(
      () => _i14.GetEnvConfigUseCase(get<_i15.ConfigRepository>()));
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
  gh.factory<_i24.LocalFilesDataSource>(() => _i24.LocalFilesDataSource());
  gh.factory<_i25.MerkleTree>(() => _i25.MerkleTree(
        get<_i18.Iden3CoreLib>(),
        get<_i26.SMTStorageRepository>(),
        get<int>(),
      ));
  gh.factory<_i27.Node>(() => _i27.Node(
        get<_i27.NodeType>(),
        get<_i18.Iden3CoreLib>(),
      ));
  gh.factory<_i28.OfferRequestMapper>(
      () => _i28.OfferRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i29.PrivateKeyMapper>(() => _i29.PrivateKeyMapper());
  gh.factory<_i30.ProofCircuitDataSource>(() => _i30.ProofCircuitDataSource());
  gh.factory<_i31.ProofMapper>(() => _i31.ProofMapper());
  gh.factory<_i32.ProofQueryMapper>(() => _i32.ProofQueryMapper());
  gh.factory<_i33.ProofQueryParamMapper>(() => _i33.ProofQueryParamMapper());
  gh.factory<_i34.ProofRequestFiltersMapper>(
      () => _i34.ProofRequestFiltersMapper(get<_i32.ProofQueryMapper>()));
  gh.factory<_i35.ProofScopeDataSource>(() => _i35.ProofScopeDataSource());
  gh.factory<_i36.ProverLib>(() => _i36.ProverLib());
  gh.factory<_i37.ProverLibWrapper>(() => _i37.ProverLibWrapper());
  gh.factory<_i38.RemoteClaimDataSource>(
      () => _i38.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i39.RemoteIden3commDataSource>(
      () => _i39.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i40.RemoteIdentityDataSource>(
      () => _i40.RemoteIdentityDataSource());
  gh.factory<_i41.RevocationStatusMapper>(() => _i41.RevocationStatusMapper());
  gh.factory<_i42.RhsNodeTypeMapper>(() => _i42.RhsNodeTypeMapper());
  gh.factory<_i43.SMTMemoryStorageRepositoryImpl>(
      () => _i43.SMTMemoryStorageRepositoryImpl(
            get<_i44.Hash>(),
            get<Map<_i44.Hash, _i27.Node>>(),
          ));
  gh.lazySingleton<_i45.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i11.StoreRef<String, dynamic>>(
    () => databaseModule.keyValueStore,
    instanceName: 'keyValueStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.claimStore,
    instanceName: 'claimStore',
  );
  gh.factory<_i11.StoreRef<String, Map<String, Object?>>>(
    () => databaseModule.identityStore,
    instanceName: 'identityStore',
  );
  gh.factory<_i46.WalletLibWrapper>(() => _i46.WalletLibWrapper());
  gh.factory<_i47.Web3Client>(
      () => networkModule.web3Client(get<_i45.SdkEnv>()));
  gh.factory<_i48.WitnessAuthLib>(() => _i48.WitnessAuthLib());
  gh.factory<_i49.WitnessIsolatesWrapper>(() => _i49.WitnessIsolatesWrapper());
  gh.factory<_i50.WitnessMtpLib>(() => _i50.WitnessMtpLib());
  gh.factory<_i51.WitnessSigLib>(() => _i51.WitnessSigLib());
  gh.factory<_i52.AtomicQueryInputsWrapper>(
      () => _i52.AtomicQueryInputsWrapper(get<_i18.Iden3CoreLib>()));
  gh.factory<_i53.AuthRequestMapper>(
      () => _i53.AuthRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i54.ClaimMapper>(() => _i54.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i55.ClaimStoreRefWrapper>(() => _i55.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i56.ContractRequestMapper>(
      () => _i56.ContractRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i57.EnvDataSource>(() => _i57.EnvDataSource(get<_i45.SdkEnv>()));
  gh.factory<_i58.FetchRequestMapper>(
      () => _i58.FetchRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i59.Iden3MessageMapper>(
      () => _i59.Iden3MessageMapper(get<_i20.Iden3MessageTypeMapper>()));
  gh.factory<_i60.IdentityStoreRefWrapper>(() => _i60.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i61.KeyValueStoreRefWrapper>(() => _i61.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i62.ProofRequestsMapper>(() => _i62.ProofRequestsMapper(
        get<_i53.AuthRequestMapper>(),
        get<_i58.FetchRequestMapper>(),
        get<_i28.OfferRequestMapper>(),
        get<_i56.ContractRequestMapper>(),
        get<_i33.ProofQueryParamMapper>(),
      ));
  gh.factory<_i37.ProverLibDataSource>(
      () => _i37.ProverLibDataSource(get<_i37.ProverLibWrapper>()));
  gh.factory<_i63.RPCDataSource>(
      () => _i63.RPCDataSource(get<_i47.Web3Client>()));
  gh.factory<_i64.RhsNodeMapper>(
      () => _i64.RhsNodeMapper(get<_i42.RhsNodeTypeMapper>()));
  gh.factory<_i65.SchemaInfoMapper>(() => _i65.SchemaInfoMapper(
        get<_i53.AuthRequestMapper>(),
        get<_i56.ContractRequestMapper>(),
      ));
  gh.factoryAsync<_i55.StorageClaimDataSource>(
      () async => _i55.StorageClaimDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i55.ClaimStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i61.StorageKeyValueDataSource>(
      () async => _i61.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i61.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i46.WalletDataSource>(
      () => _i46.WalletDataSource(get<_i46.WalletLibWrapper>()));
  gh.factory<_i49.WitnessDataSource>(
      () => _i49.WitnessDataSource(get<_i49.WitnessIsolatesWrapper>()));
  gh.factory<_i52.AtomicQueryInputsDataSource>(() =>
      _i52.AtomicQueryInputsDataSource(get<_i52.AtomicQueryInputsWrapper>()));
  gh.factory<_i66.ConfigRepositoryImpl>(
      () => _i66.ConfigRepositoryImpl(get<_i57.EnvDataSource>()));
  gh.factoryAsync<_i67.CredentialRepositoryImpl>(
      () async => _i67.CredentialRepositoryImpl(
            get<_i38.RemoteClaimDataSource>(),
            await get.getAsync<_i55.StorageClaimDataSource>(),
            get<_i40.RemoteIdentityDataSource>(),
            get<_i10.CredentialRequestMapper>(),
            get<_i54.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i17.IdFilterMapper>(),
            get<_i41.RevocationStatusMapper>(),
          ));
  gh.factory<_i22.JWZDataSource>(() => _i22.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i46.WalletDataSource>(),
        get<_i22.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i68.ProofRepositoryImpl>(() => _i68.ProofRepositoryImpl(
        get<_i49.WitnessDataSource>(),
        get<_i37.ProverLibDataSource>(),
        get<_i52.AtomicQueryInputsDataSource>(),
        get<_i24.LocalFilesDataSource>(),
        get<_i30.ProofCircuitDataSource>(),
        get<_i40.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i62.ProofRequestsMapper>(),
        get<_i34.ProofRequestFiltersMapper>(),
        get<_i31.ProofMapper>(),
        get<_i54.ClaimMapper>(),
        get<_i41.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i60.StorageIdentityDataSource>(
      () async => _i60.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i60.IdentityStoreRefWrapper>(),
            await get.getAsync<_i61.StorageKeyValueDataSource>(),
          ));
  gh.factoryAsync<_i69.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i67.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i70.GetClaimsUseCase>(() async =>
      _i70.GetClaimsUseCase(await get.getAsync<_i69.CredentialRepository>()));
  gh.factoryAsync<_i71.GetVocabsUseCase>(() async =>
      _i71.GetVocabsUseCase(await get.getAsync<_i69.CredentialRepository>()));
  gh.factoryAsync<_i72.Iden3commRepositoryImpl>(
      () async => _i72.Iden3commRepositoryImpl(
            get<_i39.RemoteIden3commDataSource>(),
            get<_i22.JWZDataSource>(),
            get<_i16.HexMapper>(),
            get<_i35.ProofScopeDataSource>(),
            await get.getAsync<_i55.StorageClaimDataSource>(),
            get<_i54.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i3.AuthResponseMapper>(),
            get<_i53.AuthRequestMapper>(),
          ));
  gh.factoryAsync<_i73.IdentityRepositoryImpl>(
      () async => _i73.IdentityRepositoryImpl(
            get<_i46.WalletDataSource>(),
            get<_i23.LibIdentityDataSource>(),
            get<_i40.RemoteIdentityDataSource>(),
            await get.getAsync<_i60.StorageIdentityDataSource>(),
            await get.getAsync<_i61.StorageKeyValueDataSource>(),
            get<_i63.RPCDataSource>(),
            get<_i16.HexMapper>(),
            get<_i29.PrivateKeyMapper>(),
            get<_i21.IdentityDTOMapper>(),
            get<_i64.RhsNodeMapper>(),
          ));
  gh.factory<_i74.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i68.ProofRepositoryImpl>()));
  gh.factoryAsync<_i75.RemoveClaimsUseCase>(() async =>
      _i75.RemoveClaimsUseCase(
          await get.getAsync<_i69.CredentialRepository>()));
  gh.factoryAsync<_i76.UpdateClaimUseCase>(() async =>
      _i76.UpdateClaimUseCase(await get.getAsync<_i69.CredentialRepository>()));
  gh.factoryAsync<_i77.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i72.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i78.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i73.IdentityRepositoryImpl>()));
  gh.factory<_i79.IsProofCircuitSupportedUseCase>(
      () => _i79.IsProofCircuitSupportedUseCase(get<_i74.ProofRepository>()));
  gh.factoryAsync<_i80.RemoveCurrentIdentityUseCase>(() async =>
      _i80.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i81.SignMessageUseCase>(() async =>
      _i81.SignMessageUseCase(await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i82.CreateIdentityUseCase>(() async =>
      _i82.CreateIdentityUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i83.FetchIdentityStateUseCase>(() async =>
      _i83.FetchIdentityStateUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i84.FetchStateRootsUseCase>(() async =>
      _i84.FetchStateRootsUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i85.GenerateNonRevProofUseCase>(
      () async => _i85.GenerateNonRevProofUseCase(
            await get.getAsync<_i78.IdentityRepository>(),
            await get.getAsync<_i69.CredentialRepository>(),
            get<_i14.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i86.GetAuthTokenUseCase>(
      () async => _i86.GetAuthTokenUseCase(
            await get.getAsync<_i77.Iden3commRepository>(),
            get<_i74.ProofRepository>(),
            await get.getAsync<_i78.IdentityRepository>(),
          ));
  gh.factoryAsync<_i87.GetClaimRevocationStatusUseCase>(
      () async => _i87.GetClaimRevocationStatusUseCase(
            await get.getAsync<_i69.CredentialRepository>(),
            await get.getAsync<_i78.IdentityRepository>(),
            await get.getAsync<_i85.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i88.GetCurrentIdentifierUseCase>(() async =>
      _i88.GetCurrentIdentifierUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i89.GetDidIdentifierUseCase>(() async =>
      _i89.GetDidIdentifierUseCase(
          await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i90.GetIdentityUseCase>(() async =>
      _i90.GetIdentityUseCase(await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i91.GetPublicKeysUseCase>(() async =>
      _i91.GetPublicKeysUseCase(await get.getAsync<_i78.IdentityRepository>()));
  gh.factoryAsync<_i92.IdentityWallet>(() async => _i92.IdentityWallet(
        await get.getAsync<_i82.CreateIdentityUseCase>(),
        await get.getAsync<_i90.GetIdentityUseCase>(),
        await get.getAsync<_i81.SignMessageUseCase>(),
        await get.getAsync<_i88.GetCurrentIdentifierUseCase>(),
        await get.getAsync<_i80.RemoveCurrentIdentityUseCase>(),
        await get.getAsync<_i83.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i93.FetchAndSaveClaimsUseCase>(
      () async => _i93.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i86.GetAuthTokenUseCase>(),
            await get.getAsync<_i69.CredentialRepository>(),
          ));
  gh.factoryAsync<_i94.GenerateProofUseCase>(
      () async => _i94.GenerateProofUseCase(
            get<_i74.ProofRepository>(),
            await get.getAsync<_i69.CredentialRepository>(),
            await get.getAsync<_i87.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i95.GetProofsUseCase>(() async => _i95.GetProofsUseCase(
        get<_i74.ProofRepository>(),
        await get.getAsync<_i78.IdentityRepository>(),
        await get.getAsync<_i70.GetClaimsUseCase>(),
        await get.getAsync<_i94.GenerateProofUseCase>(),
        await get.getAsync<_i91.GetPublicKeysUseCase>(),
        get<_i79.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i96.ProofGeneration>(() async =>
      _i96.ProofGeneration(await get.getAsync<_i94.GenerateProofUseCase>()));
  gh.factoryAsync<_i97.AuthenticateUseCase>(
      () async => _i97.AuthenticateUseCase(
            await get.getAsync<_i77.Iden3commRepository>(),
            await get.getAsync<_i95.GetProofsUseCase>(),
            await get.getAsync<_i86.GetAuthTokenUseCase>(),
            get<_i14.GetEnvConfigUseCase>(),
            await get.getAsync<_i89.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i98.CredentialWallet>(() async => _i98.CredentialWallet(
        await get.getAsync<_i93.FetchAndSaveClaimsUseCase>(),
        await get.getAsync<_i70.GetClaimsUseCase>(),
        await get.getAsync<_i75.RemoveClaimsUseCase>(),
        await get.getAsync<_i76.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i99.Iden3comm>(() async => _i99.Iden3comm(
        await get.getAsync<_i71.GetVocabsUseCase>(),
        await get.getAsync<_i97.AuthenticateUseCase>(),
        await get.getAsync<_i95.GetProofsUseCase>(),
        get<_i59.Iden3MessageMapper>(),
        get<_i65.SchemaInfoMapper>(),
      ));
  return get;
}

class _$NetworkModule extends _i100.NetworkModule {}

class _$DatabaseModule extends _i100.DatabaseModule {}

class _$Sdk extends _i100.Sdk {}

class _$RepositoriesModule extends _i100.RepositoriesModule {}
