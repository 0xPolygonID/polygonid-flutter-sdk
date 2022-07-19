import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:sembast/sembast.dart';

import 'storage_key_value_data_source.dart';

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

  Future<String?> remove(DatabaseClient database, String identifier) {
    return _store.record(identifier).delete(database);
  }
}

class StorageIdentityDataSource {
  final Database _database;
  final IdentityStoreRefWrapper _storeRefWrapper;
  final StorageKeyValueDataSource _storageKeyValueDataSource;

  StorageIdentityDataSource(
      this._database, this._storeRefWrapper, this._storageKeyValueDataSource);

  Future<IdentityDTO> getIdentity({required String identifier}) {
    return _storeRefWrapper.get(_database, identifier).then((storedValue) {
      if (storedValue == null) {
        throw UnknownIdentityException(identifier);
      }

      return IdentityDTO.fromJson(storedValue);
    });
  }

  /// As we support only one identity at the moment, we need to maintain
  /// the stored current identifier up to date
  Future<void> storeIdentity(
      {required String identifier, required IdentityDTO identity}) {
    return _database.transaction((transaction) => storeIdentityTransact(
        transaction: transaction, identifier: identifier, identity: identity));
  }

  /// TODO: remove when we support multiple identity
  // For UT purpose
  Future<void> storeIdentityTransact(
      {required DatabaseClient transaction,
      required String identifier,
      required IdentityDTO identity}) async {
    await _storageKeyValueDataSource.remove(
        key: currentIdentifierKey, database: transaction);
    await _storeRefWrapper.put(transaction, identifier, identity.toJson());
    await _storageKeyValueDataSource.store(
        key: currentIdentifierKey, value: identifier, database: transaction);
  }

  /// As we support only one identity at the moment, we need to maintain
  /// the stored current identifier up to date
  ///
  /// TODO: remove when we support multiple identity
  Future<void> removeIdentity(
      {required String identifier}) {
    return _database.transaction((transaction) => removeIdentityTransact(
        transaction: transaction, identifier: identifier));
  }

  // For UT purpose
  Future<void> removeIdentityTransact(
      {required DatabaseClient transaction, required String identifier}) async {
    await _storageKeyValueDataSource.remove(
        key: currentIdentifierKey, database: transaction);
    await _storeRefWrapper.remove(transaction, identifier);
  }

// Future<String?> removeIdentity({required String identifier}) {
//   return _storeRefWrapper.remove(_database, identifier);
// }
}
