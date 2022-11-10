import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/repositories/env_config_repository_impl.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/utils/encrypt_sembast_codec.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/env/dev_env.dart';
import 'package:polygonid_flutter_sdk/env/prod_env.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../../common/data/repositories/package_info_repository_impl.dart';
import '../../common/domain/repositories/package_info_repository.dart';
import '../../credential/data/credential_repository_impl.dart';
import '../../credential/domain/repositories/credential_repository.dart';
import '../../env/sdk_env.dart';
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
abstract class Sdk {
  @lazySingleton
  SdkEnv get sdkEnv => kDebugMode ? DevEnv() : ProdEnv();
}

@module
abstract class PackageInfoModule {
  @lazySingleton
  Future<PackageInfo> get packageInfo async => PackageInfo.fromPlatform();
}

@module
abstract class NetworkModule {
  /// TODO: in the future we should change this client to something with more features
  /// like Dio: https://pub.dev/packages/dio
  Client get client => Client();

  Web3Client web3Client(SdkEnv sdkEnv) =>
      Web3Client(sdkEnv.infuraUrl + sdkEnv.infuraApiKey, client,
          socketConnector: () {
        return IOWebSocketChannel.connect(
                sdkEnv.infuraRdpUrl + sdkEnv.infuraApiKey)
            .cast<String>();
      });
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

  @Named(claimDatabaseName)
  Future<Database> claimDatabase(@factoryParam String? identifier,
      @factoryParam String? privateKey) async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, claimDatabasePrefix + identifier! + '.db');
    // Initialize the encryption codec with the privateKey
    var codec = getEncryptSembastCodec(password: privateKey!);
    final database = await databaseFactoryIo.openDatabase(path, codec: codec);
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
  // common
  ConfigRepository configRepository(
          ConfigRepositoryImpl configRepositoryImpl) =>
      configRepositoryImpl;

  PackageInfoRepository packageInfoRepository(
          PackageInfoRepositoryImpl packageInfoRepositoryImpl) =>
      packageInfoRepositoryImpl;

  // Identity
  IdentityRepository identityRepository(
          IdentityRepositoryImpl identityRepositoryImpl) =>
      identityRepositoryImpl;

  // Credential
  CredentialRepository credentialRepository(
          CredentialRepositoryImpl credentialRepositoryImpl) =>
      credentialRepositoryImpl;

  // Proof
  ProofRepository proofRepository(ProofRepositoryImpl proofRepositoryImpl) =>
      proofRepositoryImpl;

  // Iden3comm
  Iden3commRepository iden3commRepository(
          Iden3commRepositoryImpl iden3commRepositoryImpl) =>
      iden3commRepositoryImpl;
}
