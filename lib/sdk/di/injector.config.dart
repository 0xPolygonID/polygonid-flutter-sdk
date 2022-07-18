// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i3;

import '../../data/identity/data_sources/lib_identity_data_source.dart' as _i7;
import '../../data/identity/data_sources/storage_identity_data_source.dart'
    as _i8;
import '../../data/identity/data_sources/storage_key_value_data_source.dart'
    as _i9;
import '../../data/identity/mappers/hex_mapper.dart' as _i4;
import '../../data/identity/mappers/private_key_mapper.dart' as _i6;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i10;
import '../../domain/identity/repositories/identity_repository.dart' as _i11;
import '../../domain/identity/use_cases/create_identity_use_case.dart' as _i13;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i14;
import '../../domain/identity/use_cases/sign_message_use_case.dart' as _i12;
import '../../libs/iden3corelib.dart' as _i5;
import '../identity_wallet.dart' as _i15;
import 'injector.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingletonAsync<_i3.Database>(() => databaseModule.database());
  gh.factory<_i4.HexMapper>(() => _i4.HexMapper());
  gh.factory<_i5.Iden3CoreLib>(() => _i5.Iden3CoreLib());
  gh.factory<_i6.PrivateKeyMapper>(() => _i6.PrivateKeyMapper());
  gh.factory<_i3.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i3.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i7.WalletLibWrapper>(() => _i7.WalletLibWrapper());
  gh.factory<_i8.IdentityStoreRefWrapper>(() => _i8.IdentityStoreRefWrapper(
      get<_i3.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i9.KeyValueStoreRefWrapper>(() => _i9.KeyValueStoreRefWrapper(
      get<_i3.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factory<_i7.LibIdentityDataSource>(() => _i7.LibIdentityDataSource(
      get<_i5.Iden3CoreLib>(), get<_i7.WalletLibWrapper>()));
  gh.factoryAsync<_i9.StorageKeyValueDataSource>(() async =>
      _i9.StorageKeyValueDataSource(await get.getAsync<_i3.Database>(),
          get<_i9.KeyValueStoreRefWrapper>()));
  gh.factoryAsync<_i8.StorageIdentityDataSource>(() async =>
      _i8.StorageIdentityDataSource(
          await get.getAsync<_i3.Database>(),
          get<_i8.IdentityStoreRefWrapper>(),
          await get.getAsync<_i9.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i10.IdentityRepositoryImpl>(() async =>
      _i10.IdentityRepositoryImpl(
          get<_i7.LibIdentityDataSource>(),
          await get.getAsync<_i8.StorageIdentityDataSource>(),
          await get.getAsync<_i9.StorageKeyValueDataSource>(),
          get<_i4.HexMapper>(),
          get<_i6.PrivateKeyMapper>()));
  gh.factoryAsync<_i11.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i10.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i12.SignMessageUseCase>(() async =>
      _i12.SignMessageUseCase(await get.getAsync<_i11.IdentityRepository>()));
  gh.factoryAsync<_i13.CreateIdentityUseCase>(() async =>
      _i13.CreateIdentityUseCase(
          await get.getAsync<_i11.IdentityRepository>()));
  gh.factoryAsync<_i14.GetIdentityUseCase>(() async =>
      _i14.GetIdentityUseCase(await get.getAsync<_i11.IdentityRepository>()));
  gh.factoryAsync<_i15.IdentityWallet>(() async => _i15.IdentityWallet(
      await get.getAsync<_i14.GetIdentityUseCase>(),
      await get.getAsync<_i12.SignMessageUseCase>()));
  return get;
}

class _$DatabaseModule extends _i16.DatabaseModule {}

class _$RepositoriesModule extends _i16.RepositoriesModule {}
