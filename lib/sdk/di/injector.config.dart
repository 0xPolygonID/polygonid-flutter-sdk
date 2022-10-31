// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i11;
import 'package:web3dart/web3dart.dart' as _i48;

import '../../common/data/data_sources/env_datasource.dart' as _i58;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i67;
import '../../common/domain/repositories/config_repository.dart' as _i15;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i14;
import '../../credential/data/credential_repository_impl.dart' as _i68;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i39;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i56;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i55;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i10;
import '../../credential/data/mappers/filter_mapper.dart' as _i12;
import '../../credential/data/mappers/filters_mapper.dart' as _i13;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i17;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i42;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i70;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i94;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i88;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i71;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i72;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i76;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i77;
import '../../env/sdk_env.dart' as _i46;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i36;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i40;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i54;
import '../../iden3comm/data/mappers/auth_response_mapper.dart' as _i3;
import '../../iden3comm/data/mappers/contract_func_call_request_mapper.dart'
    as _i9;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i59;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i19;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i29;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i34;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i35;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i63;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i73;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i78;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i98;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i87;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i96;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i22;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i23;
import '../../identity/data/data_sources/local_identity_data_source.dart'
    as _i25;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i41;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i64;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i61;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i62;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i47;
import '../../identity/data/mappers/hex_mapper.dart' as _i16;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i21;
import '../../identity/data/mappers/private_key_mapper.dart' as _i30;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i65;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i43;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i74;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i44;
import '../../identity/domain/repositories/identity_repository.dart' as _i79;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i27;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i83;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i84;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i85;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i86;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i89;
import '../../identity/domain/use_cases/get_did_identifier_use_case.dart'
    as _i90;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i91;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i92;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i81;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i82;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i18;
