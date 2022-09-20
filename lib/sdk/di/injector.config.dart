// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i9;

import '../../credential/data/credential_repository_impl.dart' as _i38;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i22;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i34;
import '../../credential/data/mappers/claim_mapper.dart' as _i33;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i6;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i8;
import '../../credential/data/mappers/filter_mapper.dart' as _i10;
import '../../credential/data/mappers/filters_mapper.dart' as _i11;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i13;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i39;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i53;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i40;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i42;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i43;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i16;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i37;
import '../../identity/data/data_sources/remote_identity_data_source.dart'
    as _i23;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i35;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i36;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i27;
import '../../identity/data/mappers/auth_request_mapper.dart' as _i3;
import '../../identity/data/mappers/auth_response_mapper.dart' as _i4;
import '../../identity/data/mappers/hex_mapper.dart' as _i12;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i15;
import '../../identity/data/mappers/private_key_mapper.dart' as _i18;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i41;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i24;
import '../../identity/domain/repositories/identity_repository.dart' as _i44;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i26;
import '../../identity/domain/use_cases/authenticate_use_case.dart' as _i47;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i48;
import '../../identity/domain/use_cases/get_auth_token_use_case.dart' as _i49;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i50;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i51;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i45;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i46;
import '../../identity/libs/bjj/bjj.dart' as _i5;
import '../../identity/libs/iden3core/iden3core.dart' as _i14;
import '../../identity/libs/smt/hash.dart' as _i25;
import '../../proof_generation/data/data_sources/atomic_query_inputs_data_source.dart'
    as _i32;
import '../../proof_generation/data/data_sources/local_files_data_source.dart'
    as _i17;
import '../../proof_generation/data/data_sources/proof_scope_data_source.dart'
    as _i19;
import '../../proof_generation/data/data_sources/prover_lib_data_source.dart'
    as _i21;
import '../../proof_generation/data/data_sources/witness_data_source.dart'
    as _i29;
