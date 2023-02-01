import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/sembast_import_export.dart';

/// [StoreRef] wrapper
/// Delegates all call to [IdentityStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class IdentityStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  IdentityStoreRefWrapper(@Named(identityStoreName) this._store);

  Future<Map<String, Object?>?> get(DatabaseClient database, String key) {
    return _store.record(key).get(database);
  }

  Future<Map<String, Object?>> put(
      DatabaseClient database, String key, Map<String, Object?> value,
      {bool? merge}) {
    return _store.record(key).put(database, value, merge: merge);
  }

  Future<String?> remove(DatabaseClient database, String did) {
    return _store.record(did).delete(database);
  }
}

class StorageIdentityDataSource {
  final Database _database;
  final IdentityStoreRefWrapper _storeRefWrapper;

  StorageIdentityDataSource(this._database, this._storeRefWrapper);

  Future<IdentityDTO> getIdentity({required String did}) {
    return _storeRefWrapper.get(_database, did).then((storedValue) {
      if (storedValue == null) {
        throw UnknownIdentityException(did);
      }

      return IdentityDTO.fromJson(storedValue);
    });
  }

  /// As we support only one identity at the moment, we need to maintain
  /// the stored current did up to date
  Future<void> storeIdentity(
      {required String did, required IdentityDTO identity}) {
    return _database.transaction((transaction) => storeIdentityTransact(
        transaction: transaction, did: did, identity: identity));
  }

  Future<void> storeIdentityTransact(
      {required DatabaseClient transaction,
      required String did,
      required IdentityDTO identity}) async {
    await _storeRefWrapper.put(transaction, did, identity.toJson());
  }

  Future<void> removeIdentity({required String did}) {
    // TODO: get privateKey from param and obtain publicKey
    //  from identity and encrypt/decrypt a msg to allow removing the identity
    return _database.transaction((transaction) =>
        removeIdentityTransact(transaction: transaction, did: did));
  }

  // For UT purpose
  Future<void> removeIdentityTransact(
      {required DatabaseClient transaction, required String did}) async {
    await _storeRefWrapper.remove(transaction, did);
  }

  /// Export identity database
  Future<Map<String, Object?>> getIdentityDb(
      {required String did, required String privateKey}) async {
    Database db = await _getDatabase(
      did: did,
      privateKey: privateKey,
    );

    Map<String, Object?> exportableDb = await exportDatabase(db);
    return exportableDb;
  }

  /// Import entire claims database
  Future<void> saveIdentityDb({
    required Map<String, Object?> exportableDb,
    required DatabaseFactory databaseFactory,
    required String destinationPath,
    required String privateKey,
  }) async {
    SembastCodec codec = getItSdk.get<SembastCodec>(param1: privateKey);

    await importDatabase(
      exportableDb,
      databaseFactory,
      destinationPath,
      codec: codec,
    );
  }

  Future<Database> _getDatabase({
    required String did,
    required String privateKey,
  }) {
    return getItSdk.getAsync<Database>(
      instanceName: identityDatabaseName,
      param1: did,
      param2: privateKey,
    );
  }
}
