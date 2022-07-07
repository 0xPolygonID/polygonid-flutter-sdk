import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/data/identity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';

import 'injector.config.dart';

final getItSdk = GetIt.asNewInstance();

@InjectableInit(
  initializerName: r'$initSDKGetIt',
)
void configureInjection() => $initSDKGetIt(getItSdk);

@module
abstract class RepositoriesModule {
  IdentityRepository identityRepository(
          IdentityRepositoryImpl identityRepositoryImpl) =>
      identityRepositoryImpl;
}
