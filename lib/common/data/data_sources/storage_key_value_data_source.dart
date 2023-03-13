import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_dto.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

// Kind of hacky
class StorageKey {
  static String env = "env";
}

/// [StoreRef] wrapper
/// Delegates all call to [KeyValueStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class KeyValueStoreRefWrapper {
  final StoreRef<String, dynamic> _store;

  KeyValueStoreRefWrapper(@Named(keyValueStoreName) this._store);

  Future<dynamic> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<dynamic> put(DatabaseClient database, String key, dynamic value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String key) {
    return _store.record(key).delete(database);
  }
}

/// We either take the [DatabaseClient] from the DI (as [Database])
/// or pass it as param for each operation to be able to include it in a [Transaction]
class StorageKeyValueDataSource {
  final Database _database;
  final KeyValueStoreRefWrapper _storeRefWrapper;

  StorageKeyValueDataSource(this._database, this._storeRefWrapper);

  Future<dynamic> get({required String key, DatabaseClient? database}) {
    return _storeRefWrapper.get(database ?? _database, key);
  }

  Future<void> store(
      {required String key, required dynamic value, DatabaseClient? database}) {
    return _storeRefWrapper.put(database ?? _database, key, value);
  }

  Future<String?> remove({required String key, DatabaseClient? database}) {
    return _storeRefWrapper.remove(database ?? _database, key);
  }
}
