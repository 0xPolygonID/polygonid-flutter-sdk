import 'package:get_it/get_it.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/identitity/data_sources/polygonid_sdk_identity_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/data/identitity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/home/home_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/splash/splash_bloc.dart';

final getIt = GetIt.instance;

/// Dependency Injection initializer
Future<void> init() async {
  await registerProviders();
  registerSplashDependencies();
  registerHomeDependencies();
  registerIdentityDependencies();
}

///
Future<void> registerProviders() async {
  await PolygonIdSdk.init();
  getIt.registerLazySingleton<PolygonIdSdk>(() => PolygonIdSdk.I);
}

///
void registerIdentityDependencies() {
  getIt.registerFactory<PolygonIdSdkIdentityDataSource>(() => PolygonIdSdkIdentityDataSource(getIt()));
  getIt.registerLazySingleton<IdentityRepository>(() => IdentityRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetIdentifierUseCase>(() => GetIdentifierUseCase(getIt()));
  getIt.registerLazySingleton<CreateIdentityUseCase>(() => CreateIdentityUseCase(getIt()));
}

///
void registerSplashDependencies() {
  getIt.registerFactory(() => SplashBloc());
}

///
void registerHomeDependencies() {
  getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
}
