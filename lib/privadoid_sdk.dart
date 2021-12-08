import 'dart:async';
import 'dart:typed_data';

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
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        HexUtils.hexToBytes(
            "21a5e7321d0e2f3ca1cc6504396e6594a2211544b08c206847cdee96f832421a"));
    Uint8List bytes = HexUtils.hexToBytes(wallet.publicKeyHex[0]);
    final String? version = await _channel.invokeMethod(
        'createNewIdentity', [wallet.publicKeyHex[0], wallet.publicKeyHex[1]]);
    return version;
  }
}
