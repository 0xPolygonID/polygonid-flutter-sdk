import 'package:get_it/get_it.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk_example/src/data/credential/data_sources/polygonid_sdk_credential_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/data/credential/repositories/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk_example/src/data/iden3comm/data_sources/polygonid_sdk_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/data/iden3comm/repositories/iden3comm_repository_impl.dart';
import 'package:polygonid_flutter_sdk_example/src/data/identitity/data_sources/polygonid_sdk_identity_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/data/identitity/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/use_cases/fetch_and_saves_claims_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/iden3comm/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/iden3comm/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/auth/auth_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claim_detail/bloc/claim_detail_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/claim_model_state_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/mappers/proof_model_type_mapper.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/home/home_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/splash/splash_bloc.dart';

final getIt = GetIt.instance;

/// Dependency Injection initializer
Future<void> init() async {
  await registerProviders();
  registerSplashDependencies();
  registerHomeDependencies();
  registerClaimDetailDependencies();
  registerClaimsDependencies();
  registerIdentityDependencies();
  registerAuthDependencies();
  registerMappers();
}

///
Future<void> registerProviders() async {
  await PolygonIdSdk.init();
  getIt.registerLazySingleton<PolygonIdSdk>(() => PolygonIdSdk.I);
}

///
void registerIdentityDependencies() {
  getIt.registerFactory<PolygonIdSdkIdentityDataSource>(
      () => PolygonIdSdkIdentityDataSource(getIt()));
  getIt.registerLazySingleton<IdentityRepository>(
      () => IdentityRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetIdentifierUseCase>(
      () => GetIdentifierUseCase(getIt()));
  getIt.registerLazySingleton<CreateIdentityUseCase>(
      () => CreateIdentityUseCase(getIt()));
}

///
void registerSplashDependencies() {
  getIt.registerFactory(() => SplashBloc());
}

///
void registerHomeDependencies() {
  getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
}

///
void registerClaimsDependencies() {
  getIt.registerFactory(() => ClaimsBloc(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<PolygonSdkCredentialDataSource>(
      () => PolygonSdkCredentialDataSource(getIt()));
  getIt.registerLazySingleton<CredentialRepository>(
      () => CredentialRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FetchAndSavesClaimsUseCase>(
      () => FetchAndSavesClaimsUseCase(getIt()));
}

///
void registerClaimDetailDependencies() {
  getIt.registerFactory(() => ClaimDetailBloc(getIt()));
}

///
void registerAuthDependencies() {
  getIt.registerFactory<PolygonIdSdkIden3CommDataSource>(
      () => PolygonIdSdkIden3CommDataSource(getIt()));
  getIt.registerLazySingleton<Iden3CommRepository>(
      () => Iden3CommRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => AuthenticateUseCase(getIt()));
  getIt.registerFactory(() => AuthBloc(getIt(), getIt()));
}

///
void registerMappers() {
  getIt.registerFactory(() => ClaimModelMapper(getIt(), getIt()));
  getIt.registerFactory(() => ClaimModelStateMapper());
  getIt.registerFactory(() => ProofModelTypeMapper());
}
