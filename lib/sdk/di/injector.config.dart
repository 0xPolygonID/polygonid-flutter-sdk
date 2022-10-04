// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i9;

import '../../credential/data/credential_repository_impl.dart' as _i40;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i26;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i37;
import '../../credential/data/mappers/claim_mapper.dart' as _i36;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i6;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i10;
import '../../credential/data/mappers/filters_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i13;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i42;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i64;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i43;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i47;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i48;
import '../../iden3comm/data/data_sources/remote_iden3comm_data_source.dart'
    as _i27;
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart'
    as _i58;
import '../../iden3comm/domain/repositories/iden3comm_repository.dart' as _i60;
import '../../iden3comm/domain/use_cases/authenticate_use_case.dart' as _i61;
import '../../iden3comm/domain/use_cases/get_auth_token_use_case.dart' as _i62;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i16;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i17;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i38;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i39;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i30;
import '../../identity/data/mappers/auth_request_mapper.dart' as _i3;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i4;
import '../../identity/data/mappers/hex_mapper.dart' as _i12;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i15;
import '../../identity/data/mappers/private_key_mapper.dart' as _i22;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i44;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i28;
import '../../identity/domain/repositories/identity_repository.dart' as _i51;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i20;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i55;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i56;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i57;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i53;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i54;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i14;
import '../../identity/libs/smt/hash.dart' as _i29;
import '../../identity/libs/smt/merkletree.dart' as _i19;
import '../../identity/libs/smt/node.dart' as _i21;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i35;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i18;
import '../../proof_generation/data/data_sources/proof_scope_data_source.dart'
    as _i23;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i25;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i32;
import '../../proof_generation/data/repositories/proof_repository_impl.dart'
    as _i41;
import '../../proof_generation/domain/repositories/proof_repository.dart'
    as _i45;
import '../../proof_generation/domain/use_cases/get_atomic_query_inputs_use_case.dart'
    as _i49;
import '../../proof_generation/domain/use_cases/get_witness_use_case.dart'
    as _i50;
