import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../../common/utils/encrypt_sembast_codec.dart';
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
  //final Database _claimDatabase;
  final ClaimStoreRefWrapper _storeRefWrapper;

  StorageClaimDataSource(/*this._claimDatabase,*/ this._storeRefWrapper);

  Future<Database> _claimDatabase(
      {required String identifier, required String privateKey}) async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, claimDatabaseName + identifier + '.db');
    // Initialize the encryption codec with the privateKey
    var codec = getEncryptSembastCodec(password: privateKey);
    final database = await databaseFactoryIo.openDatabase(path, codec: codec);
    return database;
  }

  /// Store all claims in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeClaims(
      {required List<ClaimDTO> claims,
      required String identifier,
      required String privateKey}) async {
    // TODO check if identifiers inside each claim are from privateKey
    Database database =
        await _claimDatabase(identifier: identifier, privateKey: privateKey);
    await database.transaction((transaction) =>
        storeClaimsTransact(transaction: transaction, claims: claims));
    await database.close();
    //return _database.transaction((transaction) =>
    //    storeClaimsTransact(transaction: transaction, claims: claims));
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
      required String privateKey}) async {
    Database database =
        await _claimDatabase(identifier: identifier, privateKey: privateKey);
    await database.transaction((transaction) =>
        removeClaimsTransact(transaction: transaction, claimIds: claimIds));
    await database.close();
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
      required String privateKey}) async {
    Database database =
        await _claimDatabase(identifier: identifier, privateKey: privateKey);
    List<ClaimDTO> claims = await _storeRefWrapper
        .find(database, finder: Finder(filter: filter))
        .then((snapshots) => snapshots
            .map((snapshot) => ClaimDTO.fromJson(snapshot.value))
            .toList());
    await database.close();
    return claims;
  }
}
