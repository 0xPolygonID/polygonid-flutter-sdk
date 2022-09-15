// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i7;

import '../../credential/data/credential_repository_impl.dart' as _i30;
import '../../credential/data/data_sources/remote_claim_data_source.dart'
    as _i17;
import '../../credential/data/data_sources/storage_claim_data_source.dart'
    as _i26;
import '../../credential/data/mappers/claim_mapper.dart' as _i25;
import '../../credential/data/mappers/claim_state_mapper.dart' as _i4;
import '../../credential/data/mappers/credential_request_mapper.dart' as _i6;
import '../../credential/data/mappers/filter_mapper.dart' as _i8;
import '../../credential/data/mappers/filters_mapper.dart' as _i9;
import '../../credential/data/mappers/id_filter_mapper.dart' as _i11;
import '../../credential/domain/repositories/credential_repository.dart'
    as _i31;
import '../../credential/domain/use_cases/fetch_and_save_claims_use_case.dart'
    as _i44;
import '../../credential/domain/use_cases/get_claims_use_case.dart' as _i32;
import '../../credential/domain/use_cases/remove_claims_use_case.dart' as _i34;
import '../../credential/domain/use_cases/update_claim_use_case.dart' as _i35;
import '../../identity/data/data_sources/jwz_data_source.dart' as _i14;
import '../../identity/data/data_sources/lib_identity_data_source.dart' as _i29;
import '../../identity/data/data_sources/storage_identity_data_source.dart'
    as _i27;
import '../../identity/data/data_sources/storage_key_value_data_source.dart'
    as _i28;
import '../../identity/data/data_sources/wallet_data_source.dart' as _i21;
import '../../identity/data/mappers/hex_mapper.dart' as _i10;
import '../../identity/data/mappers/identity_dto_mapper.dart' as _i13;
import '../../identity/data/mappers/private_key_mapper.dart' as _i15;
import '../../identity/data/repositories/identity_repository_impl.dart' as _i33;
import '../../identity/data/repositories/smt_memory_storage_repository_impl.dart'
    as _i18;
import '../../identity/domain/repositories/identity_repository.dart' as _i36;
import '../../identity/domain/repositories/smt_storage_repository.dart' as _i20;
import '../../identity/domain/use_cases/create_identity_use_case.dart' as _i39;
import '../../identity/domain/use_cases/get_auth_token_use_case.dart' as _i40;
import '../../identity/domain/use_cases/get_current_identifier_use_case.dart'
    as _i41;
import '../../identity/domain/use_cases/get_identity_use_case.dart' as _i42;
import '../../identity/domain/use_cases/remove_current_identity_use_case.dart'
    as _i37;
