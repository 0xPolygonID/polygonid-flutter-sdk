// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:polygonid_flutter_sdk/data/data_sources/local_identity_data_source.dart'
    as _i3;
import 'package:polygonid_flutter_sdk/data/repositories/identity_repository_impl.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/domain/repositories/identity_repository.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/domain/use_cases/get_identity_use_case.dart'
    as _i6;
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final coreModule = _$CoreModule();
  final repositoriesModule = _$RepositoriesModule();
  gh.lazySingleton<_i1.GetIt>(() => coreModule.getIt);
  gh.factory<_i3.LibWrapper>(() => _i3.LibWrapper());
  gh.factory<_i3.LocalIdentityDataSource>(
      () => _i3.LocalIdentityDataSource(get<_i3.LibWrapper>()));
  gh.factory<_i4.IdentityRepositoryImpl>(
      () => _i4.IdentityRepositoryImpl(get<_i3.LocalIdentityDataSource>()));
  gh.factory<_i5.IdentityRepository>(() =>
      repositoriesModule.identityRepository(get<_i4.IdentityRepositoryImpl>()));
  gh.factory<_i6.GetIdentityUseCase>(
      () => _i6.GetIdentityUseCase(get<_i5.IdentityRepository>()));
  return get;
}

class _$CoreModule extends _i7.CoreModule {}

class _$RepositoriesModule extends _i7.RepositoriesModule {}
