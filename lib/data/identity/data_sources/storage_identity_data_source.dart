import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:sembast/sembast.dart';

/// [StoreRef] wrapper
/// Delegates all call to [IdentityStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class IdentityStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  IdentityStoreRefWrapper(@Named(identityStoreName) this._store);

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }
}

class StorageIdentityDataSource {
  final Database _database;
  final IdentityStoreRefWrapper _storeRefWrapper;

  StorageIdentityDataSource(this._database, this._storeRefWrapper);

  Future<IdentityDTO?> getIdentity({required String identifier}) {
    return _storeRefWrapper.get(_database, identifier).then((storeValue) =>
        storeValue != null ? IdentityDTO.fromJson(storeValue) : null);
  }

  Future<void> storeIdentity(
      {required String identifier, required IdentityDTO identity}) {
    return _storeRefWrapper.put(_database, identifier, identity.toJson());
  }
}
