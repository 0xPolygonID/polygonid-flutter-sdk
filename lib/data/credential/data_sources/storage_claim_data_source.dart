import 'package:injectable/injectable.dart';
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

class StorageClaimDataSource {
  final Database _database;
  final ClaimStoreRefWrapper _storeRefWrapper;

  StorageClaimDataSource(this._database, this._storeRefWrapper);

  /// Store all claims in a single transaction
  /// If one storing fail, they will all be reverted
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
}
