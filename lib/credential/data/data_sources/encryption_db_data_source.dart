import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:web3dart/crypto.dart';

class EncryptionDbDataSource {
  /// Decrypt the given [encryptedData] using the given [privateKey]
  /// Returns the decrypted data as Map<String, Object>
  Map<String, Object?> decryptData(
      {required String encryptedData, required String privateKey}) {
    final iv = IV.fromLength(16);
    final key = Key.fromBase16(privateKey);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);

    Map<String, Object?> decryptedDbMap = jsonDecode(decrypted);
    return decryptedDbMap;
  }

  /// Encrypt the given [data] using the given [privateKey]
  /// Returns the encrypted data as String
  String encryptData(
      {required Map<String, Object?> data, required String privateKey}) {
    String json = jsonEncode(data);
    Uint8List uint8list = hexToBytes(privateKey);
    final iv = IV.fromLength(16);
    final key = Key.fromBase16(privateKey);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(json, iv: iv);

    return encrypted.base64;
  }
}
