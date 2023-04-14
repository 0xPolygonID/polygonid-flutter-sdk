import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

/// Not used for now, keeping it for future use

/// [StoreRef] wrapper
/// Delegates all call to [InteractionStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class InteractionStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  InteractionStoreRefWrapper(@Named(interactionStoreName) this._store);

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> find(
      DatabaseClient databaseClient,
      {Finder? finder}) {
    return _store.find(databaseClient, finder: finder);
  }

  Future<String> add(DatabaseClient database, Map<String, Object?> value) {
    return _store.add(database, value);
  }

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String id) {
    return _store.record(id).delete(database);
  }

  Future<int> removeAll(DatabaseClient database) {
    return _store.delete(database);
  }
}

class StorageInteractionDataSource {
  final Database _database;
  final InteractionStoreRefWrapper _storeRefWrapper;

  StorageInteractionDataSource(this._database, this._storeRefWrapper);

  /// Store all interactions in a single transaction
  /// If one storing fails, they will all be reverted
  ///
  /// Return the stored interactions
  Future<List<Map<String, dynamic>>> storeInteractions(
      {required List<Map<String, dynamic>> interactions}) {
    return _database
        .transaction((transaction) => storeInteractionsTransact(
            transaction: transaction, interactions: interactions))
        .whenComplete(() => _database.close());
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
  Future<void> removeInteractions({required List<String> interactionIds}) {
    return _database
        .transaction((transaction) => removeInteractionsTransact(
            transaction: transaction, interactionIds: interactionIds))
        .whenComplete(() => _database.close());
  }

  // For UT purpose
  Future<void> removeInteractionsTransact(
      {required DatabaseClient transaction,
      required List<String> interactionIds}) async {
    for (String interactionId in interactionIds) {
      await _storeRefWrapper.remove(transaction, interactionId);
    }
  }

  /// Remove all interactions in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllInteractions(
      {required String did, required String privateKey}) {
    return _database
        .transaction((transaction) =>
            removeAllInteractionsTransact(transaction: transaction))
        .whenComplete(() => _database.close());
  }

  // For UT purpose
  Future<void> removeAllInteractionsTransact(
      {required DatabaseClient transaction}) async {
    await _storeRefWrapper.removeAll(transaction);
  }

  Future<List<Map<String, dynamic>>> getInteractions() {
    return _storeRefWrapper
        .find(_database)
        .then(
            (snapshots) => snapshots.map((snapshot) => snapshot.value).toList())
        .whenComplete(() => _database.close());
  }
}
