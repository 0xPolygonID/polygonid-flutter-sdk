import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class EncryptionDbDataSource {
  /// Decrypt the given [encryptedData] using the given [key] and [iv]
  /// Returns the decrypted data as Map<String, Object>
  Map<String, Object?> decryptData({
    required String encryptedData,
    required Key key,
    required IV iv,
  }) {
    final encrypter = getItSdk.get<Encrypter>(
      instanceName: 'encryptAES',
      param1: key,
    );

    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);

    Map<String, Object?> decryptedDbMap = jsonDecode(decrypted);
    return decryptedDbMap;
  }

  /// Encrypt the given [data] using the given [key] and [iv]
  /// Returns the encrypted data as String
  String encryptData({
    required Map<String, Object?> data,
    required Key key,
    required IV iv,
  }) {
    String json = jsonEncode(data);

    final encrypter = getItSdk.get<Encrypter>(
      instanceName: 'encryptAES',
      param1: key,
    );

    final encrypted = encrypter.encrypt(json, iv: iv);

    return encrypted.base64;
  }
}
