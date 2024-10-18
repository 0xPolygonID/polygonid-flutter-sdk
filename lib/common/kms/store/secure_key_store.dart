import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/kms/store/abstract_key_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureKeyStore extends AbstractPrivateKeyStore {
  static const String _secureStorageKey = 'secure_storage_KMS_data';

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Map<String, String>? _cache;

  @override
  Future<String> get({required String alias}) async {
    final storage = await _getStorage();

    if (!storage.containsKey(alias)) {
      throw Exception('No key under given alias');
    }

    return storage[alias]!;
  }

  @override
  Future<void> importKey({required String alias, required String key}) async {
    final storage = _cache ?? await _getStorage();

    storage[alias] = key;

    await _secureStorage.write(
      key: _secureStorageKey,
      value: jsonEncode(storage),
    );
  }

  Future<Map<String, String>> _getStorage() async {
    final cache = _cache;
    if (cache != null) {
      return cache;
    }
    final data = await _secureStorage.read(key: _secureStorageKey);
    if (data == null) {
      return {};
    }

    final decodedData = jsonDecode(data) as Map<String, dynamic>;

    return _cache = decodedData.map(
      (key, value) => MapEntry(key, value as String),
    );
  }
}