import '../../proof_generation/domain/use_cases/prove_use_case.dart' as _i46;
import '../../proof_generation/libs/prover/prover.dart' as _i24;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i31;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i33;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i34;
import '../credential_wallet.dart' as _i65;
import '../iden3comm.dart' as _i63;
import '../identity_wallet.dart' as _i59;
import '../proof_generation.dart' as _i52;
import 'injector.dart' as _i66; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.AuthRequestMapper>(() => _i3.AuthRequestMapper());
  gh.factory<_i4.AuthResponseMapper>(() => _i4.AuthResponseMapper());
  gh.factory<_i5.BabyjubjubLib>(() => _i5.BabyjubjubLib());
  gh.factory<_i6.ClaimStateMapper>(() => _i6.ClaimStateMapper());
  gh.factory<_i7.Client>(() => networkModule.client);
  gh.factory<_i8.CredentialRequestMapper>(() => _i8.CredentialRequestMapper());
  gh.lazySingletonAsync<_i9.Database>(() => databaseModule.database());
  gh.factory<_i10.FilterMapper>(() => _i10.FilterMapper());
  gh.factory<_i11.FiltersMapper>(
      () => _i11.FiltersMapper(get<_i10.FilterMapper>()));
  gh.factory<_i12.HexMapper>(() => _i12.HexMapper());
  gh.factory<_i13.IdFilterMapper>(() => _i13.IdFilterMapper());
  gh.factory<_i14.Iden3CoreLib>(() => _i14.Iden3CoreLib());
  gh.factory<_i15.IdentityDTOMapper>(() => _i15.IdentityDTOMapper());
  gh.factory<_i16.JWZIsolatesWrapper>(() => _i16.JWZIsolatesWrapper());
  gh.factory<_i17.LibIdentityDataSource>(
      () => _i17.LibIdentityDataSource(get<_i14.Iden3CoreLib>()));
  gh.factory<_i18.LocalFilesDataSource>(() => _i18.LocalFilesDataSource());
  gh.factory<_i19.MerkleTree>(() => _i19.MerkleTree(
      get<_i14.Iden3CoreLib>(), get<_i20.SMTStorageRepository>(), get<int>()));
  gh.factory<_i21.Node>(
      () => _i21.Node(get<_i21.NodeType>(), get<_i14.Iden3CoreLib>()));
  gh.factory<_i22.PrivateKeyMapper>(() => _i22.PrivateKeyMapper());
  gh.factory<_i23.ProofScopeDataSource>(() => _i23.ProofScopeDataSource());
  gh.factory<_i24.ProverLib>(() => _i24.ProverLib());
  gh.factory<_i25.ProverLibWrapper>(() => _i25.ProverLibWrapper());
  gh.factory<_i26.RemoteClaimDataSource>(
      () => _i26.RemoteClaimDataSource(get<_i7.Client>()));
  gh.factory<_i27.RemoteIden3commDataSource>(
      () => _i27.RemoteIden3commDataSource(get<_i7.Client>()));
  gh.factory<_i28.SMTMemoryStorageRepositoryImpl>(() =>
      _i28.SMTMemoryStorageRepositoryImpl(
          get<_i29.Hash>(), get<Map<_i29.Hash, _i21.Node>>()));
  gh.factory<_i9.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i30.WalletLibWrapper>(() => _i30.WalletLibWrapper());
  gh.factory<_i31.WitnessAuthLib>(() => _i31.WitnessAuthLib());
  gh.factory<_i32.WitnessIsolatesWrapper>(() => _i32.WitnessIsolatesWrapper());
  gh.factory<_i33.WitnessMtpLib>(() => _i33.WitnessMtpLib());
  gh.factory<_i34.WitnessSigLib>(() => _i34.WitnessSigLib());
  gh.factory<_i35.AtomicQueryInputsWrapper>(
      () => _i35.AtomicQueryInputsWrapper(get<_i14.Iden3CoreLib>()));
  gh.factory<_i36.ClaimMapper>(
      () => _i36.ClaimMapper(get<_i6.ClaimStateMapper>()));
  gh.factory<_i37.ClaimStoreRefWrapper>(() => _i37.ClaimStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i38.IdentityStoreRefWrapper>(() => _i38.IdentityStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i39.KeyValueStoreRefWrapper>(() => _i39.KeyValueStoreRefWrapper(
      get<_i9.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i25.ProverLibDataSource>(
      () => _i25.ProverLibDataSource(get<_i25.ProverLibWrapper>()));
  gh.factoryAsync<_i37.StorageClaimDataSource>(() async =>
      _i37.StorageClaimDataSource(await get.getAsync<_i9.Database>(),
          get<_i37.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i39.StorageKeyValueDataSource>(() async =>
      _i39.StorageKeyValueDataSource(await get.getAsync<_i9.Database>(),
          get<_i39.KeyValueStoreRefWrapper>()));
  gh.factory<_i30.WalletDataSource>(
      () => _i30.WalletDataSource(get<_i30.WalletLibWrapper>()));
  gh.factory<_i32.WitnessDataSource>(
      () => _i32.WitnessDataSource(get<_i32.WitnessIsolatesWrapper>()));
  gh.factory<_i35.AtomicQueryInputsDataSource>(() =>
      _i35.AtomicQueryInputsDataSource(get<_i35.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i40.CredentialRepositoryImpl>(() async =>
      _i40.CredentialRepositoryImpl(
          get<_i26.RemoteClaimDataSource>(),
          await get.getAsync<_i37.StorageClaimDataSource>(),
          get<_i8.CredentialRequestMapper>(),
          get<_i36.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i13.IdFilterMapper>()));
  gh.factory<_i16.JWZDataSource>(() => _i16.JWZDataSource(
      get<_i5.BabyjubjubLib>(),
      get<_i30.WalletDataSource>(),
      get<_i16.JWZIsolatesWrapper>()));
  gh.factory<_i41.ProofRepositoryImpl>(() => _i41.ProofRepositoryImpl(
      get<_i32.WitnessDataSource>(),
      get<_i25.ProverLibDataSource>(),
      get<_i35.AtomicQueryInputsDataSource>(),
      get<_i18.LocalFilesDataSource>()));
  gh.factoryAsync<_i38.StorageIdentityDataSource>(() async =>
      _i38.StorageIdentityDataSource(
          await get.getAsync<_i9.Database>(),
          get<_i38.IdentityStoreRefWrapper>(),
          await get.getAsync<_i39.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i42.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i40.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i43.GetClaimsUseCase>(() async =>
      _i43.GetClaimsUseCase(await get.getAsync<_i42.CredentialRepository>()));
  gh.factoryAsync<_i44.IdentityRepositoryImpl>(() async =>
      _i44.IdentityRepositoryImpl(
          get<_i30.WalletDataSource>(),
          get<_i17.LibIdentityDataSource>(),
          await get.getAsync<_i38.StorageIdentityDataSource>(),
          await get.getAsync<_i39.StorageKeyValueDataSource>(),
          get<_i12.HexMapper>(),
          get<_i22.PrivateKeyMapper>(),
          get<_i15.IdentityDTOMapper>()));
  gh.factory<_i45.ProofRepository>(() =>
      repositoriesModule.proofRepository(get<_i41.ProofRepositoryImpl>()));
  gh.factory<_i46.ProveUseCase>(
      () => _i46.ProveUseCase(get<_i45.ProofRepository>()));
  gh.factoryAsync<_i47.RemoveClaimsUseCase>(() async =>
      _i47.RemoveClaimsUseCase(
          await get.getAsync<_i42.CredentialRepository>()));
  gh.factoryAsync<_i48.UpdateClaimUseCase>(() async =>
      _i48.UpdateClaimUseCase(await get.getAsync<_i42.CredentialRepository>()));
  gh.factory<_i49.GetAtomicQueryInputsUseCase>(
      () => _i49.GetAtomicQueryInputsUseCase(get<_i45.ProofRepository>()));
  gh.factory<_i50.GetWitnessUseCase>(
      () => _i50.GetWitnessUseCase(get<_i45.ProofRepository>()));
  gh.factoryAsync<_i51.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i44.IdentityRepositoryImpl>()));
  gh.factory<_i52.ProofGeneration>(() => _i52.ProofGeneration(
      get<_i49.GetAtomicQueryInputsUseCase>(),
      get<_i50.GetWitnessUseCase>(),
      get<_i46.ProveUseCase>()));
  gh.factoryAsync<_i53.RemoveCurrentIdentityUseCase>(() async =>
      _i53.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i51.IdentityRepository>()));
  gh.factoryAsync<_i54.SignMessageUseCase>(() async =>
      _i54.SignMessageUseCase(await get.getAsync<_i51.IdentityRepository>()));
  gh.factoryAsync<_i55.CreateIdentityUseCase>(() async =>
      _i55.CreateIdentityUseCase(
          await get.getAsync<_i51.IdentityRepository>()));
  gh.factoryAsync<_i56.GetCurrentIdentifierUseCase>(() async =>
      _i56.GetCurrentIdentifierUseCase(
          await get.getAsync<_i51.IdentityRepository>()));
  gh.factoryAsync<_i57.GetIdentityUseCase>(() async =>
      _i57.GetIdentityUseCase(await get.getAsync<_i51.IdentityRepository>()));
  gh.factoryAsync<_i58.Iden3commRepositoryImpl>(() async =>
      _i58.Iden3commRepositoryImpl(
          get<_i30.WalletDataSource>(),
          get<_i27.RemoteIden3commDataSource>(),
          get<_i16.JWZDataSource>(),
          get<_i12.HexMapper>(),
          get<_i3.AuthRequestMapper>(),
          get<_i23.ProofScopeDataSource>(),
          await get.getAsync<_i37.StorageClaimDataSource>(),
          get<_i36.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i4.AuthResponseMapper>(),
          await get.getAsync<_i51.IdentityRepository>(),
          get<_i45.ProofRepository>()));
  gh.factoryAsync<_i59.IdentityWallet>(() async => _i59.IdentityWallet(
      await get.getAsync<_i55.CreateIdentityUseCase>(),
      await get.getAsync<_i57.GetIdentityUseCase>(),
      await get.getAsync<_i54.SignMessageUseCase>(),
      await get.getAsync<_i56.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i53.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i60.Iden3commRepository>(() async => repositoriesModule
      .iden3commRepository(await get.getAsync<_i58.Iden3commRepositoryImpl>()));
  gh.factoryAsync<_i61.AuthenticateUseCase>(() async =>
      _i61.AuthenticateUseCase(await get.getAsync<_i60.Iden3commRepository>()));
  gh.factoryAsync<_i62.GetAuthTokenUseCase>(() async =>
      _i62.GetAuthTokenUseCase(await get.getAsync<_i60.Iden3commRepository>()));
  gh.factoryAsync<_i63.Iden3comm>(() async =>
      _i63.Iden3comm(await get.getAsync<_i61.AuthenticateUseCase>()));
  gh.factoryAsync<_i64.FetchAndSaveClaimsUseCase>(() async =>
      _i64.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i62.GetAuthTokenUseCase>(),
          await get.getAsync<_i42.CredentialRepository>()));
  gh.factoryAsync<_i65.CredentialWallet>(() async => _i65.CredentialWallet(
      await get.getAsync<_i64.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i43.GetClaimsUseCase>(),
      await get.getAsync<_i47.RemoveClaimsUseCase>(),
      await get.getAsync<_i48.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i66.NetworkModule {}

class _$DatabaseModule extends _i66.DatabaseModule {}

class _$RepositoriesModule extends _i66.RepositoriesModule {}
