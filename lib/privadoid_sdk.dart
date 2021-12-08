import 'dart:async';

import 'package:flutter/services.dart';
import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/hex_utils.dart';

class PrivadoIdSdk {
  static const MethodChannel _channel = MethodChannel('privadoid_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> createNewIdentity() async {
    final PrivadoIdWallet wallet =
        await PrivadoIdWallet.createPrivadoIdWallet(null);
    HexUtils.hexToBytes(wallet.publicKeyHex[0]);
    final String? version = await _channel.invokeMethod(
        'createNewIdentity', [wallet.publicKeyHex[0], wallet.publicKeyHex[1]]);
    return version;
  }
}
