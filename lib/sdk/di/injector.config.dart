// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i4;

import '../../data/identity/data_sources/jwz_data_source.dart' as _i7;
import '../../data/identity/data_sources/lib_identity_data_source.dart' as _i9;
import '../../data/identity/data_sources/storage_identity_data_source.dart'
    as _i10;
import '../../data/identity/data_sources/storage_key_value_data_source.dart'
    as _i11;
import '../../data/identity/mappers/hex_mapper.dart' as _i5;
import '../../data/identity/mappers/private_key_mapper.dart' as _i8;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i12;
import '../../domain/identity/repositories/identity_repository.dart' as _i13;
import '../../domain/identity/use_cases/create_identity_use_case.dart' as _i16;
import '../../domain/identity/use_cases/get_auth_token_use_case.dart' as _i17;
import '../../domain/identity/use_cases/get_current_identifier_use_case.dart'
    as _i18;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i19;
import '../../domain/identity/use_cases/remove_current_identifier_use_case.dart'
    as _i14;
import '../../domain/identity/use_cases/sign_message_use_case.dart' as _i15;
import '../../libs/circomlib.dart' as _i3;
import '../../libs/iden3corelib.dart' as _i6;
import '../identity_wallet.dart' as _i20;
import 'injector.dart' as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.CircomLib>(() => _i3.CircomLib());
  gh.lazySingletonAsync<_i4.Database>(() => databaseModule.database());
  gh.factory<_i5.HexMapper>(() => _i5.HexMapper());
  gh.factory<_i6.Iden3CoreLib>(() => _i6.Iden3CoreLib());
  gh.factory<_i7.JWZIsolatesWrapper>(() => _i7.JWZIsolatesWrapper());
  gh.factory<_i8.PrivateKeyMapper>(() => _i8.PrivateKeyMapper());
  gh.factory<_i4.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i4.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i9.WalletLibWrapper>(() => _i9.WalletLibWrapper());
  gh.factory<_i10.IdentityStoreRefWrapper>(() => _i10.IdentityStoreRefWrapper(
      get<_i4.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i11.KeyValueStoreRefWrapper>(() => _i11.KeyValueStoreRefWrapper(
      get<_i4.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i9.LibIdentityDataSource>(() => _i9.LibIdentityDataSource(
      get<_i6.Iden3CoreLib>(), get<_i9.WalletLibWrapper>()));
  gh.factoryAsync<_i11.StorageKeyValueDataSource>(() async =>
      _i11.StorageKeyValueDataSource(await get.getAsync<_i4.Database>(),
          get<_i11.KeyValueStoreRefWrapper>()));
  gh.factory<_i7.JWZDataSource>(() => _i7.JWZDataSource(get<_i3.CircomLib>(),
      get<_i9.LibIdentityDataSource>(), get<_i7.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i10.StorageIdentityDataSource>(() async =>
      _i10.StorageIdentityDataSource(
          await get.getAsync<_i4.Database>(),
          get<_i10.IdentityStoreRefWrapper>(),
          await get.getAsync<_i11.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i12.IdentityRepositoryImpl>(() async =>
      _i12.IdentityRepositoryImpl(
          get<_i9.LibIdentityDataSource>(),
          await get.getAsync<_i10.StorageIdentityDataSource>(),
          await get.getAsync<_i11.StorageKeyValueDataSource>(),
          get<_i7.JWZDataSource>(),
          get<_i5.HexMapper>(),
          get<_i8.PrivateKeyMapper>()));
  gh.factoryAsync<_i13.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i12.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i14.RemoveCurrentIdentityUseCase>(() async =>
      _i14.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i15.SignMessageUseCase>(() async =>
      _i15.SignMessageUseCase(await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i16.CreateIdentityUseCase>(() async =>
      _i16.CreateIdentityUseCase(
          await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i17.GetAuthTokenUseCase>(() async =>
      _i17.GetAuthTokenUseCase(await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i18.GetCurrentIdentifierUseCase>(() async =>
      _i18.GetCurrentIdentifierUseCase(
          await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i19.GetIdentityUseCase>(() async =>
      _i19.GetIdentityUseCase(await get.getAsync<_i13.IdentityRepository>()));
  gh.factoryAsync<_i20.IdentityWallet>(() async => _i20.IdentityWallet(
      await get.getAsync<_i16.CreateIdentityUseCase>(),
      await get.getAsync<_i19.GetIdentityUseCase>(),
      await get.getAsync<_i15.SignMessageUseCase>(),
      await get.getAsync<_i17.GetAuthTokenUseCase>(),
      await get.getAsync<_i18.GetCurrentIdentifierUseCase>()));
  return get;
}

class _$DatabaseModule extends _i21.DatabaseModule {}

class _$RepositoriesModule extends _i21.RepositoriesModule {}
