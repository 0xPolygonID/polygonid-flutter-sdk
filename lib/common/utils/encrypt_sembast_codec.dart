import 'dart:convert';

import 'package:sembast/sembast.dart';
import 'package:polygonid_flutter_sdk/common/crypto/symmetric.dart';

enum EncryptType { aes }

class _EncryptEncoder extends Converter<Map<String, dynamic>, String> {
  final String key;
  final EncryptType signature;

  _EncryptEncoder(this.key, this.signature);

  @override
  String convert(Map<String, dynamic> input) {
    switch (signature) {
      case EncryptType.aes:
        final cipher = AesCipher(SymmetricKey.fromUtf8(key));
        final encrypted = cipher.encrypt(json.encode(input),
            iv: SymmetricIV.zeros(16));
        return encrypted.base64;
    }
  }
}

class _EncryptDecoder extends Converter<String, Map<String, dynamic>> {
  final String key;
  final EncryptType signature;

  _EncryptDecoder(this.key, this.signature);

  @override
  Map<String, dynamic> convert(String input) {
    switch (signature) {
      case EncryptType.aes:
        final cipher = AesCipher(SymmetricKey.fromUtf8(key));
        final decryptedStr =
            cipher.decryptBase64(input, iv: SymmetricIV.zeros(16));
        final decoded = json.decode(decryptedStr);
        if (decoded is Map) {
          return decoded.cast<String, dynamic>();
        }
        throw FormatException('invalid input $input');
    }
  }
}

class _EncryptCodec extends Codec<Map<String, dynamic>, String> {
  final EncryptType signature;
  late _EncryptEncoder _encoder;
  late _EncryptDecoder _decoder;

  _EncryptCodec(String password, this.signature) {
    _encoder = _EncryptEncoder(password, signature);
    _decoder = _EncryptDecoder(password, signature);
  }

  @override
  Converter<String, Map<String, dynamic>> get decoder => _decoder;

  @override
  Converter<Map<String, dynamic>, String> get encoder => _encoder;
}

SembastCodec getEncryptSembastCodec({
  required String encryptionKey,
  EncryptType signature = EncryptType.aes,
}) {
  return SembastCodec(
    signature: signature.toString(),
    codec: _EncryptCodec(encryptionKey, signature),
  );
}
