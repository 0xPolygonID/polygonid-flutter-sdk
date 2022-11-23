import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../constants.dart';
import '../../../sdk/di/injector.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';

/// [StoreRef] wrapper
/// Delegates all call to [IdentitySMTStoreRefWrapper._getStore]
/// Needed for UT for mocking extension methods
@injectable
class IdentitySMTStoreRefWrapper {
  Future<StoreRef<String, Map<String, Object?>>> _getStore(
      {required String storeName}) {
    return getItSdk.getAsync<StoreRef<String, Map<String, Object?>>>(
        instanceName: storeName);
  }

  Future<Map<String, Object?>?> get(
      DatabaseClient database, String storeName, String key) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(key).get(database));
  }

  Future<Map<String, Object?>> put(DatabaseClient database, String storeName,
      String key, Map<String, Object?> value,
      {bool? merge}) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(key).put(database, value, merge: merge));
  }

  Future<String?> remove(
      DatabaseClient database, String storeName, String identifier) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(identifier).delete(database));
  }
}

class StorageSMTDataSource {
  final IdentitySMTStoreRefWrapper _storeRefWrapper;

  StorageSMTDataSource(this._storeRefWrapper);

  Future<Database> _getDatabase(
      {required String identifier, required String privateKey}) {
    return getItSdk.getAsync<Database>(
        instanceName: identityDatabaseName,
        param1: identifier,
        param2: privateKey);
  }

  Future<void> createSMT(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => getTransact(
                storeName: storeName, transaction: transaction, key: key))
            .then((snapshot) => NodeDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  Future<NodeDTO> getNode(
      {required HashDTO key,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => getTransact(
                storeName: storeName, transaction: transaction, key: key))
            .then((snapshot) => NodeDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getTransact(
      {required String storeName,
      required DatabaseClient transaction,
      required HashDTO key}) async {
    _storeRefWrapper.remove(transaction, storeName, identifier)
    return _storeRefWrapper.get(transaction, storeName, key.toString());
  }

  Future<void> addNode(
      {required HashDTO key,
      required NodeDTO node,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => putTransact(
                storeName: storeName,
                transaction: transaction,
                key: key,
                node: node))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> putTransact(
      {required String storeName,
      required DatabaseClient transaction,
      required HashDTO key,
      required NodeDTO node}) async {
    await _storeRefWrapper.put(
        transaction, storeName, key.toString(), node.toJson());
  }

  Future<HashDTO> getRoot(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                getRootTransact(transaction: transaction, storeName: storeName))
            .then((snapshot) => HashDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getRootTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    return _storeRefWrapper.get(transaction, storeName, "root");
  }

  Future<void> setRoot(
      {required HashDTO root,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => setRootTransact(
                transaction: transaction, storeName: storeName, root: root))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> setRootTransact(
      {required DatabaseClient transaction,
      required String storeName,
      required HashDTO root}) async {
    await _storeRefWrapper.put(transaction, storeName, "root", root.toJson());
  }

  Future<int> getMaxLevels(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                getRootTransact(transaction: transaction, storeName: storeName))
            .then((snapshot) => snapshot!["maxLevels"] as int)
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getMaxLevelsTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    return _storeRefWrapper.get(transaction, storeName, "maxLevels");
  }

  Future<void> setMaxLevels(
      {required int maxLevels,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => setMaxLevelsTransact(
                transaction: transaction,
                storeName: storeName,
                maxLevels: maxLevels))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> setMaxLevelsTransact(
      {required DatabaseClient transaction,
      required String storeName,
      required int maxLevels}) async {
    await _storeRefWrapper
        .put(transaction, storeName, "maxLevels", {"maxLevels": maxLevels});
  }
}
