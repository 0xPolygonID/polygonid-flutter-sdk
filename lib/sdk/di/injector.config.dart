// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i10;

import '../../credential/data/credential_repository_impl.dart' as _i55;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i35;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i47;
import '../../credential/data/mappers/claim_info_mapper.dart' as _i6;
import '../../credential/data/mappers/claim_mapper.dart' as _i46;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i7;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i9;
import '../../credential/data/mappers/filter_mapper.dart' as _i11;
import '../../credential/data/mappers/filters_mapper.dart' as _i12;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i14;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i57;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i78;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i58;
import '../../credential/domain/use_cases/get_vocabs_use_case.dart' as _i59;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i63;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i64;
import '../../iden3comm/data/data_sources/proof_scope_data_source.dart' as _i32;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i36;
import '../../iden3comm/data/mappers/auth_request_mapper.dart' as _i45;
import '../../iden3comm/data/mappers/contract_request_mapper.dart' as _i48;
import '../../iden3comm/data/mappers/fetch_request_mapper.dart' as _i49;
import '../../iden3comm/data/mappers/iden3_message_type_data_mapper.dart'
    as _i16;
import '../../iden3comm/data/mappers/offer_request_mapper.dart' as _i25;
import '../../iden3comm/data/mappers/proof_query_mapper.dart' as _i29;
import '../../iden3comm/data/mappers/proof_query_param_mapper.dart' as _i30;
import '../../iden3comm/data/mappers/proof_request_filters_mapper.dart' as _i31;
import '../../iden3comm/data/mappers/proof_requests_mapper.dart' as _i53;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i60;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i66;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i80;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i73;
import '../../iden3comm/domain/use_cases/get_proofs_use_case.dart' as _i79;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i19;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i20;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i51;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i52;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i39;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i3;
import '../../identity/data/mappers/hex_mapper.dart' as _i13;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i18;
import '../../identity/data/mappers/private_key_mapper.dart' as _i26;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i61;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i37;
import '../../identity/domain/repositories/identity_repository.dart' as _i67;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i23;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i72;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i74;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i75;
import '../../identity/domain/use_cases/get_public_key_use_case.dart' as _i76;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i70;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i71;
import '../../identity/libs/bjj/bjj.dart' as _i4;
import '../../identity/libs/iden3core/iden3core.dart' as _i15;
import '../../identity/libs/smt/hash.dart' as _i38;
import '../../identity/libs/smt/merkletree.dart' as _i22;
import '../../identity/libs/smt/node.dart' as _i24;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i44;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i21;
import '../../proof_generation/data/data_sources/proof_circuit_data_source.dart'
    as _i27;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i34;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i41;
import '../../proof_generation/data/mappers/circuit_type_mapper.dart' as _i5;
import '../../proof_generation/data/mappers/proof_mapper.dart' as _i28;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i56;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i62;
import '../../proof_generation/domain/use_cases/generate_proof_use_case.dart'
    as _i65;
import '../../proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart'
    as _i68;
