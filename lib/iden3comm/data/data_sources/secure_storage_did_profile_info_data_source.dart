import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

@injectable
class SecureDidProfileInfoStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  SecureDidProfileInfoStoreRefWrapper(
    @Named(didProfileInfoStoreName) this._store,
  );

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> find(
    DatabaseClient databaseClient, {
    Finder? finder,
  }) {
    return _store.find(databaseClient, finder: finder);
  }

  Future<String> add(DatabaseClient database, Map<String, Object?> value) {
    return _store.add(database, value);
  }

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
    DatabaseClient database,
    String key,
    Map<String, Object?> value, {
    bool? merge,
  }) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String id) {
    return _store.record(id).delete(database);
  }

  Future<int> removeAll(DatabaseClient database) {
    return _store.delete(database);
  }
}

class SecureStorageDidProfileInfoDataSource
    extends SecureIdentityStorageDataSource {
  final SecureDidProfileInfoStoreRefWrapper _storeRefWrapper;

  SecureStorageDidProfileInfoDataSource(this._storeRefWrapper);

  Future<void> storeDidProfileInfo({
    required Map<String, dynamic> didProfileInfo,
    required String interactedDid,
    required String did,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);
    try {
      await database.transaction(
        (t) => _storeRefWrapper.put(t, interactedDid, didProfileInfo),
      );
    } finally {
      await database.close();
    }
  }

  Future<void> removeDidProfileInfo({
    required String interactedDid,
    required String did,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);
    try {
      await database.transaction(
        (transaction) => _storeRefWrapper.remove(transaction, interactedDid),
      );
    } finally {
      await database.close();
    }
  }

  Future<void> removeAllDidProfileInfo({
    required String did,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);
    try {
      await database.transaction(
        (transaction) => _storeRefWrapper.removeAll(transaction),
      );
    } finally {
      await database.close();
    }
  }

  Future<Map<String, dynamic>> getDidProfileInfosByInteractedWithDid({
    required String did,
    required String interactedWithDid,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);
    try {
      final value = await _storeRefWrapper.get(database, interactedWithDid);
      return value ?? {};
    } finally {
      await database.close();
    }
  }

  Future<List<Map<String, dynamic>>> getDidProfileInfos({
    Filter? filter,
    required String did,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);
    try {
      final snapshots = await _storeRefWrapper.find(
        database,
        finder: Finder(filter: filter),
      );
      return snapshots.map((snapshot) => snapshot.value).toList();
    } finally {
      await database.close();
    }
  }
}
