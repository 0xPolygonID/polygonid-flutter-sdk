// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i10;
import 'package:web3dart/web3dart.dart' as _i46;

import '../../common/data/data_sources/env_datasource.dart' as _i56;
import '../../common/data/repositories/env_config_repository_impl.dart' as _i65;
import '../../common/domain/repositories/config_repository.dart' as _i14;
import '../../common/domain/use_cases/get_config_use_case.dart' as _i13;
import '../../credential/data/credential_repository_impl.dart' as _i66;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i37;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i54;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i53;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i11;
import '../../credential/data/mappers/filters_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i16;
import '../../credential/data/mappers/revocation_status_mapper.dart' as _i40;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i68;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i91;
import '../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart'
    as _i86;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i69;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i70;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i74;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i75;
import '../../env/sdk_env.dart' as _i44;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i34;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i38;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i52;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i55;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i57;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i18;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i27;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i32;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i33;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i61;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i71;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i76;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i95;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i85;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i93;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i21;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i22;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i39;
import '../../identity/data/data_sources/rpc_data_source.dart' as _i62;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i59;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i60;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i45;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i3;
import '../../identity/data/mappers/hex_mapper.dart' as _i15;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i20;
import '../../identity/data/mappers/private_key_mapper.dart' as _i28;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i63;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i41;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i72;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i42;
import '../../identity/domain/repositories/identity_repository.dart' as _i77;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i25;
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
import '../../identity/libs/iden3core/iden3core.dart' as _i17;
import '../../identity/libs/smt/hash.dart' as _i43;
import '../../identity/libs/smt/merkletree.dart' as _i24;
import '../../identity/libs/smt/node.dart' as _i26;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i51;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i23;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i29;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i36;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i48;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i30;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i67;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i73;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i92;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i78;
import '../../proof_generation/libs/prover/prover.dart' as _i35;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i47;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i49;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i50;
import '../credential_wallet.dart' as _i96;
import '../iden3comm.dart' as _i97;
import '../identity_wallet.dart' as _i90;
import '../mappers/iden3_message_mapper.dart' as _i58;
import '../mappers/iden3_message_type_mapper.dart' as _i19;
import '../mappers/schema_info_mapper.dart' as _i64;
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
  gh.factory<_i13.GetEnvConfigUseCase>(
      () => _i13.GetEnvConfigUseCase(get<_i14.ConfigRepository>()));
  gh.factory<_i15.HexMapper>(() => _i15.HexMapper());
  gh.factory<_i16.IdFilterMapper>(() => _i16.IdFilterMapper());
  gh.factory<_i17.Iden3CoreLib>(() => _i17.Iden3CoreLib());
  gh.factory<_i18.Iden3MessageTypeDataMapper>(
      () => _i18.Iden3MessageTypeDataMapper());
  gh.factory<_i19.Iden3MessageTypeMapper>(() => _i19.Iden3MessageTypeMapper());
  gh.factory<_i20.IdentityDTOMapper>(() => _i20.IdentityDTOMapper());
  gh.factory<_i21.JWZIsolatesWrapper>(() => _i21.JWZIsolatesWrapper());
  gh.factory<_i22.LibIdentityDataSource>(
      () => _i22.LibIdentityDataSource(get<_i17.Iden3CoreLib>()));
  gh.factory<_i23.LocalFilesDataSource>(() => _i23.LocalFilesDataSource());
  gh.factory<_i24.MerkleTree>(() => _i24.MerkleTree(
      get<_i17.Iden3CoreLib>(), get<_i25.SMTStorageRepository>(), get<int>()));
  gh.factory<_i26.Node>(
      () => _i26.Node(get<_i26.NodeType>(), get<_i17.Iden3CoreLib>()));
  gh.factory<_i27.OfferRequestMapper>(
      () => _i27.OfferRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i28.PrivateKeyMapper>(() => _i28.PrivateKeyMapper());
  gh.factory<_i29.ProofCircuitDataSource>(() => _i29.ProofCircuitDataSource());
  gh.factory<_i30.ProofMapper>(() => _i30.ProofMapper());
  gh.factory<_i31.ProofQueryMapper>(() => _i31.ProofQueryMapper());
  gh.factory<_i32.ProofQueryParamMapper>(() => _i32.ProofQueryParamMapper());
  gh.factory<_i33.ProofRequestFiltersMapper>(
      () => _i33.ProofRequestFiltersMapper(get<_i31.ProofQueryMapper>()));
  gh.factory<_i34.ProofScopeDataSource>(() => _i34.ProofScopeDataSource());
  gh.factory<_i35.ProverLib>(() => _i35.ProverLib());
  gh.factory<_i36.ProverLibWrapper>(() => _i36.ProverLibWrapper());
  gh.factory<_i37.RemoteClaimDataSource>(
      () => _i37.RemoteClaimDataSource(get<_i8.Client>()));
  gh.factory<_i38.RemoteIden3commDataSource>(
      () => _i38.RemoteIden3commDataSource(get<_i8.Client>()));
  gh.factory<_i39.RemoteIdentityDataSource>(
      () => _i39.RemoteIdentityDataSource());
  gh.factory<_i40.RevocationStatusMapper>(() => _i40.RevocationStatusMapper());
  gh.factory<_i41.RhsNodeTypeMapper>(() => _i41.RhsNodeTypeMapper());
  gh.factory<_i42.SMTMemoryStorageRepositoryImpl>(() =>
      _i42.SMTMemoryStorageRepositoryImpl(
          get<_i43.Hash>(), get<Map<_i43.Hash, _i26.Node>>()));
  gh.lazySingleton<_i44.SdkEnv>(() => sdk.sdkEnv);
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i10.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i45.WalletLibWrapper>(() => _i45.WalletLibWrapper());
  gh.factory<_i46.Web3Client>(
      () => networkModule.web3Client(get<_i44.SdkEnv>()));
  gh.factory<_i47.WitnessAuthLib>(() => _i47.WitnessAuthLib());
  gh.factory<_i48.WitnessIsolatesWrapper>(() => _i48.WitnessIsolatesWrapper());
  gh.factory<_i49.WitnessMtpLib>(() => _i49.WitnessMtpLib());
  gh.factory<_i50.WitnessSigLib>(() => _i50.WitnessSigLib());
  gh.factory<_i51.AtomicQueryInputsWrapper>(
      () => _i51.AtomicQueryInputsWrapper(get<_i17.Iden3CoreLib>()));
  gh.factory<_i52.AuthRequestMapper>(
      () => _i52.AuthRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i53.ClaimMapper>(() => _i53.ClaimMapper(
      get<_i7.ClaimStateMapper>(), get<_i6.ClaimInfoMapper>()));
  gh.factory<_i54.ClaimStoreRefWrapper>(() => _i54.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i55.ContractRequestMapper>(
      () => _i55.ContractRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i56.EnvDataSource>(() => _i56.EnvDataSource(get<_i44.SdkEnv>()));
  gh.factory<_i57.FetchRequestMapper>(
      () => _i57.FetchRequestMapper(get<_i18.Iden3MessageTypeDataMapper>()));
  gh.factory<_i58.Iden3MessageMapper>(
      () => _i58.Iden3MessageMapper(get<_i19.Iden3MessageTypeMapper>()));
  gh.factory<_i59.IdentityStoreRefWrapper>(() => _i59.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i60.KeyValueStoreRefWrapper>(() => _i60.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i61.ProofRequestsMapper>(() => _i61.ProofRequestsMapper(
      get<_i52.AuthRequestMapper>(),
      get<_i57.FetchRequestMapper>(),
      get<_i27.OfferRequestMapper>(),
      get<_i55.ContractRequestMapper>(),
      get<_i32.ProofQueryParamMapper>()));
  gh.factory<_i36.ProverLibDataSource>(
      () => _i36.ProverLibDataSource(get<_i36.ProverLibWrapper>()));
  gh.factory<_i62.RPCDataSource>(
      () => _i62.RPCDataSource(get<_i46.Web3Client>()));
  gh.factory<_i63.RhsNodeMapper>(
      () => _i63.RhsNodeMapper(get<_i41.RhsNodeTypeMapper>()));
  gh.factory<_i64.SchemaInfoMapper>(() => _i64.SchemaInfoMapper(
      get<_i52.AuthRequestMapper>(), get<_i55.ContractRequestMapper>()));
  gh.factoryAsync<_i54.StorageClaimDataSource>(() async =>
      _i54.StorageClaimDataSource(await get.getAsync<_i10.Database>(),
          get<_i54.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i60.StorageKeyValueDataSource>(() async =>
      _i60.StorageKeyValueDataSource(await get.getAsync<_i10.Database>(),
          get<_i60.KeyValueStoreRefWrapper>()));
  gh.factory<_i45.WalletDataSource>(
      () => _i45.WalletDataSource(get<_i45.WalletLibWrapper>()));
  gh.factory<_i48.WitnessDataSource>(
      () => _i48.WitnessDataSource(get<_i48.WitnessIsolatesWrapper>()));
  gh.factory<_i51.AtomicQueryInputsDataSource>(() =>
      _i51.AtomicQueryInputsDataSource(get<_i51.AtomicQueryInputsWrapper>()));
  gh.factory<_i65.ConfigRepositoryImpl>(
      () => _i65.ConfigRepositoryImpl(get<_i56.EnvDataSource>()));
  gh.factoryAsync<_i66.CredentialRepositoryImpl>(() async =>
      _i66.CredentialRepositoryImpl(
          get<_i37.RemoteClaimDataSource>(),
          await get.getAsync<_i54.StorageClaimDataSource>(),
          get<_i39.RemoteIdentityDataSource>(),
          get<_i9.CredentialRequestMapper>(),
          get<_i53.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i16.IdFilterMapper>(),
          get<_i40.RevocationStatusMapper>()));
  gh.factory<_i21.JWZDataSource>(() => _i21.JWZDataSource(
      get<_i4.BabyjubjubLib>(),
      get<_i45.WalletDataSource>(),
      get<_i21.JWZIsolatesWrapper>()));
  gh.factory<_i67.ProofRepositoryImpl>(() => _i67.ProofRepositoryImpl(
      get<_i48.WitnessDataSource>(),
      get<_i36.ProverLibDataSource>(),
      get<_i51.AtomicQueryInputsDataSource>(),
      get<_i23.LocalFilesDataSource>(),
      get<_i29.ProofCircuitDataSource>(),
      get<_i39.RemoteIdentityDataSource>(),
      get<_i5.CircuitTypeMapper>(),
      get<_i61.ProofRequestsMapper>(),
      get<_i33.ProofRequestFiltersMapper>(),
      get<_i30.ProofMapper>(),
      get<_i53.ClaimMapper>(),
      get<_i40.RevocationStatusMapper>()));
  gh.factoryAsync<_i59.StorageIdentityDataSource>(() async =>
      _i59.StorageIdentityDataSource(
          await get.getAsync<_i10.Database>(),
          get<_i59.IdentityStoreRefWrapper>(),
          await get.getAsync<_i60.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i68.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i66.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i69.GetClaimsUseCase>(() async =>
      _i69.GetClaimsUseCase(await get.getAsync<_i68.CredentialRepository>()));
  gh.factoryAsync<_i70.GetVocabsUseCase>(() async =>
      _i70.GetVocabsUseCase(await get.getAsync<_i68.CredentialRepository>()));
  gh.factoryAsync<_i71.Iden3commRepositoryImpl>(() async =>
      _i71.Iden3commRepositoryImpl(
          get<_i38.RemoteIden3commDataSource>(),
          get<_i21.JWZDataSource>(),
          get<_i15.HexMapper>(),
          get<_i34.ProofScopeDataSource>(),
          await get.getAsync<_i54.StorageClaimDataSource>(),
          get<_i53.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i3.AuthResponseMapper>(),
          get<_i52.AuthRequestMapper>()));
  gh.factoryAsync<_i72.IdentityRepositoryImpl>(() async =>
      _i72.IdentityRepositoryImpl(
          get<_i45.WalletDataSource>(),
          get<_i22.LibIdentityDataSource>(),
          get<_i39.RemoteIdentityDataSource>(),
          await get.getAsync<_i59.StorageIdentityDataSource>(),
          await get.getAsync<_i60.StorageKeyValueDataSource>(),
          get<_i62.RPCDataSource>(),
          get<_i15.HexMapper>(),
          get<_i28.PrivateKeyMapper>(),
          get<_i20.IdentityDTOMapper>(),
          get<_i63.RhsNodeMapper>()));
  gh.factory<_i73.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i67.ProofRepositoryImpl>()));
  gh.factoryAsync<_i74.RemoveClaimsUseCase>(() async =>
      _i74.RemoveClaimsUseCase(
          await get.getAsync<_i68.CredentialRepository>()));
  gh.factoryAsync<_i75.UpdateClaimUseCase>(() async =>
      _i75.UpdateClaimUseCase(await get.getAsync<_i68.CredentialRepository>()));
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
          await get.getAsync<_i68.CredentialRepository>(),
          get<_i13.GetEnvConfigUseCase>()));
  gh.factoryAsync<_i85.GetAuthTokenUseCase>(() async =>
      _i85.GetAuthTokenUseCase(
          await get.getAsync<_i76.Iden3commRepository>(),
          get<_i73.ProofRepository>(),
          await get.getAsync<_i77.IdentityRepository>()));
  gh.factoryAsync<_i86.GetClaimRevocationStatusUseCase>(() async =>
      _i86.GetClaimRevocationStatusUseCase(
          await get.getAsync<_i68.CredentialRepository>(),
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
          await get.getAsync<_i68.CredentialRepository>()));
  gh.factoryAsync<_i92.GenerateProofUseCase>(() async =>
      _i92.GenerateProofUseCase(
          get<_i73.ProofRepository>(),
          await get.getAsync<_i68.CredentialRepository>(),
          await get.getAsync<_i86.GetClaimRevocationStatusUseCase>()));
  gh.factoryAsync<_i93.GetProofsUseCase>(() async => _i93.GetProofsUseCase(
      get<_i73.ProofRepository>(),
      await get.getAsync<_i77.IdentityRepository>(),
      await get.getAsync<_i69.GetClaimsUseCase>(),
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
      await get.getAsync<_i69.GetClaimsUseCase>(),
      await get.getAsync<_i74.RemoveClaimsUseCase>(),
      await get.getAsync<_i75.UpdateClaimUseCase>()));
  gh.factoryAsync<_i97.Iden3comm>(() async => _i97.Iden3comm(
      await get.getAsync<_i70.GetVocabsUseCase>(),
      await get.getAsync<_i95.AuthenticateUseCase>(),
      await get.getAsync<_i93.GetProofsUseCase>(),
      get<_i58.Iden3MessageMapper>(),
      get<_i64.SchemaInfoMapper>()));
  return get;
}

class _$NetworkModule extends _i98.NetworkModule {}

class _$DatabaseModule extends _i98.DatabaseModule {}

class _$Sdk extends _i98.Sdk {}

class _$RepositoriesModule extends _i98.RepositoriesModule {}
