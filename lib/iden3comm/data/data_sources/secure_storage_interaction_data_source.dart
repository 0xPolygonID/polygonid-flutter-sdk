import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

/// [StoreRef] wrapper
/// Delegates all call to [SecureInteractionStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class SecureInteractionStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  SecureInteractionStoreRefWrapper(@Named(interactionStoreName) this._store);

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

class SecureStorageInteractionDataSource
    extends SecureIdentityStorageDataSource {
  final SecureInteractionStoreRefWrapper _storeRefWrapper;

  SecureStorageInteractionDataSource(this._storeRefWrapper);

  /// Store all interactions in a single transaction
  /// If one storing fails, they will all be reverted
  ///
  /// Return the stored interactions
  Future<List<Map<String, dynamic>>> storeInteractions({
    required List<Map<String, dynamic>> interactions,
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);

      return await database.transaction((transaction) async {
        List<Map<String, dynamic>> storedInteractions = [];

        for (Map<String, dynamic> interaction in interactions) {
          Map<String, dynamic> storedInteraction;
          if (interaction['id'] == null) {
            /// Id is null when the interaction is not stored yet
            final id = await _storeRefWrapper.add(transaction, interaction);
            interaction['id'] = id;

            storedInteraction = interaction;
          } else {
            /// Id is not null, we update the interaction
            await _storeRefWrapper.put(
              transaction,
              interaction['id'],
              interaction,
            );
            storedInteraction = interaction;
          }

          storedInteractions.add(storedInteraction);
        }

        return storedInteractions;
      });
    } finally {
      database?.close();
    }
  }

  /// Remove all interactions in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeInteractions({
    required List<String> ids,
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      await database.transaction((t) async {
        for (String interactionId in ids) {
          await _storeRefWrapper.remove(t, interactionId);
        }
      });
    } finally {
      await database?.close();
    }
  }

  /// Remove all interactions in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllInteractions({
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      await database.transaction((t) => _storeRefWrapper.removeAll(t));
    } finally {
      await database?.close();
    }
  }

  Future<List<Map<String, dynamic>>> getInteractions({
    Filter? filter,
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      final snapshots = await _storeRefWrapper.find(
        database,
        finder: Finder(filter: filter),
      );
      return snapshots.map((snapshot) => snapshot.value).toList();
    } finally {
      database?.close();
    }
  }
}
