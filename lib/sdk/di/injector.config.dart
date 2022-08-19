// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i7;

import '../../data/credential/credential_repository_impl.dart' as _i22;
import '../../data/credential/data_sources/remote_claim_data_source.dart'
    as _i16;
import '../../data/credential/data_sources/storage_claim_data_source.dart'
    as _i19;
import '../../data/credential/mappers/claim_mapper.dart' as _i18;
import '../../data/credential/mappers/claim_state_mapper.dart' as _i4;
import '../../data/credential/mappers/credential_request_mapper.dart' as _i6;
import '../../data/credential/mappers/filter_mapper.dart' as _i8;
import '../../data/credential/mappers/filters_mapper.dart' as _i9;
import '../../data/identity/data_sources/jwz_data_source.dart' as _i13;
import '../../data/identity/data_sources/lib_identity_data_source.dart' as _i14;
import '../../data/identity/data_sources/storage_identity_data_source.dart'
    as _i20;
import '../../data/identity/data_sources/storage_key_value_data_source.dart'
    as _i21;
import '../../data/identity/data_sources/wallet_data_source.dart' as _i17;
import '../../data/identity/mappers/hex_mapper.dart' as _i10;
import '../../data/identity/mappers/identity_dto_mapper.dart' as _i12;
import '../../data/identity/mappers/private_key_mapper.dart' as _i15;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i25;
import '../../domain/credential/use_cases/fetch_and_save_claims_use_case.dart'
    as _i35;
import '../../domain/credential/use_cases/get_claims_use_case.dart' as _i24;
import '../../domain/credential/use_cases/remove_claims_use_case.dart' as _i26;
import '../../domain/identity/repositories/credential_repository.dart' as _i23;
import '../../domain/identity/repositories/identity_repository.dart' as _i27;
import '../../domain/identity/use_cases/create_identity_use_case.dart' as _i30;
import '../../domain/identity/use_cases/get_auth_token_use_case.dart' as _i31;
import '../../domain/identity/use_cases/get_current_identifier_use_case.dart'
    as _i32;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i33;
import '../../domain/identity/use_cases/remove_current_identity_use_case.dart'
    as _i28;
