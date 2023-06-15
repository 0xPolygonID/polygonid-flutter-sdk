import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/set_env_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:polygonid_flutter_sdk/sdk/polygonid_flutter_channel.dart';

import 'credential.dart';
import 'iden3comm.dart';
import 'identity.dart';
import 'proof.dart';

class PolygonIsSdkNotInitializedException implements Exception {
  String message;

  PolygonIsSdkNotInitializedException(this.message);
}

class PolygonIdSdk {
  static PolygonIdSdk? _ref;

  static PolygonIdSdk get I {
    if (_ref == null) {
      throw PolygonIsSdkNotInitializedException(
          "The PolygonID SDK has not been initialized,"
          "please call and await PolygonIdSDK.init()");
    }

    return _ref!;
  }

  static Future<void> init({EnvEntity? env}) async {
    print("[PolygonIdSdk] init");
    // As [PolygonIdSdk] uses path_provider plugin, we need to ensure the
    // platform is initialized
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    // Init injection
    await configureInjection();
    await getItSdk.allReady();

    // get sure pathprovider is available
    try {
      final Directory tempDir = await getTemporaryDirectory();
      print("[PolygonIdSdk] tempDir: ${tempDir.path}");
    } catch (e) {
      print("[PolygonIdSdk] path provider not available with error: $e");
    }

    // Logging
    Domain.logger = getItSdk<PolygonIdSdkLogger>();
    print("[PolygonIdSdk] logger set");
    print("[PolygonIdSdk] ${Domain.logger.toString()} ${Domain.logEnabled}");
    Domain.logEnabled = true;

    print("[PolygonIdSdk] injection configured");

    // Set env
    if (env != null) {
      SetEnvUseCase setEnvUseCase = await getItSdk.getAsync<SetEnvUseCase>();
      print("[PolygonIdSdk] get async set env use case");
      setEnvUseCase.execute(param: env);
      print("[PolygonIdSdk] async env set");
    }

    print("[PolygonIdSdk] env set");

    // SDK singleton
    _ref = PolygonIdSdk._();
    _ref!.identity = await getItSdk.getAsync<Identity>();
    _ref!.credential = await getItSdk.getAsync<Credential>();
    _ref!.proof = await getItSdk.getAsync<Proof>();
    _ref!.iden3comm = await getItSdk.getAsync<Iden3comm>();

    print("[PolygonIdSdk] singletons set");

    // Channel
    getItSdk<PolygonIdFlutterChannel>();

    print("[PolygonIdSdk] channel set");

    print("[PolygonIdSdk] logging set");
  }

  late Identity identity;
  late Credential credential;
  late Proof proof;
  late Iden3comm iden3comm;

  PolygonIdSdk._();

  Future<void> setEnv({required EnvEntity env}) {
    return getItSdk
        .getAsync<SetEnvUseCase>()
        .then((instance) => instance.execute(param: env));
  }

  Future<EnvEntity> getEnv() {
    return getItSdk
        .getAsync<GetEnvUseCase>()
        .then((instance) => instance.execute());
  }

  Future<void> switchLog({required bool enabled}) async {
    Domain.logEnabled = enabled;
  }
}
