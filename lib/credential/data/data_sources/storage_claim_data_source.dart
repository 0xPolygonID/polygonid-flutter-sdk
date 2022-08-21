import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';

import '../../domain/exceptions/credential_exceptions.dart';
import '../dtos/claim_dto.dart';
import '../dtos/credential_dto.dart';

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
  final Database _database;
  final ClaimStoreRefWrapper _storeRefWrapper;

  StorageClaimDataSource(this._database, this._storeRefWrapper);

  /// Store all claims in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeClaims({required List<ClaimDTO> claims}) {
    return _database.transaction((transaction) =>
        storeClaimsTransact(transaction: transaction, claims: claims));
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
  Future<void> removeClaims({required List<String> ids}) {
    return _database.transaction((transaction) =>
        removeClaimsTransact(transaction: transaction, ids: ids));
  }

  // For UT purpose
  Future<void> removeClaimsTransact(
      {required DatabaseClient transaction, required List<String> ids}) async {
    for (String id in ids) {
      await _storeRefWrapper.remove(transaction, id);
    }
  }

  Future<List<ClaimDTO>> getClaims({Filter? filter}) {
    return _storeRefWrapper
        .find(_database, finder: Finder(filter: filter))
        .then((snapshots) => snapshots
            .map((snapshot) => ClaimDTO.fromJson(snapshot.value))
            .toList());
  }

  /// Update a claim and return it
  Future<ClaimDTO> updateClaim(
      {required String id, required Map<String, dynamic> data}) {
    return getClaims(filter: Filter.equals("id", id)).then((claims) {
      if (claims.isNotEmpty) {
        ClaimDTO originClaim = claims[0];
        CredentialDTO credential = CredentialDTO.fromJson(data);
        ClaimDTO updated = ClaimDTO(
            id: originClaim.id,
            issuer: originClaim.issuer,
            identifier: originClaim.identifier,
            credential: credential);

        return _storeRefWrapper
            .put(_database, originClaim.id, updated.toJson())
            .then((_) => updated);
      }

      throw ClaimNotFoundException(id);
    });
  }
}
