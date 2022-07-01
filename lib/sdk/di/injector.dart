import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/repositories/identity_repository.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initSDKGetIt',
)
void configureInjection() => $initSDKGetIt(getIt);

@module
abstract class CoreModule {
  @lazySingleton
  GetIt get getIt => GetIt.instance;
}

@module
abstract class RepositoriesModule {
  IdentityRepository identityRepository(
          IdentityRepositoryImpl identityRepositoryImpl) =>
      identityRepositoryImpl;
}
