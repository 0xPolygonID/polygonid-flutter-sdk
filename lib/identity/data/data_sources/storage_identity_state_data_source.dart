import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

import '../../../sdk/di/injector.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';

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

class StorageIdentityStateDataSource {
  final IdentityStoreRefWrapper _storeRefWrapper;

  StorageIdentityStateDataSource(
    this._storeRefWrapper,
  );

  Future<Database> _getDatabase(
      {required String identifier, required String privateKey}) {
    return getItSdk.getAsync<Database>(
        instanceName: identityDatabaseName,
        param1: identifier,
        param2: privateKey);
  }

  Future<NodeDTO> get(
      {required HashDTO key,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                getTransact(transaction: transaction, key: key))
            .then((snapshot) => NodeDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getTransact(
      {required DatabaseClient transaction, required HashDTO key}) async {
    return _storeRefWrapper.get(transaction, key.toString());
  }

  Future<void> put(
      {required HashDTO hash,
      required NodeDTO node,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                putTransact(transaction: transaction, hash: hash, node: node))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> putTransact(
      {required DatabaseClient transaction,
      required HashDTO hash,
      required NodeDTO node}) async {
    await _storeRefWrapper.put(transaction, hash.toString(), node.toJson());
  }

  Future<HashDTO> getRoot(
      {required String identifier, required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction(
                (transaction) => getRootTransact(transaction: transaction))
            .then((snapshot) => HashDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getRootTransact(
      {required DatabaseClient transaction}) async {
    return _storeRefWrapper.get(transaction, "root");
  }

  Future<void> setRoot(
      {required HashDTO root,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                setRootTransact(transaction: transaction, root: root))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> setRootTransact(
      {required DatabaseClient transaction, required HashDTO root}) async {
    await _storeRefWrapper.put(transaction, "root", root.toJson());
  }
}
