// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/identity/data_sources/local_identity_data_source.dart'
    as _i4;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i5;
import '../../domain/identity/repositories/identity_repository.dart' as _i6;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i7;
import '../../libs/iden3corelib.dart' as _i3;
import '../identity_wallet.dart' as _i8;
import 'injector.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final coreModule = _$CoreModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i1.GetIt>(() => coreModule.getIt);
  gh.factory<_i3.Iden3CoreLib>(() => _i3.Iden3CoreLib());
  gh.factory<_i4.WalletLibWrapper>(() => _i4.WalletLibWrapper());
  gh.factory<_i4.LocalIdentityDataSource>(() => _i4.LocalIdentityDataSource(
      get<_i3.Iden3CoreLib>(), get<_i4.WalletLibWrapper>()));
  gh.factory<_i5.IdentityRepositoryImpl>(
      () => _i5.IdentityRepositoryImpl(get<_i4.LocalIdentityDataSource>()));
  gh.factory<_i6.IdentityRepository>(() =>
      repositoriesModule.identityRepository(get<_i5.IdentityRepositoryImpl>()));
  gh.factory<_i7.GetIdentityUseCase>(
      () => _i7.GetIdentityUseCase(get<_i6.IdentityRepository>()));
  gh.factory<_i8.IdentityWallet>(
      () => _i8.IdentityWallet(get<_i7.GetIdentityUseCase>()));
  return get;
}

class _$CoreModule extends _i9.CoreModule {}

class _$RepositoriesModule extends _i9.RepositoriesModule {}