import '../../domain/identity/use_cases/sign_message_use_case.dart' as _i29;
import '../../libs/circomlib.dart' as _i3;
import '../../libs/iden3corelib.dart' as _i11;
import '../credential_wallet.dart' as _i36;
import '../identity_wallet.dart' as _i34;
import 'injector.dart' as _i37; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.CircomLib>(() => _i3.CircomLib());
  gh.factory<_i4.ClaimStateMapper>(() => _i4.ClaimStateMapper());
  gh.factory<_i5.Client>(() => networkModule.client);
  gh.factory<_i6.CredentialRequestMapper>(() => _i6.CredentialRequestMapper());
  gh.lazySingletonAsync<_i7.Database>(() => databaseModule.database());
  gh.factory<_i8.FilterMapper>(() => _i8.FilterMapper());
  gh.factory<_i9.FiltersMapper>(
      () => _i9.FiltersMapper(get<_i8.FilterMapper>()));
  gh.factory<_i10.HexMapper>(() => _i10.HexMapper());
  gh.factory<_i11.Iden3CoreLib>(() => _i11.Iden3CoreLib());
  gh.factory<_i12.IdentityDTOMapper>(() => _i12.IdentityDTOMapper());
  gh.factory<_i13.JWZIsolatesWrapper>(() => _i13.JWZIsolatesWrapper());
  gh.factory<_i14.LibIdentityDataSource>(
      () => _i14.LibIdentityDataSource(get<_i11.Iden3CoreLib>()));
  gh.factory<_i15.PrivateKeyMapper>(() => _i15.PrivateKeyMapper());
  gh.factory<_i16.RemoteClaimDataSource>(
      () => _i16.RemoteClaimDataSource(get<_i5.Client>()));
  gh.factory<_i7.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.claimStore,
      instanceName: 'claimStore');
  gh.factory<_i7.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i17.WalletLibWrapper>(() => _i17.WalletLibWrapper());
  gh.factory<_i18.ClaimMapper>(
      () => _i18.ClaimMapper(get<_i4.ClaimStateMapper>()));
  gh.factory<_i19.ClaimStoreRefWrapper>(() => _i19.ClaimStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'claimStore')));
  gh.factory<_i20.IdentityStoreRefWrapper>(() => _i20.IdentityStoreRefWrapper(
      get<_i7.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i21.KeyValueStoreRefWrapper>(() => _i21.KeyValueStoreRefWrapper(
      get<_i7.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i19.StorageClaimDataSource>(() async =>
      _i19.StorageClaimDataSource(await get.getAsync<_i7.Database>(),
          get<_i19.ClaimStoreRefWrapper>()));
  gh.factoryAsync<_i21.StorageKeyValueDataSource>(() async =>
      _i21.StorageKeyValueDataSource(await get.getAsync<_i7.Database>(),
          get<_i21.KeyValueStoreRefWrapper>()));
  gh.factory<_i17.WalletDataSource>(
      () => _i17.WalletDataSource(get<_i17.WalletLibWrapper>()));
  gh.factoryAsync<_i22.CredentialRepositoryImpl>(() async =>
      _i22.CredentialRepositoryImpl(
          get<_i16.RemoteClaimDataSource>(),
          await get.getAsync<_i19.StorageClaimDataSource>(),
          get<_i6.CredentialRequestMapper>(),
          get<_i18.ClaimMapper>(),
          get<_i9.FiltersMapper>()));
  gh.factory<_i13.JWZDataSource>(() => _i13.JWZDataSource(get<_i3.CircomLib>(),
      get<_i17.WalletDataSource>(), get<_i13.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i20.StorageIdentityDataSource>(() async =>
      _i20.StorageIdentityDataSource(
          await get.getAsync<_i7.Database>(),
          get<_i20.IdentityStoreRefWrapper>(),
          await get.getAsync<_i21.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i23.CredentialRepository>(() async =>
      repositoriesModule.credentialRepository(
          await get.getAsync<_i22.CredentialRepositoryImpl>()));
  gh.factoryAsync<_i24.GetClaimsUseCase>(() async =>
      _i24.GetClaimsUseCase(await get.getAsync<_i23.CredentialRepository>()));
  gh.factoryAsync<_i25.IdentityRepositoryImpl>(() async =>
      _i25.IdentityRepositoryImpl(
          get<_i17.WalletDataSource>(),
          get<_i14.LibIdentityDataSource>(),
          await get.getAsync<_i20.StorageIdentityDataSource>(),
          await get.getAsync<_i21.StorageKeyValueDataSource>(),
          get<_i13.JWZDataSource>(),
          get<_i10.HexMapper>(),
          get<_i15.PrivateKeyMapper>(),
          get<_i12.IdentityDTOMapper>()));
  gh.factoryAsync<_i26.RemoveClaimsUseCase>(() async =>
      _i26.RemoveClaimsUseCase(
          await get.getAsync<_i23.CredentialRepository>()));
  gh.factoryAsync<_i27.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i25.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i28.RemoveCurrentIdentityUseCase>(() async =>
      _i28.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i29.SignMessageUseCase>(() async =>
      _i29.SignMessageUseCase(await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i30.CreateIdentityUseCase>(() async =>
      _i30.CreateIdentityUseCase(
          await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i31.GetAuthTokenUseCase>(() async =>
      _i31.GetAuthTokenUseCase(await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i32.GetCurrentIdentifierUseCase>(() async =>
      _i32.GetCurrentIdentifierUseCase(
          await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i33.GetIdentityUseCase>(() async =>
      _i33.GetIdentityUseCase(await get.getAsync<_i27.IdentityRepository>()));
  gh.factoryAsync<_i34.IdentityWallet>(() async => _i34.IdentityWallet(
      await get.getAsync<_i30.CreateIdentityUseCase>(),
      await get.getAsync<_i33.GetIdentityUseCase>(),
      await get.getAsync<_i29.SignMessageUseCase>(),
      await get.getAsync<_i31.GetAuthTokenUseCase>(),
      await get.getAsync<_i32.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i28.RemoveCurrentIdentityUseCase>()));
  gh.factoryAsync<_i35.FetchAndSaveClaimsUseCase>(() async =>
      _i35.FetchAndSaveClaimsUseCase(
          await get.getAsync<_i31.GetAuthTokenUseCase>(),
          await get.getAsync<_i23.CredentialRepository>()));
  gh.factoryAsync<_i36.CredentialWallet>(() async => _i36.CredentialWallet(
      await get.getAsync<_i35.FetchAndSaveClaimsUseCase>(),
      await get.getAsync<_i24.GetClaimsUseCase>(),
      await get.getAsync<_i26.RemoveClaimsUseCase>()));
  return get;
}

class _$NetworkModule extends _i37.NetworkModule {}

class _$DatabaseModule extends _i37.DatabaseModule {}

class _$RepositoriesModule extends _i37.RepositoriesModule {}
