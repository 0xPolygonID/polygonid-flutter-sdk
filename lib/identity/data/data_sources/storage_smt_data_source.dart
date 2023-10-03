import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:sembast/sembast.dart';

import '../../../constants.dart';
import '../../domain/exceptions/smt_exceptions.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';

/// [StoreRef] wrapper
/// Delegates all call to [IdentitySMTStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class IdentitySMTStoreRefWrapper {
  final Map<String, StoreRef<String, Map<String, Object?>>> _store;

  IdentitySMTStoreRefWrapper(@Named(identityStateStoreName) this._store);

  Future<Map<String, Object?>?> get(
      DatabaseClient database, String storeName, String key) {
    return _store[storeName]!.record(key).get(database);
  }

  Future<Map<String, Object?>> put(DatabaseClient database, String storeName,
      String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store[storeName]!.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(
      DatabaseClient database, String storeName, String did) {
    return _store[storeName]!.record(did).delete(database);
  }

  Future<int> removeAll(DatabaseClient database, String storeName) {
    return _store[storeName]!.delete(database);
  }
}

class StorageSMTDataSource extends SecureIdentityStorageDataSource {
  final IdentitySMTStoreRefWrapper _storeRefWrapper;

  StorageSMTDataSource(this._storeRefWrapper);

  // getNode gets a node by key from the SMT.  Empty nodes are not stored in the
  // tree; they are all the same and assumed to always exist.
  Future<NodeDTO> getNode(
      {required HashDTO key,
      required String storeName,
      required String did,
      required String privateKey}) {
    if ((BigInt.parse(key.toString())) == BigInt.zero) {
      return Future.value(NodeDTO(
        children: const [],
        hash: HashDTO.fromBigInt(BigInt.zero),
        type: NodeTypeDTO.empty,
      ));
    }
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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
    return _storeRefWrapper.get(transaction, storeName, key.toString());
  }

  Future<void> addNode(
      {required HashDTO key,
      required NodeDTO node,
      required String storeName,
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) =>
                getRootTransact(transaction: transaction, storeName: storeName))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<HashDTO> getRootTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    return _storeRefWrapper
        .get(transaction, storeName, "root")
        .then((storedValue) {
      if (storedValue == null) {
        throw SMTNotFoundException(storeName);
      }
      return HashDTO.fromJson(storedValue);
    });
  }

  Future<void> setRoot(
      {required HashDTO root,
      required String storeName,
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => getMaxLevelsTransact(
                transaction: transaction, storeName: storeName))
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
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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

  Future<void> removeSMT(
      {required String storeName,
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => removeSMTTransact(
                transaction: transaction, storeName: storeName))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeSMTTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    await _storeRefWrapper.removeAll(transaction, storeName);
  }
}
