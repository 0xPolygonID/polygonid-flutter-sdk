import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/data/repositories/config_repository_impl.dart';
import 'package:polygonid_flutter_sdk/common/data/repositories/package_info_repository_impl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/package_info_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/utils/encrypt_sembast_codec.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/did_profile_info_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/iden3comm_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/repositories/interaction_repository_impl.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/identity_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/data/repositories/smt_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/proof/data/repositories/proof_repository_impl.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/sdk/default_logger.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.config.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

final getItSdk = GetIt.asNewInstance();

@InjectableInit(
  initializerName: r'$initSDKGetIt',
)
configureInjection() => getItSdk.$initSDKGetIt();

/// Logger
@module
abstract class LoggerModule {
  Logger get logger => Logger();

  PolygonIdSdkLogger get sdkLogger => DefaultLogger(logger);
}

/// Channels
@module
abstract class ChannelModule {
  PolygonIdSdk get polygonIdSdk => PolygonIdSdk.I;

  @lazySingleton
  MethodChannel get methodChannel => const MethodChannel(CHANNEL_NAME);
}

@module
abstract class PlatformModule {
  @lazySingleton
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}

@module
abstract class NetworkModule {
  /// TODO: in the future we should change this client to something with more features
  /// like Dio: https://pub.dev/packages/dio
  Client get client => Client();

  Dio get dio => Dio();

  Web3Client web3client(@factoryParam EnvEntity env) {
    return Web3Client(env.web3Url + env.web3ApiKey, client,
        socketConnector: () {
      return IOWebSocketChannel.connect(env.web3RdpUrl + env.web3ApiKey)
          .cast<String>();
    });
  }
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

  @Named(identityDatabaseName)
  Future<Database> identityDatabase(@factoryParam String? identifier,
      @factoryParam String? privateKey) async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, identityDatabasePrefix + identifier! + '.db');
    // Initialize the encryption codec with the privateKey
    final codec = getItSdk.get<SembastCodec>(param1: privateKey!);
    final database = await databaseFactoryIo.openDatabase(path, codec: codec);
    return database;
  }

  SembastCodec getCodec(@factoryParam String privateKey) {
    return getEncryptSembastCodec(password: privateKey);
  }

  // Identity
  @Named(identityStoreName)
  StoreRef<String, Map<String, Object?>> get identityStore =>
      stringMapStoreFactory.store(identityStoreName);

  /// FIXME: inject store separately (need DS fixing)
  @Named(identityStateStoreName)
  Map<String, StoreRef<String, Map<String, Object?>>> get identityStateStore {
    Map<String, StoreRef<String, Map<String, Object?>>> result = {};
    result[claimsTreeStoreName] =
        stringMapStoreFactory.store(claimsTreeStoreName);
    result[revocationTreeStoreName] =
        stringMapStoreFactory.store(revocationTreeStoreName);
    result[rootsTreeStoreName] =
        stringMapStoreFactory.store(rootsTreeStoreName);
    return result;
  }

  @Named(keyValueStoreName)
  StoreRef<String, dynamic> get keyValueStore =>
      stringMapStoreFactory.store(keyValueStoreName);

  @Named(claimStoreName)
  StoreRef<String, Map<String, Object?>> get claimStore =>
      stringMapStoreFactory.store(claimStoreName);

  @Named(interactionStoreName)
  StoreRef<String, Map<String, Object?>> get interactionStore =>
      stringMapStoreFactory.store(interactionStoreName);

  @Named(didProfileInfoStoreName)
  StoreRef<String, Map<String, Object?>> get didProfileInfoStore =>
      stringMapStoreFactory.store(didProfileInfoStoreName);

  @Named(profilesStoreName)
  StoreRef<String, Map<String, Object?>> get profileStore =>
      stringMapStoreFactory.store(profilesStoreName);
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
  Iden3commCredentialRepository iden3commCredentialRepository(
          Iden3commCredentialRepositoryImpl
              iden3commCredentialRepositoryImpl) =>
      iden3commCredentialRepositoryImpl;

  Iden3commRepository iden3commRepository(
          Iden3commRepositoryImpl iden3commRepositoryImpl) =>
      iden3commRepositoryImpl;

  InteractionRepository interactionRepository(
          InteractionRepositoryImpl interactionRepositoryImpl) =>
      interactionRepositoryImpl;

  DidProfileInfoRepository didProfileInfoRepository(
          DidProfileInfoRepositoryImpl didProfileInfoRepositoryImpl) =>
      didProfileInfoRepositoryImpl;

  // SMT
  SMTRepository smtRepository(SMTRepositoryImpl smtRepositoryImpl) =>
      smtRepositoryImpl;
}

@module
abstract class EncryptionModule {
  @Named('encryptAES')
  @factoryMethod
  encrypt.Encrypter encryptAES(@factoryParam encrypt.Key key) {
    return encrypt.Encrypter(encrypt.AES(key));
  }
}

@module
abstract class FilesManagerModule {
  @factoryMethod
  ZipDecoder zipDecoder() {
    return ZipDecoder();
  }

  Future<Directory> get applicationDocumentsDirectory async =>
      await getApplicationDocumentsDirectory();
}
