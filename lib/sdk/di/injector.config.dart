// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i4;

import '../../data/identity/data_sources/jwz_data_source.dart' as _i8;
import '../../data/identity/data_sources/lib_identity_data_source.dart' as _i9;
import '../../data/identity/data_sources/storage_identity_data_source.dart'
    as _i12;
import '../../data/identity/data_sources/storage_key_value_data_source.dart'
    as _i13;
import '../../data/identity/data_sources/wallet_data_source.dart' as _i11;
import '../../data/identity/mappers/hex_mapper.dart' as _i5;
import '../../data/identity/mappers/identity_dto_mapper.dart' as _i7;
import '../../data/identity/mappers/private_key_mapper.dart' as _i10;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i14;
import '../../domain/identity/repositories/identity_repository.dart' as _i15;
import '../../domain/identity/use_cases/create_identity_use_case.dart' as _i18;
import '../../domain/identity/use_cases/get_auth_token_use_case.dart' as _i19;
import '../../domain/identity/use_cases/get_current_identifier_use_case.dart'
    as _i20;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i21;
import '../../domain/identity/use_cases/remove_current_identity_use_case.dart'
    as _i16;
import '../../domain/identity/use_cases/sign_message_use_case.dart' as _i17;
import '../../libs/circomlib.dart' as _i3;
import '../../libs/iden3corelib.dart' as _i6;
import '../identity_wallet.dart' as _i22;
import 'injector.dart' as _i23; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.IdentityDTOMapper>(() => _i7.IdentityDTOMapper());
  gh.factory<_i8.JWZIsolatesWrapper>(() => _i8.JWZIsolatesWrapper());
  gh.factory<_i9.LibIdentityDataSource>(
      () => _i9.LibIdentityDataSource(get<_i6.Iden3CoreLib>()));
  gh.factory<_i10.PrivateKeyMapper>(() => _i10.PrivateKeyMapper());
  gh.factory<_i4.StoreRef<String, Map<String, Object?>>>(
      () => databaseModule.identityStore,
      instanceName: 'identityStore');
  gh.factory<_i4.StoreRef<String, dynamic>>(() => databaseModule.keyValueStore,
      instanceName: 'keyValueStore');
  gh.factory<_i11.WalletLibWrapper>(() => _i11.WalletLibWrapper());
  gh.factory<_i12.IdentityStoreRefWrapper>(() => _i12.IdentityStoreRefWrapper(
      get<_i4.StoreRef<String, Map<String, Object?>>>(
          instanceName: 'identityStore')));
  gh.factory<_i13.KeyValueStoreRefWrapper>(() => _i13.KeyValueStoreRefWrapper(
      get<_i4.StoreRef<String, dynamic>>(instanceName: 'keyValueStore')));
  gh.factoryAsync<_i13.StorageKeyValueDataSource>(() async =>
      _i13.StorageKeyValueDataSource(await get.getAsync<_i4.Database>(),
          get<_i13.KeyValueStoreRefWrapper>()));
  gh.factory<_i11.WalletDataSource>(
      () => _i11.WalletDataSource(get<_i11.WalletLibWrapper>()));
  gh.factory<_i8.JWZDataSource>(() => _i8.JWZDataSource(get<_i3.CircomLib>(),
      get<_i11.WalletDataSource>(), get<_i8.JWZIsolatesWrapper>()));
  gh.factoryAsync<_i12.StorageIdentityDataSource>(() async =>
      _i12.StorageIdentityDataSource(
          await get.getAsync<_i4.Database>(),
          get<_i12.IdentityStoreRefWrapper>(),
          await get.getAsync<_i13.StorageKeyValueDataSource>()));
  gh.factoryAsync<_i14.IdentityRepositoryImpl>(() async =>
      _i14.IdentityRepositoryImpl(
          get<_i11.WalletDataSource>(),
          get<_i9.LibIdentityDataSource>(),
          await get.getAsync<_i12.StorageIdentityDataSource>(),
          await get.getAsync<_i13.StorageKeyValueDataSource>(),
          get<_i8.JWZDataSource>(),
          get<_i5.HexMapper>(),
          get<_i10.PrivateKeyMapper>(),
          get<_i7.IdentityDTOMapper>()));
  gh.factoryAsync<_i15.IdentityRepository>(() async => repositoriesModule
      .identityRepository(await get.getAsync<_i14.IdentityRepositoryImpl>()));
  gh.factoryAsync<_i16.RemoveCurrentIdentityUseCase>(() async =>
      _i16.RemoveCurrentIdentityUseCase(
          await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i17.SignMessageUseCase>(() async =>
      _i17.SignMessageUseCase(await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i18.CreateIdentityUseCase>(() async =>
      _i18.CreateIdentityUseCase(
          await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i19.GetAuthTokenUseCase>(() async =>
      _i19.GetAuthTokenUseCase(await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i20.GetCurrentIdentifierUseCase>(() async =>
      _i20.GetCurrentIdentifierUseCase(
          await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i21.GetIdentityUseCase>(() async =>
      _i21.GetIdentityUseCase(await get.getAsync<_i15.IdentityRepository>()));
  gh.factoryAsync<_i22.IdentityWallet>(() async => _i22.IdentityWallet(
      await get.getAsync<_i18.CreateIdentityUseCase>(),
      await get.getAsync<_i21.GetIdentityUseCase>(),
      await get.getAsync<_i17.SignMessageUseCase>(),
      await get.getAsync<_i19.GetAuthTokenUseCase>(),
      await get.getAsync<_i20.GetCurrentIdentifierUseCase>(),
      await get.getAsync<_i16.RemoveCurrentIdentityUseCase>()));
  return get;
}

class _$DatabaseModule extends _i23.DatabaseModule {}

class _$RepositoriesModule extends _i23.RepositoriesModule {}
