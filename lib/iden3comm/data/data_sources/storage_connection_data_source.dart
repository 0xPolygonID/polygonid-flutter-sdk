import 'package:injectable/injectable.dart';

import 'package:polygonid_flutter_sdk/common/utils/encrypt_sembast_codec.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/connection_dto.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/sembast_import_export.dart';

/// [StoreRef] wrapper
/// Delegates all call to [ConnectionStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class ConnectionStoreRefWrapper {
  final Map<String, StoreRef<String, Map<String, Object?>>> _store;

  ConnectionStoreRefWrapper(@Named(securedStoreName) this._store);

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> find(
      DatabaseClient databaseClient,
      {Finder? finder}) {
    return _store[connectionStoreName]!.find(databaseClient, finder: finder);
  }

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store[connectionStoreName]!.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store[connectionStoreName]!
        .record(key)
        .put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String identifier) {
    return _store[connectionStoreName]!.record(identifier).delete(database);
  }

  Future<int> removeAll(DatabaseClient database) {
    return _store[connectionStoreName]!.delete(database);
  }
}

class StorageConnectionDataSource {
  final ConnectionStoreRefWrapper _storeRefWrapper;

  StorageConnectionDataSource(this._storeRefWrapper);

  Future<Database> _getDatabase(
      {required String did, required String privateKey}) {
    return getItSdk.getAsync<Database>(
        instanceName: identityDatabaseName, param1: did, param2: privateKey);
  }

  /// Store all connections in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeConnections(
      {required List<ConnectionDTO> connections,
      required String did,
      required String privateKey}) {
    // TODO check if identifiers inside each claim are from privateKey
    return _getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => storeConnectionsTransact(
                transaction: transaction, connections: connections))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> storeConnectionsTransact(
      {required DatabaseClient transaction,
      required List<ConnectionDTO> connections}) async {
    for (ConnectionDTO connection in connections) {
      await _storeRefWrapper.put(
          transaction, connection.from + connection.to, connection.toJson());
    }
  }

  /// Remove all claims in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeConnections(
      {required List<String> connectionIds,
      required String did,
      required String privateKey}) {
    return _getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) => removeConnectionsTransact(
                transaction: transaction, connectionIds: connectionIds))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeConnectionsTransact(
      {required DatabaseClient transaction,
      required List<String> connectionIds}) async {
    for (String connectionId in connectionIds) {
      // TODO check if identifiers inside each claim are from privateKey
      await _storeRefWrapper.remove(transaction, connectionId);
    }
  }

  /// Remove all connections in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllConnections(
      {required String did, required String privateKey}) {
    return _getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) =>
                removeAllConnectionsTransact(transaction: transaction))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeAllConnectionsTransact(
      {required DatabaseClient transaction}) async {
    await _storeRefWrapper.removeAll(transaction);
  }

  Future<List<ConnectionDTO>> getConnections(
      {required String did, required String privateKey}) {
    return _getDatabase(did: did, privateKey: privateKey).then((database) =>
        _storeRefWrapper
            .find(database)
            .then((snapshots) => snapshots
                .map((snapshot) => ConnectionDTO.fromJson(snapshot.value))
                .toList())
            .whenComplete(() => database.close()));
  }
}