import '../../proof_generation/libs/prover/prover.dart' as _i20;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i28;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i30;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i31;
import '../credential_wallet.dart' as _i54;
import '../identity_wallet.dart' as _i52;
import 'injector.dart' as _i55; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i17.LocalFilesDataSource>(() => _i17.LocalFilesDataSource());
  gh.factory<_i18.PrivateKeyMapper>(() => _i18.PrivateKeyMapper());
  gh.factory<_i19.ProofScopeDataSource>(() => _i19.ProofScopeDataSource());
  gh.factory<_i20.ProverLib>(() => _i20.ProverLib());
  gh.factory<_i21.ProverLibWrapper>(() => _i21.ProverLibWrapper());
  gh.factory<_i22.RemoteClaimDataSource>(
      () => _i22.RemoteClaimDataSource(get<_i7.Client>()));
  gh.factory<_i23.RemoteIdentityDataSource>(
      () => _i23.RemoteIdentityDataSource(get<_i7.Client>()));
  gh.factory<_i24.SMTMemoryStorageRepositoryImpl>(() =>
      _i24.SMTMemoryStorageRepositoryImpl(get<_i25.Hash>(),
          data: get<dynamic>()));
  gh.factory<_i26.SMTStorageRepository>(() => repositoriesModule
      .smtStorageRepository(get<_i24.SMTMemoryStorageRepositoryImpl>()));
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i9.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i9.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i27.WalletLibWrapper>(() => _i27.WalletLibWrapper());
  gh.factory<_i28.WitnessAuthLib>(() => _i28.WitnessAuthLib());
  gh.factory<_i29.WitnessIsolatesWrapper>(() => _i29.WitnessIsolatesWrapper());
  gh.factory<_i30.WitnessMtpLib>(() => _i30.WitnessMtpLib());
  gh.factory<_i31.WitnessSigLib>(() => _i31.WitnessSigLib());
  gh.factory<_i32.AtomicQueryInputsWrapper>(
      () => _i32.AtomicQueryInputsWrapper(get<_i14.Iden3CoreLib>()));
  gh.factory<_i33.ClaimMapper>(
      () => _i33.ClaimMapper(get<_i6.ClaimStateMapper>()));
  gh.factory<_i34.ClaimStoreRefWrapper>(() => _i34.ClaimStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i35.IdentityStoreRefWrapper>(() => _i35.IdentityStoreRefWrapper(
      get<_i9.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i36.KeyValueStoreRefWrapper>(() => _i36.KeyValueStoreRefWrapper(
      get<_i9.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i37.LibIdentityDataSource>(() => _i37.LibIdentityDataSource(
      get<_i14.Iden3CoreLib>(), get<_i26.SMTStorageRepository>()));
  gh.factory<_i21.ProverLibDataSource>(
      () => _i21.ProverLibDataSource(get<_i21.ProverLibWrapper>()));
  gh.factoryAsync<_i34.StorageClaimDataSource>(() async =>
      _i34.StorageClaimDataSource(await get.getAsync<_i9.Database>(),
          get<_i34.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i36.StorageKeyValueDataSource>(() async =>
      _i36.StorageKeyValueDataSource(await get.getAsync<_i9.Database>(),
          get<_i36.KeyValueStoreRefWrapper>()));
  gh.factory<_i27.WalletDataSource>(
      () => _i27.WalletDataSource(get<_i27.WalletLibWrapper>()));
  gh.factory<_i29.WitnessDataSource>(
      () => _i29.WitnessDataSource(get<_i29.WitnessIsolatesWrapper>()));
  gh.factory<_i32.AtomicQueryInputsDataSource>(() =>
      _i32.AtomicQueryInputsDataSource(get<_i32.AtomicQueryInputsWrapper>()));
  gh.factoryAsync<_i38.CredentialRepositoryImpl>(() async =>
      _i38.CredentialRepositoryImpl(
          get<_i22.RemoteClaimDataSource>(),
          await get.getAsync<_i34.StorageClaimDataSource>(),
          get<_i8.CredentialRequestMapper>(),
          get<_i33.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i13.IdFilterMapper>()));
  gh.factory<_i16.JWZDataSource>(() => _i16.JWZDataSource(
      get<_i5.BabyjubjubLib>(),
      get<_i27.WalletDataSource>(),
      get<_i16.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i35.StorageIdentityDataSource>(() async =>
      _i35.StorageIdentityDataSource(
          await get.getAsync<_i9.Database>(),
          get<_i35.IdentityStoreRefWrapper>(),
          await get.getAsync<_i36.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i39.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i38.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i40.GetClaimsUseCase>(() async =>
      _i40.GetClaimsUseCase(await get.getAsync<_i39.CredentialRepository>()));
  gh.factoryAsync<_i41.IdentityRepositoryImpl>(() async =>
      _i41.IdentityRepositoryImpl(
          get<_i27.WalletDataSource>(),
          get<_i37.LibIdentityDataSource>(),
          await get.getAsync<_i35.StorageIdentityDataSource>(),
          await get.getAsync<_i36.StorageKeyValueDataSource>(),
          get<_i16.JWZDataSource>(),
          get<_i12.HexMapper>(),
          get<_i18.PrivateKeyMapper>(),
          get<_i15.IdentityDTOMapper>(),
          get<_i23.RemoteIdentityDataSource>(),
          get<_i3.AuthRequestMapper>(),
          get<_i19.ProofScopeDataSource>(),
          await get.getAsync<_i34.StorageClaimDataSource>(),
          get<_i33.ClaimMapper>(),
          get<_i11.FiltersMapper>(),
          get<_i29.WitnessDataSource>(),
          get<_i21.ProverLibDataSource>(),
          get<_i4.AuthResponseMapper>(),
          get<_i32.AtomicQueryInputsDataSource>(),
          get<_i17.LocalFilesDataSource>(),
          get<_i26.SMTStorageRepository>()));
  gh.factoryAsync<_i42.RemoveClaimsUseCase>(() async =>
      _i42.RemoveClaimsUseCase(
          await get.getAsync<_i39.CredentialRepository>()));
  gh.factoryAsync<_i43.UpdateClaimUseCase>(() async =>
      _i43.UpdateClaimUseCase(await get.getAsync<_i39.CredentialRepository>()));
  gh.factoryAsync<_i44.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i41.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i45.RemoveCurrentIdentityUseCase>(() async =>
      _i45.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i46.SignMessageUseCase>(() async =>
      _i46.SignMessageUseCase(await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i47.AuthenticateUseCase>(() async =>
      _i47.AuthenticateUseCase(await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i48.CreateIdentityUseCase>(() async =>
      _i48.CreateIdentityUseCase(
          await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i49.GetAuthTokenUseCase>(() async =>
      _i49.GetAuthTokenUseCase(await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i50.GetCurrentIdentifierUseCase>(() async =>
      _i50.GetCurrentIdentifierUseCase(
          await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i51.GetIdentityUseCase>(() async =>
      _i51.GetIdentityUseCase(await get.getAsync<_i44.IdentityRepository>()));
  gh.factoryAsync<_i52.IdentityWallet>(() async => _i52.IdentityWallet(
      await get.getAsync<_i48.CreateIdentityUseCase>(),
      await get.getAsync<_i51.GetIdentityUseCase>(),
      await get.getAsync<_i46.SignMessageUseCase>(),
      await get.getAsync<_i49.GetAuthTokenUseCase>(),
      await get.getAsync<_i50.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i45.RemoveCurrentIdentityUseCase>(),
      await get.getAsync<_i47.AuthenticateUseCase>()));
  gh.factoryAsync<_i53.FetchAndSaveClaimsUseCase>(() async =>
      _i53.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i49.GetAuthTokenUseCase>(),
          await get.getAsync<_i39.CredentialRepository>()));
  gh.factoryAsync<_i54.CredentialWallet>(() async => _i54.CredentialWallet(
      await get.getAsync<_i53.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i40.GetClaimsUseCase>(),
      await get.getAsync<_i42.RemoveClaimsUseCase>(),
      await get.getAsync<_i43.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i55.NetworkModule {}

class _$DatabaseModule extends _i55.DatabaseModule {}

class _$RepositoriesModule extends _i55.RepositoriesModule {}
