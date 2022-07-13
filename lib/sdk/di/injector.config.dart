// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/identity/data_sources/local_identity_data_source.dart'
    as _i6;
import '../../data/identity/mappers/hex_mapper.dart' as _i3;
import '../../data/identity/mappers/private_key_mapper.dart' as _i5;
import '../../data/identity/repositories/identity_repository_impl.dart' as _i7;
import '../../domain/identity/repositories/identity_repository.dart' as _i8;
import '../../domain/identity/use_cases/get_identity_use_case.dart' as _i10;
import '../../domain/identity/use_cases/sign_message_use_case.dart' as _i9;
import '../../libs/iden3corelib.dart' as _i4;
import '../identity_wallet.dart' as _i11;
import 'injector.dart' as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSDKGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final repositoriesModule = _$RepositoriesModule();
  gh.factory<_i3.HexMapper>(() => _i3.HexMapper());
  gh.factory<_i4.Iden3CoreLib>(() => _i4.Iden3CoreLib());
  gh.factory<_i5.PrivateKeyMapper>(() => _i5.PrivateKeyMapper());
  gh.factory<_i6.WalletLibWrapper>(() => _i6.WalletLibWrapper());
  gh.factory<_i6.LocalIdentityDataSource>(() => _i6.LocalIdentityDataSource(
      get<_i4.Iden3CoreLib>(), get<_i6.WalletLibWrapper>()));
  gh.factory<_i7.IdentityRepositoryImpl>(() => _i7.IdentityRepositoryImpl(
      get<_i6.LocalIdentityDataSource>(),
      get<_i3.HexMapper>(),
      get<_i5.PrivateKeyMapper>()));
  gh.factory<_i8.IdentityRepository>(() =>
      repositoriesModule.identityRepository(get<_i7.IdentityRepositoryImpl>()));
  gh.factory<_i9.SignMessageUseCase>(
      () => _i9.SignMessageUseCase(get<_i8.IdentityRepository>()));
  gh.factory<_i10.GetIdentityUseCase>(
      () => _i10.GetIdentityUseCase(get<_i8.IdentityRepository>()));
  gh.factory<_i11.IdentityWallet>(() => _i11.IdentityWallet(
      get<_i10.GetIdentityUseCase>(), get<_i9.SignMessageUseCase>()));
  return get;
}

class _$RepositoriesModule extends _i12.RepositoriesModule {}
