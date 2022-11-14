import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:sembast/sembast.dart';

import '../dtos/claim_dto.dart';

/// [StoreRef] wrapper
/// Delegates all call to [ClaimStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class ClaimStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  ClaimStoreRefWrapper(@Named(claimStoreName) this._store);

  Future<List<RecordSnapshot<String, Map<String, Object?>>>> find(
      DatabaseClient databaseClient,
      {Finder? finder}) {
    return _store.find(databaseClient, finder: finder);
  }

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String key) {
    return _store.record(key).delete(database);
  }
}

class StorageClaimDataSource {
  final ClaimStoreRefWrapper _storeRefWrapper;

  StorageClaimDataSource(this._storeRefWrapper);

  Future<Database> _getDatabase(
      {required String identifier, required String privateKey}) {
    return getItSdk.getAsync<Database>(
        instanceName: claimDatabaseName,
        param1: identifier,
        param2: privateKey);
  }

  /// Store all claims in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeClaims(
      {required List<ClaimDTO> claims,
      required String identifier,
      required String privateKey}) {
    // TODO check if identifiers inside each claim are from privateKey
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                storeClaimsTransact(transaction: transaction, claims: claims))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> storeClaimsTransact(
      {required DatabaseClient transaction,
      required List<ClaimDTO> claims}) async {
    for (ClaimDTO claim in claims) {
      await _storeRefWrapper.put(transaction, claim.id, claim.toJson());
    }
  }

  /// Remove all claims in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => removeClaimsTransact(
                transaction: transaction, claimIds: claimIds))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeClaimsTransact(
      {required DatabaseClient transaction,
      required List<String> claimIds}) async {
    for (String claimId in claimIds) {
      // TODO check if identifiers inside each claim are from privateKey
      await _storeRefWrapper.remove(transaction, claimId);
    }
  }

  Future<List<ClaimDTO>> getClaims(
      {Filter? filter,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => _storeRefWrapper
            .find(database, finder: Finder(filter: filter))
            .then((snapshots) => snapshots
                .map((snapshot) => ClaimDTO.fromJson(snapshot.value))
                .toList())
            .whenComplete(() => database.close()));
  }
}
