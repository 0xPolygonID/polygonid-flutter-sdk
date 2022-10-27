// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i10;
import 'package:web3dart/web3dart.dart' as _i44;

import '../../common/data/data_sources/env_datasource.dart' as _i54;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i63;
import '../../common/domain/repositories/config_repository.dart' as _i66;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i69;
import '../../credential/data/credential_repository_impl.dart' as _i64;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i35;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i52;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i51;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i11;
import '../../credential/data/mappers/filters_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i14;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i38;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i67;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i91;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i86;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i68;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i70;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i74;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i75;
import '../../env/sdk_env.dart' as _i42;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i32;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i36;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i50;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i53;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i55;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i16;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i25;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i29;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i30;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i59;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i71;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i76;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i95;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i85;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i93;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i19;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i20;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i37;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i60;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i57;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i58;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i43;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i3;
import '../../identity/data/mappers/hex_mapper.dart' as _i13;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i18;
import '../../identity/data/mappers/private_key_mapper.dart' as _i26;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i61;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i39;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i72;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i40;
import '../../identity/domain/repositories/identity_repository.dart' as _i77;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i23;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i81;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i82;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i83;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i84;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i87;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i88;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i89;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i79;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i80;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i15;
import '../../identity/libs/smt/hash.dart' as _i41;
import '../../identity/libs/smt/merkletree.dart' as _i22;
import '../../identity/libs/smt/node.dart' as _i24;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i49;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i21;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i34;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i46;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i28;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i65;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i73;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i92;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i78;
import '../../proof_generation/libs/prover/prover.dart' as _i33;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i45;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i47;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i48;
import '../credential_wallet.dart' as _i96;
import '../iden3comm.dart' as _i97;
import '../identity_wallet.dart' as _i90;
import '../mappers/iden3_message_mapper.dart' as _i56;
import '../mappers/iden3_message_type_mapper.dart' as _i17;
import '../mappers/schema_info_mapper.dart' as _i62;
import '../proof_generation.dart' as _i94;
import 'injector.dart' as _i98; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
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
  gh.factory<_i9.CredentialRequestMapper>(() => _i9.CredentialRequestMapper());
  gh.lazySingletonAsync<_i10.Database>(() => databaseModule.database());
  gh.factory<_i11.FilterMapper>(() => _i11.FilterMapper());
  gh.factory<_i12.FiltersMapper>(
      () => _i12.FiltersMapper(get<_i11.FilterMapper>()));
  gh.factory<_i13.HexMapper>(() => _i13.HexMapper());
  gh.factory<_i14.IdFilterMapper>(() => _i14.IdFilterMapper());
  gh.factory<_i15.Iden3CoreLib>(() => _i15.Iden3CoreLib());
  gh.factory<_i16.Iden3MessageTypeDataMapper>(
      () => _i16.Iden3MessageTypeDataMapper());
  gh.factory<_i17.Iden3MessageTypeMapper>(() => _i17.Iden3MessageTypeMapper());
  gh.factory<_i18.IdentityDTOMapper>(() => _i18.IdentityDTOMapper());
  gh.factory<_i19.JWZIsolatesWrapper>(() => _i19.JWZIsolatesWrapper());
  gh.factory<_i20.LibIdentityDataSource>(
      () => _i20.LibIdentityDataSource(get<_i15.Iden3CoreLib>()));
  gh.factory<_i21.LocalFilesDataSource>(() => _i21.LocalFilesDataSource());
  gh.factory<_i22.MerkleTree>(() => _i22.MerkleTree(
      get<_i15.Iden3CoreLib>(), get<_i23.SMTStorageRepository>(), get<int>()));
  gh.factory<_i24.Node>(
      () => _i24.Node(get<_i24.NodeType>(), get<_i15.Iden3CoreLib>()));
  gh.factory<_i25.OfferRequestMapper>(
      () => _i25.OfferRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i26.PrivateKeyMapper>(() => _i26.PrivateKeyMapper());
  gh.factory<_i27.ProofCircuitDataSource>(() => _i27.ProofCircuitDataSource());
  gh.factory<_i28.ProofMapper>(() => _i28.ProofMapper());
  gh.factory<_i29.ProofQueryMapper>(() => _i29.ProofQueryMapper());
  gh.factory<_i30.ProofQueryParamMapper>(() => _i30.ProofQueryParamMapper());
  gh.factory<_i31.ProofRequestFiltersMapper>(
      () => _i31.ProofRequestFiltersMapper(get<_i29.ProofQueryMapper>()));
  gh.factory<_i32.ProofScopeDataSource>(() => _i32.ProofScopeDataSource());
  gh.factory<_i33.ProverLib>(() => _i33.ProverLib());
  gh.factory<_i34.ProverLibWrapper>(() => _i34.ProverLibWrapper());
  gh.factory<_i35.RemoteClaimDataSource>(
      () => _i35.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i36.RemoteIden3commDataSource>(
      () => _i36.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i37.RemoteIdentityDataSource>(
      () => _i37.RemoteIdentityDataSource());
  gh.factory<_i38.RevocationStatusMapper>(() => _i38.RevocationStatusMapper());
  gh.factory<_i39.RhsNodeTypeMapper>(() => _i39.RhsNodeTypeMapper());
  gh.factory<_i40.SMTMemoryStorageRepositoryImpl>(() =>
      _i40.SMTMemoryStorageRepositoryImpl(
          get<_i41.Hash>(), get<Map<_i41.Hash, _i24.Node>>()));
  gh.lazySingleton<_i42.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i10.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i43.WalletLibWrapper>(() => _i43.WalletLibWrapper());
  gh.factory<_i44.Web3Client>(
      () => networkModule.web3Client(get<_i42.SdkEnv>()));
  gh.factory<_i45.WitnessAuthLib>(() => _i45.WitnessAuthLib());
  gh.factory<_i46.WitnessIsolatesWrapper>(() => _i46.WitnessIsolatesWrapper());
  gh.factory<_i47.WitnessMtpLib>(() => _i47.WitnessMtpLib());
  gh.factory<_i48.WitnessSigLib>(() => _i48.WitnessSigLib());
  gh.factory<_i49.AtomicQueryInputsWrapper>(
      () => _i49.AtomicQueryInputsWrapper(get<_i15.Iden3CoreLib>()));
  gh.factory<_i50.AuthRequestMapper>(
      () => _i50.AuthRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i51.ClaimMapper>(() => _i51.ClaimMapper(
      get<_i7.ClaimStateMapper>(), get<_i6.ClaimInfoMapper>()));
  gh.factory<_i52.ClaimStoreRefWrapper>(() => _i52.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i53.ContractRequestMapper>(
      () => _i53.ContractRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i54.EnvDataSource>(() => _i54.EnvDataSource(get<_i42.SdkEnv>()));
  gh.factory<_i55.FetchRequestMapper>(
      () => _i55.FetchRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i56.Iden3MessageMapper>(
      () => _i56.Iden3MessageMapper(get<_i17.Iden3MessageTypeMapper>()));
  gh.factory<_i57.IdentityStoreRefWrapper>(() => _i57.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i58.KeyValueStoreRefWrapper>(() => _i58.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i59.ProofRequestsMapper>(() => _i59.ProofRequestsMapper(
      get<_i50.AuthRequestMapper>(),
      get<_i55.FetchRequestMapper>(),
      get<_i25.OfferRequestMapper>(),
      get<_i53.ContractRequestMapper>(),
      get<_i30.ProofQueryParamMapper>()));
  gh.factory<_i34.ProverLibDataSource>(
      () => _i34.ProverLibDataSource(get<_i34.ProverLibWrapper>()));
  gh.factory<_i60.RPCDataSource>(
      () => _i60.RPCDataSource(get<_i44.Web3Client>()));
  gh.factory<_i61.RhsNodeMapper>(
      () => _i61.RhsNodeMapper(get<_i39.RhsNodeTypeMapper>()));
  gh.factory<_i62.SchemaInfoMapper>(() => _i62.SchemaInfoMapper(
      get<_i50.AuthRequestMapper>(), get<_i53.ContractRequestMapper>()));
  gh.factoryAsync<_i52.StorageClaimDataSource>(() async =>
      _i52.StorageClaimDataSource(await get.getAsync<_i10.Database>(),
          get<_i52.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i58.StorageKeyValueDataSource>(() async =>
      _i58.StorageKeyValueDataSource(await get.getAsync<_i10.Database>(),
          get<_i58.KeyValueStoreRefWrapper>()));
  gh.factory<_i43.WalletDataSource>(
      () => _i43.WalletDataSource(get<_i43.WalletLibWrapper>()));
  gh.factory<_i46.WitnessDataSource>(
      () => _i46.WitnessDataSource(get<_i46.WitnessIsolatesWrapper>()));
  gh.factory<_i49.AtomicQueryInputsDataSource>(() =>
      _i49.AtomicQueryInputsDataSource(get<_i49.AtomicQueryInputsWrapper>()));
  gh.factory<_i63.ConfigRepositoryImpl>(
      () => _i63.ConfigRepositoryImpl(get<_i54.EnvDataSource>()));
  gh.factoryAsync<_i64.CredentialRepositoryImpl>(() async =>
      _i64.CredentialRepositoryImpl(
          get<_i35.RemoteClaimDataSource>(),
          await get.getAsync<_i52.StorageClaimDataSource>(),
          get<_i37.RemoteIdentityDataSource>(),
          get<_i9.CredentialRequestMapper>(),
          get<_i51.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i14.IdFilterMapper>(),
          get<_i38.RevocationStatusMapper>()));
  gh.factory<_i19.JWZDataSource>(() => _i19.JWZDataSource(
      get<_i4.BabyjubjubLib>(),
      get<_i43.WalletDataSource>(),
      get<_i19.JWZIsolatesWrapper>()));
  gh.factory<_i65.ProofRepositoryImpl>(() => _i65.ProofRepositoryImpl(
      get<_i46.WitnessDataSource>(),
      get<_i34.ProverLibDataSource>(),
      get<_i49.AtomicQueryInputsDataSource>(),
      get<_i21.LocalFilesDataSource>(),
      get<_i27.ProofCircuitDataSource>(),
      get<_i37.RemoteIdentityDataSource>(),
      get<_i5.CircuitTypeMapper>(),
      get<_i59.ProofRequestsMapper>(),
      get<_i31.ProofRequestFiltersMapper>(),
      get<_i28.ProofMapper>(),
      get<_i51.ClaimMapper>(),
      get<_i38.RevocationStatusMapper>()));
  gh.factoryAsync<_i57.StorageIdentityDataSource>(() async =>
      _i57.StorageIdentityDataSource(
          await get.getAsync<_i10.Database>(),
          get<_i57.IdentityStoreRefWrapper>(),
          await get.getAsync<_i58.StorageKeyValueDataSource>()));
  gh.factory<_i66.ConfigRepository>(() =>
      repositoriesModule.configRepository(get<_i63.ConfigRepositoryImpl>()));
  gh.factoryAsync<_i67.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i64.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i68.GetClaimsUseCase>(() async =>
      _i68.GetClaimsUseCase(await get.getAsync<_i67.CredentialRepository>()));
  gh.factory<_i69.GetEnvConfigUseCase>(
      () => _i69.GetEnvConfigUseCase(get<_i66.ConfigRepository>()));
  gh.factoryAsync<_i70.GetVocabsUseCase>(() async =>
      _i70.GetVocabsUseCase(await get.getAsync<_i67.CredentialRepository>()));
  gh.factoryAsync<_i71.Iden3commRepositoryImpl>(() async =>
      _i71.Iden3commRepositoryImpl(
          get<_i36.RemoteIden3commDataSource>(),
          get<_i19.JWZDataSource>(),
          get<_i13.HexMapper>(),
          get<_i32.ProofScopeDataSource>(),
          await get.getAsync<_i52.StorageClaimDataSource>(),
          get<_i51.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i3.AuthResponseMapper>(),
          get<_i50.AuthRequestMapper>()));
  gh.factoryAsync<_i72.IdentityRepositoryImpl>(() async =>
      _i72.IdentityRepositoryImpl(
          get<_i43.WalletDataSource>(),
          get<_i20.LibIdentityDataSource>(),
          get<_i37.RemoteIdentityDataSource>(),
          await get.getAsync<_i57.StorageIdentityDataSource>(),
          await get.getAsync<_i58.StorageKeyValueDataSource>(),
          get<_i60.RPCDataSource>(),
          get<_i13.HexMapper>(),
          get<_i26.PrivateKeyMapper>(),
          get<_i18.IdentityDTOMapper>(),
          get<_i61.RhsNodeMapper>()));
  gh.factory<_i73.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i65.ProofRepositoryImpl>()));
  gh.factoryAsync<_i74.RemoveClaimsUseCase>(() async =>
      _i74.RemoveClaimsUseCase(
          await get.getAsync<_i67.CredentialRepository>()));
  gh.factoryAsync<_i75.UpdateClaimUseCase>(() async =>
      _i75.UpdateClaimUseCase(await get.getAsync<_i67.CredentialRepository>()));
  gh.factoryAsync<_i76.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i71.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i77.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i72.IdentityRepositoryImpl>()));
  gh.factory<_i78.IsProofCircuitSupportedUseCase>(
      () => _i78.IsProofCircuitSupportedUseCase(get<_i73.ProofRepository>()));
  gh.factoryAsync<_i79.RemoveCurrentIdentityUseCase>(() async =>
      _i79.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i80.SignMessageUseCase>(() async =>
      _i80.SignMessageUseCase(await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i81.CreateIdentityUseCase>(() async =>
      _i81.CreateIdentityUseCase(
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i82.FetchIdentityStateUseCase>(() async =>
      _i82.FetchIdentityStateUseCase(
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i83.FetchStateRootsUseCase>(() async =>
      _i83.FetchStateRootsUseCase(
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i84.GenerateNonRevProofUseCase>(() async =>
      _i84.GenerateNonRevProofUseCase(
          await get.getAsync<_i77.IdentityRepository>(),
          await get.getAsync<_i67.CredentialRepository>(),
          get<_i69.GetEnvConfigUseCase>()));
  gh.factoryAsync<_i85.GetAuthTokenUseCase>(() async =>
      _i85.GetAuthTokenUseCase(
          await get.getAsync<_i76.Iden3commRepository>(),
          get<_i73.ProofRepository>(),
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i86.GetClaimRevocationStatusUseCase>(() async =>
      _i86.GetClaimRevocationStatusUseCase(
          await get.getAsync<_i67.CredentialRepository>(),
          await get.getAsync<_i77.IdentityRepository>(),
          await get.getAsync<_i84.GenerateNonRevProofUseCase>()));
  gh.factoryAsync<_i87.GetCurrentIdentifierUseCase>(() async =>
      _i87.GetCurrentIdentifierUseCase(
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i88.GetIdentityUseCase>(() async =>
      _i88.GetIdentityUseCase(await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i89.GetPublicKeysUseCase>(() async =>
      _i89.GetPublicKeysUseCase(await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i90.IdentityWallet>(() async => _i90.IdentityWallet(
      await get.getAsync<_i81.CreateIdentityUseCase>(),
      await get.getAsync<_i88.GetIdentityUseCase>(),
      await get.getAsync<_i80.SignMessageUseCase>(),
      await get.getAsync<_i87.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i79.RemoveCurrentIdentityUseCase>(),
      await get.getAsync<_i82.FetchIdentityStateUseCase>()));
  gh.factoryAsync<_i91.FetchAndSaveClaimsUseCase>(() async =>
      _i91.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i85.GetAuthTokenUseCase>(),
          await get.getAsync<_i67.CredentialRepository>()));
  gh.factoryAsync<_i92.GenerateProofUseCase>(() async =>
      _i92.GenerateProofUseCase(
          get<_i73.ProofRepository>(),
          await get.getAsync<_i67.CredentialRepository>(),
          await get.getAsync<_i86.GetClaimRevocationStatusUseCase>()));
  gh.factoryAsync<_i93.GetProofsUseCase>(() async => _i93.GetProofsUseCase(
      get<_i73.ProofRepository>(),
      await get.getAsync<_i77.IdentityRepository>(),
      await get.getAsync<_i68.GetClaimsUseCase>(),
      await get.getAsync<_i92.GenerateProofUseCase>(),
      await get.getAsync<_i89.GetPublicKeysUseCase>(),
      get<_i78.IsProofCircuitSupportedUseCase>()));
  gh.factoryAsync<_i94.ProofGeneration>(() async =>
      _i94.ProofGeneration(await get.getAsync<_i92.GenerateProofUseCase>()));
  gh.factoryAsync<_i95.AuthenticateUseCase>(() async =>
      _i95.AuthenticateUseCase(
          await get.getAsync<_i76.Iden3commRepository>(),
          await get.getAsync<_i93.GetProofsUseCase>(),
          await get.getAsync<_i85.GetAuthTokenUseCase>()));
  gh.factoryAsync<_i96.CredentialWallet>(() async => _i96.CredentialWallet(
      await get.getAsync<_i91.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i68.GetClaimsUseCase>(),
      await get.getAsync<_i74.RemoveClaimsUseCase>(),
      await get.getAsync<_i75.UpdateClaimUseCase>()));
  gh.factoryAsync<_i97.Iden3comm>(() async => _i97.Iden3comm(
      await get.getAsync<_i70.GetVocabsUseCase>(),
      await get.getAsync<_i95.AuthenticateUseCase>(),
      await get.getAsync<_i93.GetProofsUseCase>(),
      get<_i56.Iden3MessageMapper>(),
      get<_i62.SchemaInfoMapper>()));
  return get;
}

class _$NetworkModule extends _i98.NetworkModule {}

class _$DatabaseModule extends _i98.DatabaseModule {}

class _$Sdk extends _i98.Sdk {}

class _$RepositoriesModule extends _i98.RepositoriesModule {}
