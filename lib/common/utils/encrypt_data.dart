import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class EncryptData {
  static String encryptAES(String plainText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static String decryptAES(String base64EncryptedText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final encrypted = Encrypted(base64Decode(base64EncryptedText));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static String encryptFernet(String plainText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final iv = IV.fromLength(16);
    final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);
    return encrypter.encrypt(plainText, iv: iv).base64;
    //print(fernetEncrypted!.base64); // random cipher text
    //print(fernet.extractTimestamp(fernetEncrypted!.bytes));
  }

  static String decryptFernet(String base64EncryptedText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
    final fernet = Fernet(b64key);
    final encrypted = Encrypted(base64Decode(base64EncryptedText));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(fernet);
    return encrypter.decrypt(encrypted, iv: iv);
    //print(fernetDecrypted);
  }

  static String encryptSalsa20(String plainText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final iv = IV.fromLength(8);
    final salsa20 = Salsa20(key);
    final encrypter = Encrypter(salsa20);
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static String decryptSalsa20(String base64EncryptedText, String privateKey) {
    final key = Key.fromUtf8(privateKey);
    final encrypted = Encrypted(base64Decode(base64EncryptedText));
    final iv = IV.fromLength(8);
    final salsa20 = Salsa20(key);
    final encrypter = Encrypter(salsa20);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
