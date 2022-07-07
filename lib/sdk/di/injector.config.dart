// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/identity/data_sources/local_identity_data_source.dart'
    as _i5;
import '../../data/identity/mappers/private_key_mapper.dart' as _i4;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i6;
import '../../domain/identity/repositories/identity_repository.dart' as _i7;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i8;
import '../../libs/iden3corelib.dart' as _i3;
import '../identity_wallet.dart' as _i9;
import 'injector.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.Iden3CoreLib>(() => _i3.Iden3CoreLib());
  gh.factory<_i4.PrivateKeyMapper>(() => _i4.PrivateKeyMapper());
  gh.factory<_i5.WalletLibWrapper>(() => _i5.WalletLibWrapper());
  gh.factory<_i5.LocalIdentityDataSource>(() => _i5.LocalIdentityDataSource(
      get<_i3.Iden3CoreLib>(), get<_i5.WalletLibWrapper>()));
  gh.factory<_i6.IdentityRepositoryImpl>(() => _i6.IdentityRepositoryImpl(
      get<_i5.LocalIdentityDataSource>(), get<_i4.PrivateKeyMapper>()));
  gh.factory<_i7.IdentityRepository>(() =>
      repositoriesModule.identityRepository(get<_i6.IdentityRepositoryImpl>()));
  gh.factory<_i8.GetIdentityUseCase>(
      () => _i8.GetIdentityUseCase(get<_i7.IdentityRepository>()));
  gh.factory<_i9.IdentityWallet>(
      () => _i9.IdentityWallet(get<_i8.GetIdentityUseCase>()));
  return get;
}

class _$RepositoriesModule extends _i10.RepositoriesModule {}
