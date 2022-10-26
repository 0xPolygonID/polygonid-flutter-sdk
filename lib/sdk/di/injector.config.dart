// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i10;
import 'package:web3dart/web3dart.dart' as _i41;

import '../../credential/data/credential_repository_impl.dart' as _i59;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i35;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i49;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i48;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i11;
import '../../credential/data/mappers/filters_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i14;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i61;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i85;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i62;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i63;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i67;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i68;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i32;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i36;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i47;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i50;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i51;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i16;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i25;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i29;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i30;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i55;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i64;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i70;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i87;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i80;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i86;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i19;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i20;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i56;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i53;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i54;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i40;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i3;
import '../../identity/data/mappers/hex_mapper.dart' as _i13;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i18;
import '../../identity/data/mappers/private_key_mapper.dart' as _i26;
import '../../identity/data/mappers/rhs_node_mapper.dart' as _i57;
import '../../identity/data/mappers/rhs_node_type_mapper.dart' as _i37;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i65;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i38;
import '../../identity/domain/repositories/identity_repository.dart' as _i71;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i23;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i76;
import '../../identity/domain/use_cases/fetch_identity_state_use_case.dart'
    as _i77;
import '../../identity/domain/use_cases/fetch_state_roots_use_case.dart'
    as _i78;
import '../../identity/domain/use_cases/generate_non_rev_proof_use_case.dart'
    as _i79;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i81;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i82;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i83;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i74;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i75;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i15;
