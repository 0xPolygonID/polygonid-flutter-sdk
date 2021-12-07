import 'dart:async';

import 'package:flutter/services.dart';

class PrivadoIdSdk {
  static const MethodChannel _channel = MethodChannel('privadoid_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> newClaim(String pubX, String pubY) async {
    final String? version =
        await _channel.invokeMethod('generateNewClaim', [pubX, pubY]);
    return version;
  }
}
