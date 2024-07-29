import "package:polygonid_flutter_sdk/common/kms/store/abstract_key_store.dart";

/// Key Store to use in memory
///
/// @public
/// @class InMemoryPrivateKeyStore
/// @implements implements AbstractPrivateKeyStore interface
class InMemoryPrivateKeyStore implements AbstractPrivateKeyStore {
  Map<String, String> _data;

  InMemoryPrivateKeyStore() : _data = <String, String>{};

  @override
  Future<String> get({required String alias}) async {
    final privateKey = _data[alias];
    if (privateKey == null) {
      throw Exception('no key under given alias');
    }
    return privateKey;
  }

  @override
  Future<void> importKey({required String alias, required String key}) async {
    _data[alias] = key;
  }
}