import '../../proof_generation/libs/prover/prover.dart' as _i33;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i40;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i42;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i43;
import '../credential_wallet.dart' as _i81;
import '../iden3comm.dart' as _i82;
import '../identity_wallet.dart' as _i77;
import '../mappers/iden3_message_mapper.dart' as _i50;
import '../mappers/iden3_message_type_mapper.dart' as _i17;
import '../mappers/schema_info_mapper.dart' as _i54;
import '../proof_generation.dart' as _i69;
import 'injector.dart' as _i83; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i37.SMTMemoryStorageRepositoryImpl>(() =>
      _i37.SMTMemoryStorageRepositoryImpl(
          get<_i38.Hash>(), get<Map<_i38.Hash, _i24.Node>>()));
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i10.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i10.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i39.WalletLibWrapper>(() => _i39.WalletLibWrapper());
  gh.factory<_i40.WitnessAuthLib>(() => _i40.WitnessAuthLib());
  gh.factory<_i41.WitnessIsolatesWrapper>(() => _i41.WitnessIsolatesWrapper());
  gh.factory<_i42.WitnessMtpLib>(() => _i42.WitnessMtpLib());
  gh.factory<_i43.WitnessSigLib>(() => _i43.WitnessSigLib());
  gh.factory<_i44.AtomicQueryInputsWrapper>(
      () => _i44.AtomicQueryInputsWrapper(get<_i15.Iden3CoreLib>()));
  gh.factory<_i45.AuthRequestMapper>(
      () => _i45.AuthRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i46.ClaimMapper>(() => _i46.ClaimMapper(
      get<_i7.ClaimStateMapper>(), get<_i6.ClaimInfoMapper>()));
  gh.factory<_i47.ClaimStoreRefWrapper>(() => _i47.ClaimStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i48.ContractRequestMapper>(
      () => _i48.ContractRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i49.FetchRequestMapper>(
      () => _i49.FetchRequestMapper(get<_i16.Iden3MessageTypeDataMapper>()));
  gh.factory<_i50.Iden3MessageMapper>(
      () => _i50.Iden3MessageMapper(get<_i17.Iden3MessageTypeMapper>()));
  gh.factory<_i51.IdentityStoreRefWrapper>(() => _i51.IdentityStoreRefWrapper(
      get<_i10.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i52.KeyValueStoreRefWrapper>(() => _i52.KeyValueStoreRefWrapper(
      get<_i10.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i53.ProofRequestsMapper>(() => _i53.ProofRequestsMapper(
      get<_i45.AuthRequestMapper>(),
      get<_i49.FetchRequestMapper>(),
      get<_i25.OfferRequestMapper>(),
      get<_i48.ContractRequestMapper>(),
      get<_i30.ProofQueryParamMapper>()));
  gh.factory<_i34.ProverLibDataSource>(
      () => _i34.ProverLibDataSource(get<_i34.ProverLibWrapper>()));
  gh.factory<_i54.SchemaInfoMapper>(() => _i54.SchemaInfoMapper(
      get<_i45.AuthRequestMapper>(), get<_i48.ContractRequestMapper>()));
  gh.factoryAsync<_i47.StorageClaimDataSource>(() async =>
      _i47.StorageClaimDataSource(await get.getAsync<_i10.Database>(),
          get<_i47.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i52.StorageKeyValueDataSource>(() async =>
      _i52.StorageKeyValueDataSource(await get.getAsync<_i10.Database>(),
          get<_i52.KeyValueStoreRefWrapper>()));
  gh.factory<_i39.WalletDataSource>(
      () => _i39.WalletDataSource(get<_i39.WalletLibWrapper>()));
  gh.factory<_i41.WitnessDataSource>(
      () => _i41.WitnessDataSource(get<_i41.WitnessIsolatesWrapper>()));
  gh.factory<_i44.AtomicQueryInputsDataSource>(() =>
      _i44.AtomicQueryInputsDataSource(get<_i44.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i55.CredentialRepositoryImpl>(() async =>
      _i55.CredentialRepositoryImpl(
          get<_i35.RemoteClaimDataSource>(),
          await get.getAsync<_i47.StorageClaimDataSource>(),
          get<_i9.CredentialRequestMapper>(),
          get<_i46.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i14.IdFilterMapper>()));
  gh.factory<_i19.JWZDataSource>(() => _i19.JWZDataSource(
      get<_i4.BabyjubjubLib>(),
      get<_i39.WalletDataSource>(),
      get<_i19.JWZIsolatesWrapper>()));
  gh.factory<_i56.ProofRepositoryImpl>(() => _i56.ProofRepositoryImpl(
      get<_i41.WitnessDataSource>(),
      get<_i34.ProverLibDataSource>(),
      get<_i44.AtomicQueryInputsDataSource>(),
      get<_i21.LocalFilesDataSource>(),
      get<_i27.ProofCircuitDataSource>(),
      get<_i5.CircuitTypeMapper>(),
      get<_i53.ProofRequestsMapper>(),
      get<_i31.ProofRequestFiltersMapper>(),
      get<_i28.ProofMapper>(),
      get<_i46.ClaimMapper>()));
  gh.factoryAsync<_i51.StorageIdentityDataSource>(() async =>
      _i51.StorageIdentityDataSource(
          await get.getAsync<_i10.Database>(),
          get<_i51.IdentityStoreRefWrapper>(),
          await get.getAsync<_i52.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i57.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i55.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i58.GetClaimsUseCase>(() async =>
      _i58.GetClaimsUseCase(await get.getAsync<_i57.CredentialRepository>()));
  gh.factoryAsync<_i59.GetVocabsUseCase>(() async =>
      _i59.GetVocabsUseCase(await get.getAsync<_i57.CredentialRepository>()));
  gh.factoryAsync<_i60.Iden3commRepositoryImpl>(() async =>
      _i60.Iden3commRepositoryImpl(
          get<_i36.RemoteIden3commDataSource>(),
          get<_i19.JWZDataSource>(),
          get<_i13.HexMapper>(),
          get<_i32.ProofScopeDataSource>(),
          await get.getAsync<_i47.StorageClaimDataSource>(),
          get<_i46.ClaimMapper>(),
          get<_i12.FiltersMapper>(),
          get<_i3.AuthResponseMapper>(),
          get<_i45.AuthRequestMapper>()));
  gh.factoryAsync<_i61.IdentityRepositoryImpl>(() async =>
      _i61.IdentityRepositoryImpl(
          get<_i39.WalletDataSource>(),
          get<_i20.LibIdentityDataSource>(),
          await get.getAsync<_i51.StorageIdentityDataSource>(),
          await get.getAsync<_i52.StorageKeyValueDataSource>(),
          get<_i13.HexMapper>(),
          get<_i26.PrivateKeyMapper>(),
          get<_i18.IdentityDTOMapper>()));
  gh.factory<_i62.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i56.ProofRepositoryImpl>()));
  gh.factoryAsync<_i63.RemoveClaimsUseCase>(() async =>
      _i63.RemoveClaimsUseCase(
          await get.getAsync<_i57.CredentialRepository>()));
  gh.factoryAsync<_i64.UpdateClaimUseCase>(() async =>
      _i64.UpdateClaimUseCase(await get.getAsync<_i57.CredentialRepository>()));
  gh.factory<_i65.GenerateProofUseCase>(
      () => _i65.GenerateProofUseCase(get<_i62.ProofRepository>()));
  gh.factoryAsync<_i66.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i60.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i67.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i61.IdentityRepositoryImpl>()));
  gh.factory<_i68.IsProofCircuitSupportedUseCase>(
      () => _i68.IsProofCircuitSupportedUseCase(get<_i62.ProofRepository>()));
  gh.factory<_i69.ProofGeneration>(
      () => _i69.ProofGeneration(get<_i65.GenerateProofUseCase>()));
  gh.factoryAsync<_i70.RemoveCurrentIdentityUseCase>(() async =>
      _i70.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i71.SignMessageUseCase>(() async =>
      _i71.SignMessageUseCase(await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i72.CreateIdentityUseCase>(() async =>
      _i72.CreateIdentityUseCase(
          await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i73.GetAuthTokenUseCase>(() async =>
      _i73.GetAuthTokenUseCase(
          await get.getAsync<_i66.Iden3commRepository>(),
          get<_i62.ProofRepository>(),
          await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i74.GetCurrentIdentifierUseCase>(() async =>
      _i74.GetCurrentIdentifierUseCase(
          await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i75.GetIdentityUseCase>(() async =>
      _i75.GetIdentityUseCase(await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i76.GetPublicKeysUseCase>(() async =>
      _i76.GetPublicKeysUseCase(await get.getAsync<_i67.IdentityRepository>()));
  gh.factoryAsync<_i77.IdentityWallet>(() async => _i77.IdentityWallet(
      await get.getAsync<_i72.CreateIdentityUseCase>(),
      await get.getAsync<_i75.GetIdentityUseCase>(),
      await get.getAsync<_i71.SignMessageUseCase>(),
      await get.getAsync<_i74.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i70.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i78.FetchAndSaveClaimsUseCase>(() async =>
      _i78.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i73.GetAuthTokenUseCase>(),
          await get.getAsync<_i57.CredentialRepository>()));
  gh.factoryAsync<_i79.GetProofsUseCase>(() async => _i79.GetProofsUseCase(
      get<_i62.ProofRepository>(),
      await get.getAsync<_i67.IdentityRepository>(),
      await get.getAsync<_i58.GetClaimsUseCase>(),
      get<_i65.GenerateProofUseCase>(),
      await get.getAsync<_i76.GetPublicKeysUseCase>(),
      get<_i68.IsProofCircuitSupportedUseCase>()));
  gh.factoryAsync<_i80.AuthenticateUseCase>(() async =>
      _i80.AuthenticateUseCase(
          await get.getAsync<_i66.Iden3commRepository>(),
          await get.getAsync<_i79.GetProofsUseCase>(),
          await get.getAsync<_i73.GetAuthTokenUseCase>()));
  gh.factoryAsync<_i81.CredentialWallet>(() async => _i81.CredentialWallet(
      await get.getAsync<_i78.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i58.GetClaimsUseCase>(),
      await get.getAsync<_i63.RemoveClaimsUseCase>(),
      await get.getAsync<_i64.UpdateClaimUseCase>()));
  gh.factoryAsync<_i82.Iden3comm>(() async => _i82.Iden3comm(
      await get.getAsync<_i59.GetVocabsUseCase>(),
      await get.getAsync<_i80.AuthenticateUseCase>(),
      await get.getAsync<_i79.GetProofsUseCase>(),
      get<_i50.Iden3MessageMapper>(),
      get<_i54.SchemaInfoMapper>()));
  return get;
}

class _$NetworkModule extends _i83.NetworkModule {}

class _$DatabaseModule extends _i83.DatabaseModule {}

class _$RepositoriesModule extends _i83.RepositoriesModule {}
