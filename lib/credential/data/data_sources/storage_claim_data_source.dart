import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
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

  Future<String?> remove(DatabaseClient database, String identifier) {
    return _store.record(identifier).delete(database);
  }

  Future<int> removeAll(DatabaseClient database) {
    return _store.delete(database);
  }
}

class StorageClaimDataSource extends SecureIdentityStorageDataSource {
  final ClaimStoreRefWrapper _storeRefWrapper;

  StorageClaimDataSource(this._storeRefWrapper);

  /// Store all claims in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeClaims(
      {required List<ClaimDTO> claims,
      required String did,
      required String privateKey}) {
    // TODO check if identifiers inside each claim are from privateKey
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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
      required String did,
      required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
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

  /// Remove all claims in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllClaims(
      {required String did, required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        database
            .transaction((transaction) =>
                removeAllClaimsTransact(transaction: transaction))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> removeAllClaimsTransact(
      {required DatabaseClient transaction}) async {
    await _storeRefWrapper.removeAll(transaction);
  }

  Future<List<ClaimDTO>> getClaims(
      {Filter? filter, required String did, required String privateKey}) {
    return getDatabase(did: did, privateKey: privateKey).then((database) =>
        _storeRefWrapper
            .find(database, finder: Finder(filter: filter))
            .then((snapshots) => snapshots
                .map((snapshot) => ClaimDTO.fromJson(snapshot.value))
                .toList())
            .whenComplete(() => database.close()));
  }
}
