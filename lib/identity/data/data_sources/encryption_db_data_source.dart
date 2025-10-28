import 'dart:convert';

import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:polygonid_flutter_sdk/common/crypto/symmetric.dart';

class EncryptionDbDataSource {
  /// Decrypt the given [encryptedData] using the given [key] and [iv]
  /// Returns the decrypted data as Map<String, Object>
  Map<String, Object?> decryptData({
    required String encryptedData,
    required SymmetricKey key,
  }) {
    final cipher = getItSdk.get<AesCipher>(
      instanceName: 'encryptAES',
      param1: key,
    );
    final decrypted = cipher.decryptBase64(encryptedData, iv: SymmetricIV.zeros(16));
    Map<String, Object?> decryptedDbMap = jsonDecode(decrypted);
    return decryptedDbMap;
  }

  /// Encrypt the given [data] using the given [key] and [iv]
  /// Returns the encrypted data as String
  String encryptData({
    required Map<String, Object?> data,
    required SymmetricKey key,
  }) {
    String json = jsonEncode(data);
    final cipher = getItSdk.get<AesCipher>(
      instanceName: 'encryptAES',
      param1: key,
    );
    final encrypted = cipher.encrypt(json, iv: SymmetricIV.zeros(16));
    return encrypted.base64;
  }
}
