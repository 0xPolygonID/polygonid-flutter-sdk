import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class SymmetricKey {
  final Uint8List bytes;

  SymmetricKey(this.bytes);

  factory SymmetricKey.fromUtf8(String s) =>
      SymmetricKey(Uint8List.fromList(utf8.encode(s)));

  factory SymmetricKey.fromBase16(String hex) => SymmetricKey(_hexToBytes(hex));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SymmetricKey) return false;
    final a = bytes;
    final b = other.bytes;
    if (a.length != b.length) return false;
    // Constant-time comparison to avoid timing attacks.
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }

  @override
  int get hashCode {
    // Deterministic hash based on contents (similar mixing strategy to ListBase).
    final a = bytes;
    var h = 0;
    for (var i = 0; i < a.length; i++) {
      h = 0x1fffffff & (h + a[i]);
      h = 0x1fffffff & (h + ((h & 0x0007ffff) << 10));
      h ^= (h >> 6);
    }
    h = 0x1fffffff & (h + ((h & 0x03ffffff) << 3));
    h ^= (h >> 11);
    h = 0x1fffffff & (h + ((h & 0x00003ffff) << 15));
    return h;
  }
}

class SymmetricIV {
  final Uint8List bytes;

  SymmetricIV(this.bytes);

  factory SymmetricIV.zeros(int length) => SymmetricIV(Uint8List(length));
}

class SymmetricEncrypted {
  final Uint8List bytes;

  SymmetricEncrypted(this.bytes);

  String get base64 => base64Encode(bytes);
}

Uint8List _hexToBytes(String hex) {
  final clean = hex.startsWith('0x') ? hex.substring(2) : hex;
  final len = clean.length;
  final result = Uint8List(len ~/ 2);
  for (int i = 0; i < len; i += 2) {
    result[i ~/ 2] = int.parse(clean.substring(i, i + 2), radix: 16);
  }
  return result;
}

class AesCipher {
  final SymmetricKey key;

  AesCipher(this.key);

  // AES-CBC with PKCS7 padding (to mimic encrypt package default)
  SymmetricEncrypted encrypt(String plaintext, {required SymmetricIV iv}) {
    final padded = _pkcs7Pad(Uint8List.fromList(utf8.encode(plaintext)), 16);
    final cbc = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(key.bytes), iv.bytes));
    final out = Uint8List(padded.length);
    var offset = 0;
    while (offset < padded.length) {
      cbc.processBlock(padded, offset, out, offset);
      offset += cbc.blockSize;
    }
    return SymmetricEncrypted(out);
  }

  String decryptBase64(String ciphertextBase64, {required SymmetricIV iv}) {
    final cipherBytes = base64Decode(ciphertextBase64);
    final cbc = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(key.bytes), iv.bytes));
    final out = Uint8List(cipherBytes.length);
    var offset = 0;
    while (offset < cipherBytes.length) {
      cbc.processBlock(cipherBytes, offset, out, offset);
      offset += cbc.blockSize;
    }
    final unpadded = _pkcs7Unpad(out);
    return utf8.decode(unpadded);
  }
}

Uint8List _pkcs7Pad(Uint8List data, int blockSize) {
  final padLen = blockSize - (data.length % blockSize);
  final result = Uint8List(data.length + padLen)
    ..setRange(0, data.length, data);
  for (int i = data.length; i < result.length; i++) {
    result[i] = padLen;
  }
  return result;
}

Uint8List _pkcs7Unpad(Uint8List data) {
  if (data.isEmpty) return data;
  final padLen = data.last;
  return data.sublist(0, data.length - padLen);
}
