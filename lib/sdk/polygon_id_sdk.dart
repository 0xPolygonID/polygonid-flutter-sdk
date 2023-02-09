import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'credential.dart';
import 'iden3comm.dart';
import 'identity.dart';
import 'proof.dart';
import 'package:http/http.dart' as http;

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

  static Future<void> init() async {
    // As [PolygonIdSdk] uses path_provider plugin, we need to ensure the
    // platform is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Init injection
    configureInjection();
    await getItSdk.allReady();

    // SDK singleton
    _ref = PolygonIdSdk._();
    _ref!.identity = await getItSdk.getAsync<Identity>();
    _ref!.credential = await getItSdk.getAsync<Credential>();
    _ref!.proof = await getItSdk.getAsync<Proof>();
    _ref!.iden3comm = await getItSdk.getAsync<Iden3comm>();
  }

  late Identity identity;
  late Credential credential;
  late Proof proof;
  late Iden3comm iden3comm;

  PolygonIdSdk._();
}