import '../../identity/domain/use_cases/sign_message_use_case.dart' as _i38;
import '../../identity/libs/bjj/bjj.dart' as _i3;
import '../../identity/libs/iden3core/iden3core.dart' as _i12;
import '../../identity/libs/smt/hash.dart' as _i19;
import '../../proof_generation/libs/prover/prover.dart' as _i16;
import '../../proof_generation/libs/witnesscalc/auth/witness_auth.dart' as _i22;
import '../../proof_generation/libs/witnesscalc/mtp/witness_mtp.dart' as _i23;
import '../../proof_generation/libs/witnesscalc/sig/witness_sig.dart' as _i24;
import '../credential_wallet.dart' as _i45;
import '../identity_wallet.dart' as _i43;
import 'injector.dart' as _i46; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.BabyjubjubLib>(() => _i3.BabyjubjubLib());
  gh.factory<_i4.ClaimStateMapper>(() => _i4.ClaimStateMapper());
  gh.factory<_i5.Client>(() => networkModule.client);
  gh.factory<_i6.CredentialRequestMapper>(() => _i6.CredentialRequestMapper());
  gh.lazySingletonAsync<_i7.Database>(() => databaseModule.database());
  gh.factory<_i8.FilterMapper>(() => _i8.FilterMapper());
  gh.factory<_i9.FiltersMapper>(
      () => _i9.FiltersMapper(get<_i8.FilterMapper>()));
  gh.factory<_i10.HexMapper>(() => _i10.HexMapper());
  gh.factory<_i11.IdFilterMapper>(() => _i11.IdFilterMapper());
  gh.factory<_i12.Iden3CoreLib>(() => _i12.Iden3CoreLib());
  gh.factory<_i13.IdentityDTOMapper>(() => _i13.IdentityDTOMapper());
  gh.factory<_i14.JWZIsolatesWrapper>(() => _i14.JWZIsolatesWrapper());
  gh.factory<_i15.PrivateKeyMapper>(() => _i15.PrivateKeyMapper());
  gh.factory<_i16.ProverLib>(() => _i16.ProverLib());
  gh.factory<_i17.RemoteClaimDataSource>(
      () => _i17.RemoteClaimDataSource(get<_i5.Client>()));
  gh.factory<_i18.SMTMemoryStorageRepositoryImpl>(
      () => _i18.SMTMemoryStorageRepositoryImpl(null));
  gh.factory<_i20.SMTStorageRepository>(() => repositoriesModule
      .smtStorageRepository(get<_i18.SMTMemoryStorageRepositoryImpl>()));
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i7.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i21.WalletLibWrapper>(() => _i21.WalletLibWrapper());
  gh.factory<_i22.WitnessAuthLib>(() => _i22.WitnessAuthLib());
  gh.factory<_i23.WitnessMtpLib>(() => _i23.WitnessMtpLib());
  gh.factory<_i24.WitnessSigLib>(() => _i24.WitnessSigLib());
  gh.factory<_i25.ClaimMapper>(
      () => _i25.ClaimMapper(get<_i4.ClaimStateMapper>()));
  gh.factory<_i26.ClaimStoreRefWrapper>(() => _i26.ClaimStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i27.IdentityStoreRefWrapper>(() => _i27.IdentityStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i28.KeyValueStoreRefWrapper>(() => _i28.KeyValueStoreRefWrapper(
      get<_i7.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i29.LibIdentityDataSource>(() => _i29.LibIdentityDataSource(
      get<_i12.Iden3CoreLib>(), get<_i20.SMTStorageRepository>()));
  gh.factoryAsync<_i26.StorageClaimDataSource>(() async =>
      _i26.StorageClaimDataSource(await get.getAsync<_i7.Database>(),
          get<_i26.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i28.StorageKeyValueDataSource>(() async =>
      _i28.StorageKeyValueDataSource(await get.getAsync<_i7.Database>(),
          get<_i28.KeyValueStoreRefWrapper>()));
  gh.factory<_i21.WalletDataSource>(
      () => _i21.WalletDataSource(get<_i21.WalletLibWrapper>()));
  gh.factoryAsync<_i30.CredentialRepositoryImpl>(() async =>
      _i30.CredentialRepositoryImpl(
          get<_i17.RemoteClaimDataSource>(),
          await get.getAsync<_i26.StorageClaimDataSource>(),
          get<_i6.CredentialRequestMapper>(),
          get<_i25.ClaimMapper>(),
          get<_i9.FiltersMapper>(),
          get<_i11.IdFilterMapper>()));
  gh.factory<_i14.JWZDataSource>(() => _i14.JWZDataSource(
      get<_i3.BabyjubjubLib>(),
      get<_i21.WalletDataSource>(),
      get<_i14.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i27.StorageIdentityDataSource>(() async =>
      _i27.StorageIdentityDataSource(
          await get.getAsync<_i7.Database>(),
          get<_i27.IdentityStoreRefWrapper>(),
          await get.getAsync<_i28.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i31.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i30.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i32.GetClaimsUseCase>(() async =>
      _i32.GetClaimsUseCase(await get.getAsync<_i31.CredentialRepository>()));
  gh.factoryAsync<_i33.IdentityRepositoryImpl>(() async =>
      _i33.IdentityRepositoryImpl(
          get<_i21.WalletDataSource>(),
          get<_i29.LibIdentityDataSource>(),
          await get.getAsync<_i27.StorageIdentityDataSource>(),
          await get.getAsync<_i28.StorageKeyValueDataSource>(),
          get<_i14.JWZDataSource>(),
          get<_i10.HexMapper>(),
          get<_i15.PrivateKeyMapper>(),
          get<_i13.IdentityDTOMapper>(),
          get<_i20.SMTStorageRepository>()));
  gh.factoryAsync<_i34.RemoveClaimsUseCase>(() async =>
      _i34.RemoveClaimsUseCase(
          await get.getAsync<_i31.CredentialRepository>()));
  gh.factoryAsync<_i35.UpdateClaimUseCase>(() async =>
      _i35.UpdateClaimUseCase(await get.getAsync<_i31.CredentialRepository>()));
  gh.factoryAsync<_i36.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i33.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i37.RemoveCurrentIdentityUseCase>(() async =>
      _i37.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i38.SignMessageUseCase>(() async =>
      _i38.SignMessageUseCase(await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i39.CreateIdentityUseCase>(() async =>
      _i39.CreateIdentityUseCase(
          await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i40.GetAuthTokenUseCase>(() async =>
      _i40.GetAuthTokenUseCase(await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i41.GetCurrentIdentifierUseCase>(() async =>
      _i41.GetCurrentIdentifierUseCase(
          await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i42.GetIdentityUseCase>(() async =>
      _i42.GetIdentityUseCase(await get.getAsync<_i36.IdentityRepository>()));
  gh.factoryAsync<_i43.IdentityWallet>(() async => _i43.IdentityWallet(
      await get.getAsync<_i39.CreateIdentityUseCase>(),
      await get.getAsync<_i42.GetIdentityUseCase>(),
      await get.getAsync<_i38.SignMessageUseCase>(),
      await get.getAsync<_i40.GetAuthTokenUseCase>(),
      await get.getAsync<_i41.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i37.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i44.FetchAndSaveClaimsUseCase>(() async =>
      _i44.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i40.GetAuthTokenUseCase>(),
          await get.getAsync<_i31.CredentialRepository>()));
  gh.factoryAsync<_i45.CredentialWallet>(() async => _i45.CredentialWallet(
      await get.getAsync<_i44.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i32.GetClaimsUseCase>(),
      await get.getAsync<_i34.RemoveClaimsUseCase>(),
      await get.getAsync<_i35.UpdateClaimUseCase>()));
  return get;
}

class _$NetworkModule extends _i46.NetworkModule {}

class _$DatabaseModule extends _i46.DatabaseModule {}

class _$RepositoriesModule extends _i46.RepositoriesModule {}