import '../../identity/libs/smt/hash.dart' as _i39;
import '../../identity/libs/smt/merkletree.dart' as _i22;
import '../../identity/libs/smt/node.dart' as _i24;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i46;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i21;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i34;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i43;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i28;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i60;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i66;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i69;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i72;
import '../../proof_generation/libs/prover/prover.dart' as _i33;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i42;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i44;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i45;
import '../credential_wallet.dart' as _i88;
import '../iden3comm.dart' as _i89;
import '../identity_wallet.dart' as _i84;
import '../mappers/iden3_message_mapper.dart' as _i52;
import '../mappers/iden3_message_type_mapper.dart' as _i17;
import '../mappers/schema_info_mapper.dart' as _i58;
import '../proof_generation.dart' as _i73;
import 'injector.dart' as _i90; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
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
  gh.factory<_i37.RhsNodeTypeMapper>(() => _i37.RhsNodeTypeMapper());
  gh.factory<_i38.SMTMemoryStorageRepositoryImpl>(() =>
      _i38.SMTMemoryStorageRepositoryImpl(
          get<_i39.Hash>(), get<Map<_i39.Hash, _i24.Node>>()));
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i10.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i40.WalletLibWrapper>(() => _i40.WalletLibWrapper());
  gh.factory<_i41.Web3Client>(() => networkModule.web3Client);
  gh.factory<_i42.WitnessAuthLib>(() => _i42.WitnessAuthLib());
  gh.factory<_i43.WitnessIsolatesWrapper>(() => _i43.WitnessIsolatesWrapper());
  gh.factory<_i44.WitnessMtpLib>(() => _i44.WitnessMtpLib());
  gh.factory<_i45.WitnessSigLib>(() => _i45.WitnessSigLib());
  gh.factory<_i46.AtomicQueryInputsWrapper>(
      () => _i46.AtomicQueryInputsWrapper(get<_i15.Iden3CoreLib>()));
  gh.factory<_i47.AuthRequestMapper>(
      () => _i47.AuthRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i48.ClaimMapper>(() => _i48.ClaimMapper(
      get<_i7.ClaimStateMapper>(), get<_i6.ClaimInfoMapper>()));
  gh.factory<_i49.ClaimStoreRefWrapper>(() => _i49.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i50.ContractRequestMapper>(
      () => _i50.ContractRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i51.FetchRequestMapper>(
      () => _i51.FetchRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i52.Iden3MessageMapper>(
      () => _i52.Iden3MessageMapper(get<_i17.Iden3MessageTypeMapper>()));
  gh.factory<_i53.IdentityStoreRefWrapper>(() => _i53.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i54.KeyValueStoreRefWrapper>(() => _i54.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i55.ProofRequestsMapper>(() => _i55.ProofRequestsMapper(
      get<_i47.AuthRequestMapper>(),
      get<_i51.FetchRequestMapper>(),
      get<_i25.OfferRequestMapper>(),
      get<_i50.ContractRequestMapper>(),
      get<_i30.ProofQueryParamMapper>()));
  gh.factory<_i34.ProverLibDataSource>(
      () => _i34.ProverLibDataSource(get<_i34.ProverLibWrapper>()));
  gh.factory<_i56.RemoteIdentityDataSource>(() => _i56.RemoteIdentityDataSource(
      get<_i8.Client>(), get<_i41.Web3Client>(), get<_i15.Iden3CoreLib>()));
  gh.factory<_i57.RhsNodeMapper>(
      () => _i57.RhsNodeMapper(get<_i37.RhsNodeTypeMapper>()));
  gh.factory<_i58.SchemaInfoMapper>(() => _i58.SchemaInfoMapper(
      get<_i47.AuthRequestMapper>(), get<_i50.ContractRequestMapper>()));
  gh.factoryAsync<_i49.StorageClaimDataSource>(() async =>
      _i49.StorageClaimDataSource(await get.getAsync<_i10.Database>(),
          get<_i49.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i54.StorageKeyValueDataSource>(() async =>
      _i54.StorageKeyValueDataSource(await get.getAsync<_i10.Database>(),
          get<_i54.KeyValueStoreRefWrapper>()));
  gh.factory<_i40.WalletDataSource>(
      () => _i40.WalletDataSource(get<_i40.WalletLibWrapper>()));
  gh.factory<_i43.WitnessDataSource>(
      () => _i43.WitnessDataSource(get<_i43.WitnessIsolatesWrapper>()));
  gh.factory<_i46.AtomicQueryInputsDataSource>(() =>
      _i46.AtomicQueryInputsDataSource(get<_i46.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i59.CredentialRepositoryImpl>(() async =>
      _i59.CredentialRepositoryImpl(
          get<_i35.RemoteClaimDataSource>(),
          await get.getAsync<_i49.StorageClaimDataSource>(),
          get<_i56.RemoteIdentityDataSource>(),
          get<_i9.CredentialRequestMapper>(),
          get<_i48.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i14.IdFilterMapper>()));
  gh.factory<_i19.JWZDataSource>(() => _i19.JWZDataSource(
      get<_i4.BabyjubjubLib>(),
      get<_i40.WalletDataSource>(),
      get<_i19.JWZIsolatesWrapper>()));
  gh.factory<_i60.ProofRepositoryImpl>(() => _i60.ProofRepositoryImpl(
      get<_i43.WitnessDataSource>(),
      get<_i34.ProverLibDataSource>(),
      get<_i46.AtomicQueryInputsDataSource>(),
      get<_i21.LocalFilesDataSource>(),
      get<_i27.ProofCircuitDataSource>(),
      get<_i56.RemoteIdentityDataSource>(),
      get<_i35.RemoteClaimDataSource>(),
      get<_i5.CircuitTypeMapper>(),
      get<_i55.ProofRequestsMapper>(),
      get<_i31.ProofRequestFiltersMapper>(),
      get<_i28.ProofMapper>(),
      get<_i48.ClaimMapper>()));
  gh.factoryAsync<_i53.StorageIdentityDataSource>(() async =>
      _i53.StorageIdentityDataSource(
          await get.getAsync<_i10.Database>(),
          get<_i53.IdentityStoreRefWrapper>(),
          await get.getAsync<_i54.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i61.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i59.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i62.GetClaimsUseCase>(() async =>
      _i62.GetClaimsUseCase(await get.getAsync<_i61.CredentialRepository>()));
  gh.factoryAsync<_i63.GetVocabsUseCase>(() async =>
      _i63.GetVocabsUseCase(await get.getAsync<_i61.CredentialRepository>()));
  gh.factoryAsync<_i64.Iden3commRepositoryImpl>(() async =>
      _i64.Iden3commRepositoryImpl(
          get<_i36.RemoteIden3commDataSource>(),
          get<_i19.JWZDataSource>(),
          get<_i13.HexMapper>(),
          get<_i32.ProofScopeDataSource>(),
          await get.getAsync<_i49.StorageClaimDataSource>(),
          get<_i48.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i3.AuthResponseMapper>(),
          get<_i47.AuthRequestMapper>()));
  gh.factoryAsync<_i65.IdentityRepositoryImpl>(() async =>
      _i65.IdentityRepositoryImpl(
          get<_i40.WalletDataSource>(),
          get<_i20.LibIdentityDataSource>(),
          get<_i56.RemoteIdentityDataSource>(),
          await get.getAsync<_i53.StorageIdentityDataSource>(),
          await get.getAsync<_i54.StorageKeyValueDataSource>(),
          get<_i13.HexMapper>(),
          get<_i26.PrivateKeyMapper>(),
          get<_i18.IdentityDTOMapper>(),
          get<_i57.RhsNodeMapper>()));
  gh.factory<_i66.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i60.ProofRepositoryImpl>()));
  gh.factoryAsync<_i67.RemoveClaimsUseCase>(() async =>
      _i67.RemoveClaimsUseCase(
          await get.getAsync<_i61.CredentialRepository>()));
  gh.factoryAsync<_i68.UpdateClaimUseCase>(() async =>
      _i68.UpdateClaimUseCase(await get.getAsync<_i61.CredentialRepository>()));
  gh.factory<_i69.GenerateProofUseCase>(
      () => _i69.GenerateProofUseCase(get<_i66.ProofRepository>()));
  gh.factoryAsync<_i70.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i64.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i71.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i65.IdentityRepositoryImpl>()));
  gh.factory<_i72.IsProofCircuitSupportedUseCase>(
      () => _i72.IsProofCircuitSupportedUseCase(get<_i66.ProofRepository>()));
  gh.factory<_i73.ProofGeneration>(
      () => _i73.ProofGeneration(get<_i69.GenerateProofUseCase>()));
  gh.factoryAsync<_i74.RemoveCurrentIdentityUseCase>(() async =>
      _i74.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i75.SignMessageUseCase>(() async =>
      _i75.SignMessageUseCase(await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i76.CreateIdentityUseCase>(() async =>
      _i76.CreateIdentityUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i77.FetchIdentityStateUseCase>(() async =>
      _i77.FetchIdentityStateUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i78.FetchStateRootsUseCase>(() async =>
      _i78.FetchStateRootsUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i79.GenerateNonRevProofUseCase>(() async =>
      _i79.GenerateNonRevProofUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i80.GetAuthTokenUseCase>(() async =>
      _i80.GetAuthTokenUseCase(
          await get.getAsync<_i70.Iden3commRepository>(),
          get<_i66.ProofRepository>(),
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i81.GetCurrentIdentifierUseCase>(() async =>
      _i81.GetCurrentIdentifierUseCase(
          await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i82.GetIdentityUseCase>(() async =>
      _i82.GetIdentityUseCase(await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i83.GetPublicKeysUseCase>(() async =>
      _i83.GetPublicKeysUseCase(await get.getAsync<_i71.IdentityRepository>()));
  gh.factoryAsync<_i84.IdentityWallet>(() async => _i84.IdentityWallet(
      await get.getAsync<_i76.CreateIdentityUseCase>(),
      await get.getAsync<_i82.GetIdentityUseCase>(),
      await get.getAsync<_i75.SignMessageUseCase>(),
      await get.getAsync<_i81.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i74.RemoveCurrentIdentityUseCase>(),
      await get.getAsync<_i77.FetchIdentityStateUseCase>()));
  gh.factoryAsync<_i85.FetchAndSaveClaimsUseCase>(() async =>
      _i85.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i80.GetAuthTokenUseCase>(),
          await get.getAsync<_i61.CredentialRepository>()));
  gh.factoryAsync<_i86.GetProofsUseCase>(() async => _i86.GetProofsUseCase(
      get<_i66.ProofRepository>(),
      await get.getAsync<_i71.IdentityRepository>(),
      await get.getAsync<_i62.GetClaimsUseCase>(),
      get<_i69.GenerateProofUseCase>(),
      await get.getAsync<_i83.GetPublicKeysUseCase>(),
      get<_i72.IsProofCircuitSupportedUseCase>()));
  gh.factoryAsync<_i87.AuthenticateUseCase>(() async =>
      _i87.AuthenticateUseCase(
          await get.getAsync<_i70.Iden3commRepository>(),
          await get.getAsync<_i86.GetProofsUseCase>(),
          await get.getAsync<_i80.GetAuthTokenUseCase>()));
  gh.factoryAsync<_i88.CredentialWallet>(() async => _i88.CredentialWallet(
      await get.getAsync<_i85.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i62.GetClaimsUseCase>(),
      await get.getAsync<_i67.RemoveClaimsUseCase>(),
      await get.getAsync<_i68.UpdateClaimUseCase>()));
  gh.factoryAsync<_i89.Iden3comm>(() async => _i89.Iden3comm(
      await get.getAsync<_i63.GetVocabsUseCase>(),
      await get.getAsync<_i87.AuthenticateUseCase>(),
      await get.getAsync<_i86.GetProofsUseCase>(),
      get<_i52.Iden3MessageMapper>(),
      get<_i58.SchemaInfoMapper>()));
  return get;
}

class _$NetworkModule extends _i90.NetworkModule {}

class _$DatabaseModule extends _i90.DatabaseModule {}

class _$RepositoriesModule extends _i90.RepositoriesModule {}
