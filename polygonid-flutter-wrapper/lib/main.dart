import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

MethodChannel _methodChannel =
    const MethodChannel("technology.polygon.polygonid_flutter_wrapper");

void main() {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<String> yep() async {
  await Future.delayed(const Duration(seconds: 1));

  return 'Data from Flutter';
}

void initChannel() {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  print("initChannel");

  _methodChannel.setMethodCallHandler((call) {
    switch (call.method) {
      case "init":
        print("Init channel");
        return init(call.arguments);
      case "yep":
        try {
          print("Yep channel");
          return yep();
        } catch (error) {
          // Handle any errors that occur during the asynchronous operation
          return Future.error('An error occurred');
        }
      default:
        print("Missing from wrapper channel");
        throw PlatformException(
            code: 'not_implemented',
            message: 'Method ${call.method} not implemented');
    }
  });
}

/// Initialize the Flutter SDK wrapper
/// This method is called from the native side
Future<void> init(List? args) {
  WidgetsFlutterBinding.ensureInitialized();

  print("Main init");

  print("args: ${args?[0]}");

  return PolygonIdSdk.init(
      env: args != null && args.isNotEmpty
          ? EnvEntity.fromJson(jsonDecode(args[0]))
          : null);
}
