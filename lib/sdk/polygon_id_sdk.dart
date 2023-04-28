import 'package:flutter/cupertino.dart';
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
    // As [PolygonIdSdk] uses path_provider plugin, we need to ensure the
    // platform is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Init injection
    await configureInjection();
    await getItSdk.allReady();

    // Set env
    if (env != null) {
      await getItSdk
          .getAsync<SetEnvUseCase>()
          .then((instance) => instance.execute(param: env));
    }

    // SDK singleton
    _ref = PolygonIdSdk._();
    _ref!.identity = await getItSdk.getAsync<Identity>();
    _ref!.credential = await getItSdk.getAsync<Credential>();
    _ref!.proof = await getItSdk.getAsync<Proof>();
    _ref!.iden3comm = await getItSdk.getAsync<Iden3comm>();

    // Channel
    getItSdk<PolygonIdFlutterChannel>();
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
}
