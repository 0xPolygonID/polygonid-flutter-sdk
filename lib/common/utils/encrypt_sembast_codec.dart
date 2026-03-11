import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:sembast/sembast.dart';

/// Internal JSON map typedef for clarity.
typedef JsonMap = Map<String, dynamic>;

/// Helper that encapsulates Salsa20 processing for a single message.
/// A new engine is created per call to avoid state reuse issues with stream ciphers.
Uint8List _salsa20Process({
  required Uint8List keyBytes,
  required bool forEncryption,
  required Uint8List ivBytes,
  required Uint8List input,
}) {
  final engine = Salsa20Engine()
    ..init(forEncryption, ParametersWithIV(KeyParameter(keyBytes), ivBytes));
  return Uint8List.fromList(engine.process(input));
}

/// Encoder: Map<String,dynamic> -> encrypted base64 String.
class _EncryptEncoder extends Converter<JsonMap, String> {
  final String key;
  late final Uint8List _keyBytes;

  // NOTE: Using a fixed zero IV preserves deterministic output required by existing tests & persistence.
  // Changing to a random IV would require embedding it with the ciphertext and adjusting all consumers.
  static final Uint8List _ivBytes = Uint8List(8); // Salsa20 64-bit nonce.

  _EncryptEncoder(this.key) {
    // Cache key bytes.
    _keyBytes = Uint8List.fromList(utf8.encode(key));
  }

  @override
  String convert(JsonMap input) {
    final plainJson = json.encode(input);
    final plainBytes = Uint8List.fromList(utf8.encode(plainJson));
    final encrypted = _salsa20Process(
      keyBytes: _keyBytes,
      forEncryption: true,
      ivBytes: _ivBytes,
      input: plainBytes,
    );
    return base64Encode(encrypted);
  }
}

/// Decoder: encrypted base64 String -> Map<String,dynamic>.
class _EncryptDecoder extends Converter<String, JsonMap> {
  final String key;
  late final Uint8List _keyBytes;
  static final Uint8List _ivBytes = Uint8List(8);

  _EncryptDecoder(this.key) {
    _keyBytes = Uint8List.fromList(utf8.encode(key));
  }

  @override
  JsonMap convert(String input) {
    try {
      final cipherBytes = Uint8List.fromList(base64Decode(input));
      final decrypted = _salsa20Process(
        keyBytes: _keyBytes,
        forEncryption: false,
        ivBytes: _ivBytes,
        input: cipherBytes,
      );
      final decryptedStr = utf8.decode(decrypted);
      final decoded = json.decode(decryptedStr);
      if (decoded is Map) {
        return decoded.cast<String, dynamic>();
      }
      throw const FormatException('Decoded JSON is not a Map');
    } on FormatException catch (e) {
      // Re-throw with more context but avoid leaking full ciphertext.
      throw FormatException('Invalid encrypted input: ${e.message}');
    } catch (e) {
      throw FormatException('Failed to decrypt input: $e');
    }
  }
}

class _EncryptCodec extends Codec<JsonMap, String> {
  late final _EncryptEncoder _encoder;
  late final _EncryptDecoder _decoder;

  _EncryptCodec(String password) {
    _encoder = _EncryptEncoder(password);
    _decoder = _EncryptDecoder(password);
  }

  @override
  Converter<String, JsonMap> get decoder => _decoder;

  @override
  Converter<JsonMap, String> get encoder => _encoder;
}

/// Builds a SembastCodec that transparently encrypts/decrypts JSON maps with Salsa20.
///
/// The encryption currently uses a fixed zero IV to preserve deterministic behavior
/// relied upon by existing tests. For stronger security (preventing keystream reuse),
/// consider migrating to a random IV per record and storing/embedding it alongside
/// ciphertext. That change would be a breaking change for persistence.
SembastCodec getEncryptSembastCodec({required String encryptionKey}) {
  return SembastCodec(
    signature: 'EncryptType.salsa20',
    codec: _EncryptCodec(encryptionKey),
  );
}
