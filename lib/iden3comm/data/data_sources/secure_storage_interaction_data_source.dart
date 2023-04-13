import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

/// [StoreRef] wrapper
/// Delegates all call to [SecureInteractionStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class SecureInteractionStoreRefWrapper {
  final StoreRef<int, Map<String, Object?>> _store;

  SecureInteractionStoreRefWrapper(@Named(interactionStoreName) this._store);

  Future<List<RecordSnapshot<int, Map<String, Object?>>>> find(
      DatabaseClient databaseClient,
      {Finder? finder}) {
    return _store.find(databaseClient, finder: finder);
  }

  Future<int> add(DatabaseClient database, Map<String, Object?> value) {
    return _store.add(database, value);
  }

  Future<Map<String, Object?>?> get(DatabaseClient database, int key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, int key, Map<String, Object?> value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<int?> remove(DatabaseClient database, int id) {
    return _store.record(id).delete(database);
  }

  Future<int> removeAll(DatabaseClient database) {
    return _store.delete(database);
  }
}

class SecureStorageInteractionDataSource
    extends SecureIdentityStorageDataSource {
  final SecureInteractionStoreRefWrapper _storeRefWrapper;

  SecureStorageInteractionDataSource(this._storeRefWrapper);

  /// Store all interactions in a single transaction
  /// If one storing fails, they will all be reverted
  ///
  /// Return the stored interactions
  Future<List<Map<String, dynamic>>> storeInteractions(
      {required List<Map<String, dynamic>> interactions,
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => storeInteractionsTransact(
                transaction: transaction, interactions: interactions))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<List<Map<String, dynamic>>> storeInteractionsTransact(
      {required DatabaseClient transaction,
      required List<Map<String, dynamic>> interactions}) async {
    List<Map<String, dynamic>> storedInteractions = [];

    for (Map<String, dynamic> interaction in interactions) {
      await (interaction['id'] == null
              ? _storeRefWrapper.add(transaction, interaction).then((id) {
                  interaction['id'] = id;

                  return interaction;
                })
              : _storeRefWrapper
                  .put(transaction, interaction['id'], interaction)
                  .then((_) => interaction))
          .then(
              (storedInteraction) => storedInteractions.add(storedInteraction));
    }

    return storedInteractions;
  }

  /// Remove all interactions in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeInteractions(
      {required List<int> interactionIds,
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => removeInteractionsTransact(
                transaction: transaction, interactionIds: interactionIds))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeInteractionsTransact(
      {required DatabaseClient transaction,
      required List<int> interactionIds}) async {
    for (int interactionId in interactionIds) {
      await _storeRefWrapper.remove(transaction, interactionId);
    }
  }

  /// Remove all interactions in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllInteractions(
      {required String did, required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) =>
                removeAllInteractionsTransact(transaction: transaction))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeAllInteractionsTransact(
      {required DatabaseClient transaction}) async {
    await _storeRefWrapper.removeAll(transaction);
  }

  Future<List<Map<String, dynamic>>> getInteractions(
      {Filter? filter, required String did, required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        _storeRefWrapper
            .find(database, finder: Finder(filter: filter))
            .then((snapshots) =>
                snapshots.map((snapshot) => snapshot.value).toList())
            .whenComplete(() => database.close()));
  }
}
