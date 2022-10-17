import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../credential/data/credential_repository_impl.dart';
import '../../credential/domain/repositories/credential_repository.dart';
import '../../iden3comm/data/repositories/iden3comm_repository_impl.dart';
import '../../iden3comm/domain/repositories/iden3comm_repository.dart';
import '../../identity/data/repositories/identity_repository_impl.dart';
import '../../identity/domain/repositories/identity_repository.dart';
import '../../proof_generation/data/repositories/proof_repository_impl.dart';
import '../../proof_generation/domain/repositories/proof_repository.dart';
import 'injector.config.dart';

final getItSdk = GetIt.asNewInstance();

@InjectableInit(
  initializerName: r'$initSDKGetIt',
)
configureInjection() => $initSDKGetIt(getItSdk);

@module
abstract class NetworkModule {
  /// TODO: in the future we should change this client to something with more features
  /// like Dio: https://pub.dev/packages/dio
  Client get client => Client();
}

@module
abstract class DatabaseModule {
  @lazySingleton
  Future<Database> database() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, databaseName);
    final database = await databaseFactoryIo.openDatabase(path);

    return database;
  }

  @Named(identityStoreName)
  StoreRef<String, Map<String, Object?>> get identityStore =>
      stringMapStoreFactory.store(identityStoreName);

  @Named(claimStoreName)
  StoreRef<String, Map<String, Object?>> get claimStore =>
      stringMapStoreFactory.store(claimStoreName);

  @Named(keyValueStoreName)
  StoreRef<String, dynamic> get keyValueStore =>
      stringMapStoreFactory.store(keyValueStoreName);
}

@module
abstract class RepositoriesModule {
  IdentityRepository identityRepository(
          IdentityRepositoryImpl identityRepositoryImpl) =>
      identityRepositoryImpl;

  CredentialRepository credentialRepository(
          CredentialRepositoryImpl credentialRepositoryImpl) =>
      credentialRepositoryImpl;

  ProofRepository proofRepository(ProofRepositoryImpl proofRepositoryImpl) =>
      proofRepositoryImpl;

  Iden3commRepository iden3commRepository(
          Iden3commRepositoryImpl iden3commRepositoryImpl) =>
      iden3commRepositoryImpl;
}