import '../../identity/libs/smt/hash.dart' as _i45;
import '../../identity/libs/smt/merkletree.dart' as _i26;
import '../../identity/libs/smt/node.dart' as _i28;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i53;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i24;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i31;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i38;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i50;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i32;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i69;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i75;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i95;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i80;
import '../../proof_generation/libs/prover/prover.dart' as _i37;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i51;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i52;
import '../credential_wallet.dart' as _i99;
import '../iden3comm.dart' as _i100;
import '../identity_wallet.dart' as _i93;
import '../mappers/iden3_message_mapper.dart' as _i60;
import '../mappers/iden3_message_type_mapper.dart' as _i20;
import '../mappers/schema_info_mapper.dart' as _i66;
import '../proof_generation.dart' as _i97;
import 'injector.dart' as _i101; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i25.LocalIdentityDataSource>(
      () => _i25.LocalIdentityDataSource());
  gh.factory<_i26.MerkleTree>(() => _i26.MerkleTree(
        get<_i18.Iden3CoreLib>(),
        get<_i27.SMTStorageRepository>(),
        get<int>(),
      ));
  gh.factory<_i28.Node>(() => _i28.Node(
        get<_i28.NodeType>(),
        get<_i18.Iden3CoreLib>(),
      ));
  gh.factory<_i29.OfferRequestMapper>(
      () => _i29.OfferRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i30.PrivateKeyMapper>(() => _i30.PrivateKeyMapper());
  gh.factory<_i31.ProofCircuitDataSource>(() => _i31.ProofCircuitDataSource());
  gh.factory<_i32.ProofMapper>(() => _i32.ProofMapper());
  gh.factory<_i33.ProofQueryMapper>(() => _i33.ProofQueryMapper());
  gh.factory<_i34.ProofQueryParamMapper>(() => _i34.ProofQueryParamMapper());
  gh.factory<_i35.ProofRequestFiltersMapper>(
      () => _i35.ProofRequestFiltersMapper(get<_i33.ProofQueryMapper>()));
  gh.factory<_i36.ProofScopeDataSource>(() => _i36.ProofScopeDataSource());
  gh.factory<_i37.ProverLib>(() => _i37.ProverLib());
  gh.factory<_i38.ProverLibWrapper>(() => _i38.ProverLibWrapper());
  gh.factory<_i39.RemoteClaimDataSource>(
      () => _i39.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i40.RemoteIden3commDataSource>(
      () => _i40.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i41.RemoteIdentityDataSource>(
      () => _i41.RemoteIdentityDataSource());
  gh.factory<_i42.RevocationStatusMapper>(() => _i42.RevocationStatusMapper());
  gh.factory<_i43.RhsNodeTypeMapper>(() => _i43.RhsNodeTypeMapper());
  gh.factory<_i44.SMTMemoryStorageRepositoryImpl>(
      () => _i44.SMTMemoryStorageRepositoryImpl(
            get<_i45.Hash>(),
            get<Map<_i45.Hash, _i28.Node>>(),
          ));
  gh.lazySingleton<_i46.SdkEnv>(() => sdk.sdkEnv);
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
  gh.factory<_i47.WalletLibWrapper>(() => _i47.WalletLibWrapper());
  gh.factory<_i48.Web3Client>(
      () => networkModule.web3Client(get<_i46.SdkEnv>()));
  gh.factory<_i49.WitnessAuthLib>(() => _i49.WitnessAuthLib());
  gh.factory<_i50.WitnessIsolatesWrapper>(() => _i50.WitnessIsolatesWrapper());
  gh.factory<_i51.WitnessMtpLib>(() => _i51.WitnessMtpLib());
  gh.factory<_i52.WitnessSigLib>(() => _i52.WitnessSigLib());
  gh.factory<_i53.AtomicQueryInputsWrapper>(
      () => _i53.AtomicQueryInputsWrapper(get<_i18.Iden3CoreLib>()));
  gh.factory<_i54.AuthRequestMapper>(
      () => _i54.AuthRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i55.ClaimMapper>(() => _i55.ClaimMapper(
        get<_i7.ClaimStateMapper>(),
        get<_i6.ClaimInfoMapper>(),
      ));
  gh.factory<_i56.ClaimStoreRefWrapper>(() => _i56.ClaimStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i57.ContractRequestMapper>(
      () => _i57.ContractRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.EnvDataSource>(() => _i58.EnvDataSource(get<_i46.SdkEnv>()));
  gh.factory<_i59.FetchRequestMapper>(
      () => _i59.FetchRequestMapper(get<_i19.Iden3MessageTypeDataMapper>()));
  gh.factory<_i60.Iden3MessageMapper>(
      () => _i60.Iden3MessageMapper(get<_i20.Iden3MessageTypeMapper>()));
  gh.factory<_i61.IdentityStoreRefWrapper>(() => _i61.IdentityStoreRefWrapper(
      get<_i11.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i62.KeyValueStoreRefWrapper>(() => _i62.KeyValueStoreRefWrapper(
      get<_i11.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i63.ProofRequestsMapper>(() => _i63.ProofRequestsMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i59.FetchRequestMapper>(),
        get<_i29.OfferRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
        get<_i34.ProofQueryParamMapper>(),
      ));
  gh.factory<_i38.ProverLibDataSource>(
      () => _i38.ProverLibDataSource(get<_i38.ProverLibWrapper>()));
  gh.factory<_i64.RPCDataSource>(
      () => _i64.RPCDataSource(get<_i48.Web3Client>()));
  gh.factory<_i65.RhsNodeMapper>(
      () => _i65.RhsNodeMapper(get<_i43.RhsNodeTypeMapper>()));
  gh.factory<_i66.SchemaInfoMapper>(() => _i66.SchemaInfoMapper(
        get<_i54.AuthRequestMapper>(),
        get<_i57.ContractRequestMapper>(),
      ));
  gh.factoryAsync<_i56.StorageClaimDataSource>(
      () async => _i56.StorageClaimDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i56.ClaimStoreRefWrapper>(),
          ));
  gh.factoryAsync<_i62.StorageKeyValueDataSource>(
      () async => _i62.StorageKeyValueDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i62.KeyValueStoreRefWrapper>(),
          ));
  gh.factory<_i47.WalletDataSource>(
      () => _i47.WalletDataSource(get<_i47.WalletLibWrapper>()));
  gh.factory<_i50.WitnessDataSource>(
      () => _i50.WitnessDataSource(get<_i50.WitnessIsolatesWrapper>()));
  gh.factory<_i53.AtomicQueryInputsDataSource>(() =>
      _i53.AtomicQueryInputsDataSource(get<_i53.AtomicQueryInputsWrapper>()));
  gh.factory<_i67.ConfigRepositoryImpl>(
      () => _i67.ConfigRepositoryImpl(get<_i58.EnvDataSource>()));
  gh.factoryAsync<_i68.CredentialRepositoryImpl>(
      () async => _i68.CredentialRepositoryImpl(
            get<_i39.RemoteClaimDataSource>(),
            await get.getAsync<_i56.StorageClaimDataSource>(),
            get<_i41.RemoteIdentityDataSource>(),
            get<_i10.CredentialRequestMapper>(),
            get<_i55.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i17.IdFilterMapper>(),
            get<_i42.RevocationStatusMapper>(),
          ));
  gh.factory<_i22.JWZDataSource>(() => _i22.JWZDataSource(
        get<_i4.BabyjubjubLib>(),
        get<_i47.WalletDataSource>(),
        get<_i22.JWZIsolatesWrapper>(),
      ));
  gh.factory<_i69.ProofRepositoryImpl>(() => _i69.ProofRepositoryImpl(
        get<_i50.WitnessDataSource>(),
        get<_i38.ProverLibDataSource>(),
        get<_i53.AtomicQueryInputsDataSource>(),
        get<_i24.LocalFilesDataSource>(),
        get<_i31.ProofCircuitDataSource>(),
        get<_i41.RemoteIdentityDataSource>(),
        get<_i5.CircuitTypeMapper>(),
        get<_i63.ProofRequestsMapper>(),
        get<_i35.ProofRequestFiltersMapper>(),
        get<_i32.ProofMapper>(),
        get<_i55.ClaimMapper>(),
        get<_i42.RevocationStatusMapper>(),
      ));
  gh.factoryAsync<_i61.StorageIdentityDataSource>(
      () async => _i61.StorageIdentityDataSource(
            await get.getAsync<_i11.Database>(),
            get<_i61.IdentityStoreRefWrapper>(),
            await get.getAsync<_i62.StorageKeyValueDataSource>(),
          ));
  gh.factoryAsync<_i70.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i68.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i71.GetClaimsUseCase>(() async =>
      _i71.GetClaimsUseCase(await get.getAsync<_i70.CredentialRepository>()));
  gh.factoryAsync<_i72.GetVocabsUseCase>(() async =>
      _i72.GetVocabsUseCase(await get.getAsync<_i70.CredentialRepository>()));
  gh.factoryAsync<_i73.Iden3commRepositoryImpl>(
      () async => _i73.Iden3commRepositoryImpl(
            get<_i40.RemoteIden3commDataSource>(),
            get<_i22.JWZDataSource>(),
            get<_i16.HexMapper>(),
            get<_i36.ProofScopeDataSource>(),
            await get.getAsync<_i56.StorageClaimDataSource>(),
            get<_i55.ClaimMapper>(),
            get<_i13.FiltersMapper>(),
            get<_i3.AuthResponseMapper>(),
            get<_i54.AuthRequestMapper>(),
          ));
  gh.factoryAsync<_i74.IdentityRepositoryImpl>(
      () async => _i74.IdentityRepositoryImpl(
            get<_i47.WalletDataSource>(),
            get<_i23.LibIdentityDataSource>(),
            get<_i25.LocalIdentityDataSource>(),
            get<_i41.RemoteIdentityDataSource>(),
            await get.getAsync<_i61.StorageIdentityDataSource>(),
            await get.getAsync<_i62.StorageKeyValueDataSource>(),
            get<_i64.RPCDataSource>(),
            get<_i16.HexMapper>(),
            get<_i30.PrivateKeyMapper>(),
            get<_i21.IdentityDTOMapper>(),
            get<_i65.RhsNodeMapper>(),
          ));
  gh.factory<_i75.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i69.ProofRepositoryImpl>()));
  gh.factoryAsync<_i76.RemoveClaimsUseCase>(() async =>
      _i76.RemoveClaimsUseCase(
          await get.getAsync<_i70.CredentialRepository>()));
  gh.factoryAsync<_i77.UpdateClaimUseCase>(() async =>
      _i77.UpdateClaimUseCase(await get.getAsync<_i70.CredentialRepository>()));
  gh.factoryAsync<_i78.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i73.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i79.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i74.IdentityRepositoryImpl>()));
  gh.factory<_i80.IsProofCircuitSupportedUseCase>(
      () => _i80.IsProofCircuitSupportedUseCase(get<_i75.ProofRepository>()));
  gh.factoryAsync<_i81.RemoveCurrentIdentityUseCase>(() async =>
      _i81.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i82.SignMessageUseCase>(() async =>
      _i82.SignMessageUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i83.CreateIdentityUseCase>(() async =>
      _i83.CreateIdentityUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i84.FetchIdentityStateUseCase>(() async =>
      _i84.FetchIdentityStateUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i85.FetchStateRootsUseCase>(() async =>
      _i85.FetchStateRootsUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i86.GenerateNonRevProofUseCase>(
      () async => _i86.GenerateNonRevProofUseCase(
            await get.getAsync<_i79.IdentityRepository>(),
            await get.getAsync<_i70.CredentialRepository>(),
            get<_i14.GetEnvConfigUseCase>(),
          ));
  gh.factoryAsync<_i87.GetAuthTokenUseCase>(
      () async => _i87.GetAuthTokenUseCase(
            await get.getAsync<_i78.Iden3commRepository>(),
            get<_i75.ProofRepository>(),
            await get.getAsync<_i79.IdentityRepository>(),
          ));
  gh.factoryAsync<_i88.GetClaimRevocationStatusUseCase>(
      () async => _i88.GetClaimRevocationStatusUseCase(
            await get.getAsync<_i70.CredentialRepository>(),
            await get.getAsync<_i79.IdentityRepository>(),
            await get.getAsync<_i86.GenerateNonRevProofUseCase>(),
          ));
  gh.factoryAsync<_i89.GetCurrentIdentifierUseCase>(() async =>
      _i89.GetCurrentIdentifierUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i90.GetDidIdentifierUseCase>(() async =>
      _i90.GetDidIdentifierUseCase(
          await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i91.GetIdentityUseCase>(() async =>
      _i91.GetIdentityUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i92.GetPublicKeysUseCase>(() async =>
      _i92.GetPublicKeysUseCase(await get.getAsync<_i79.IdentityRepository>()));
  gh.factoryAsync<_i93.IdentityWallet>(() async => _i93.IdentityWallet(
        await get.getAsync<_i83.CreateIdentityUseCase>(),
        await get.getAsync<_i91.GetIdentityUseCase>(),
        await get.getAsync<_i82.SignMessageUseCase>(),
        await get.getAsync<_i89.GetCurrentIdentifierUseCase>(),
        await get.getAsync<_i81.RemoveCurrentIdentityUseCase>(),
        await get.getAsync<_i84.FetchIdentityStateUseCase>(),
      ));
  gh.factoryAsync<_i94.FetchAndSaveClaimsUseCase>(
      () async => _i94.FetchAndSaveClaimsUseCase(
            await get.getAsync<_i87.GetAuthTokenUseCase>(),
            await get.getAsync<_i70.CredentialRepository>(),
          ));
  gh.factoryAsync<_i95.GenerateProofUseCase>(
      () async => _i95.GenerateProofUseCase(
            get<_i75.ProofRepository>(),
            await get.getAsync<_i70.CredentialRepository>(),
            await get.getAsync<_i88.GetClaimRevocationStatusUseCase>(),
          ));
  gh.factoryAsync<_i96.GetProofsUseCase>(() async => _i96.GetProofsUseCase(
        get<_i75.ProofRepository>(),
        await get.getAsync<_i79.IdentityRepository>(),
        await get.getAsync<_i71.GetClaimsUseCase>(),
        await get.getAsync<_i95.GenerateProofUseCase>(),
        await get.getAsync<_i92.GetPublicKeysUseCase>(),
        get<_i80.IsProofCircuitSupportedUseCase>(),
      ));
  gh.factoryAsync<_i97.ProofGeneration>(() async =>
      _i97.ProofGeneration(await get.getAsync<_i95.GenerateProofUseCase>()));
  gh.factoryAsync<_i98.AuthenticateUseCase>(
      () async => _i98.AuthenticateUseCase(
            await get.getAsync<_i78.Iden3commRepository>(),
            await get.getAsync<_i96.GetProofsUseCase>(),
            await get.getAsync<_i87.GetAuthTokenUseCase>(),
            get<_i14.GetEnvConfigUseCase>(),
            await get.getAsync<_i90.GetDidIdentifierUseCase>(),
          ));
  gh.factoryAsync<_i99.CredentialWallet>(() async => _i99.CredentialWallet(
        await get.getAsync<_i94.FetchAndSaveClaimsUseCase>(),
        await get.getAsync<_i71.GetClaimsUseCase>(),
        await get.getAsync<_i76.RemoveClaimsUseCase>(),
        await get.getAsync<_i77.UpdateClaimUseCase>(),
      ));
  gh.factoryAsync<_i100.Iden3comm>(() async => _i100.Iden3comm(
        await get.getAsync<_i72.GetVocabsUseCase>(),
        await get.getAsync<_i98.AuthenticateUseCase>(),
        await get.getAsync<_i96.GetProofsUseCase>(),
        get<_i60.Iden3MessageMapper>(),
        get<_i66.SchemaInfoMapper>(),
      ));
  return get;
}

class _$NetworkModule extends _i101.NetworkModule {}

class _$DatabaseModule extends _i101.DatabaseModule {}

class _$Sdk extends _i101.Sdk {}

class _$RepositoriesModule extends _i101.RepositoriesModule {}
