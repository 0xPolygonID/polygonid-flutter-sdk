import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/secure_identity_storage_data_source.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:sembast/sembast.dart';

import '../dtos/claim_dto.dart';

/// [StoreRef] wrapper
/// Delegates all call to [CredentialStoreRefWrapper._store]
/// Needed for UT for mocking extension methods
@injectable
class CredentialStoreRefWrapper {
  final StoreRef<String, Map<String, Object?>> _store;

  CredentialStoreRefWrapper(@Named(claimStoreName) this._store);

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

class CredentialStorageDataSource extends SecureIdentityStorageDataSource {
  final CredentialStoreRefWrapper _storeRefWrapper;

  CredentialStorageDataSource(this._storeRefWrapper);

  /// Store all claims in a single transaction
  /// If one storing fails, they will all be reverted
  Future<void> storeCredentials({
    required List<CredentialDTO> credentials,
    required String did,
    required String encryptionKey,
  }) async {
    // TODO check if identifiers inside each claim are from privateKey
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      await database.transaction(
        (t) =>
            storeCredentialsTransact(transaction: t, credentials: credentials),
      );
    } finally {
      database?.close();
    }
  }

  // For UT purpose
  @visibleForTesting
  Future<void> storeCredentialsTransact({
    required DatabaseClient transaction,
    required List<CredentialDTO> credentials,
  }) async {
    for (CredentialDTO credential in credentials) {
      await _storeRefWrapper.put(
          transaction, credential.id, credential.toJson());
    }
  }

  /// Remove all credentials in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeCredential({
    required List<String> credentialIds,
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      await database.transaction(
        (t) => removeCredentialsTransact(
            transaction: t, credentialIds: credentialIds),
      );
    } finally {
      await database?.close();
    }
  }

  // For UT purpose
  @visibleForTesting
  Future<void> removeCredentialsTransact({
    required DatabaseClient transaction,
    required List<String> credentialIds,
  }) async {
    for (String credentialId in credentialIds) {
      await _storeRefWrapper.remove(transaction, credentialId);
    }
  }

  /// Remove all credentials in a single transaction
  /// If one removing fails, they will all be reverted
  Future<void> removeAllCredentials({
    required String did,
    required String encryptionKey,
  }) async {
    Database? database;
    try {
      database = await getDatabase(did: did, encryptionKey: encryptionKey);
      await database.transaction(
        (t) => removeAllCredentialsTransact(transaction: t),
      );
    } finally {
      database?.close();
    }
  }

  // For UT purpose
  Future<void> removeAllCredentialsTransact({
    required DatabaseClient transaction,
  }) async {
    await _storeRefWrapper.removeAll(transaction);
  }

  Future<List<CredentialDTO>> getCredentials({
    Filter? filter,
    required String did,
    required String encryptionKey,
    List<CredentialSortOrder> credentialSortOrderList = const [],
  }) async {
    Database database =
        await getDatabase(did: did, encryptionKey: encryptionKey);

    try {
      List<SortOrder> sortOrders = [];

      for (var element in credentialSortOrderList) {
        switch (element) {
          case CredentialSortOrder.ExpirationAscending:
            sortOrders.add(SortOrder('expiration', true));
            break;
          case CredentialSortOrder.ExpirationDescending:
            sortOrders.add(SortOrder('expiration', false));
            break;
          case CredentialSortOrder.IssuanceDateAscending:
            sortOrders.add(SortOrder('credential.issuanceDate', true));
            break;
          case CredentialSortOrder.IssuanceDateDescending:
            sortOrders.add(SortOrder('credential.issuanceDate', false));
            break;
        }
      }

      List<RecordSnapshot<String, Map<String, Object?>>> snapshots =
          await _storeRefWrapper.find(
        database,
        finder: Finder(
          filter: filter,
          sortOrders: sortOrders,
        ),
      );

      List<CredentialDTO> credentials = snapshots.map((snapshot) {
        CredentialDTO credentialDTO = CredentialDTO.fromJson(snapshot.value);
        return credentialDTO;
      }).toList();

      return credentials;
    } finally {
      database.close();
    }
  }

  Future<List<CredentialDTO>> getCredentialByPartialId({
    required String did,
    required String partialId,
    required String encryptionKey,
  }) async {
    final database = await getDatabase(did: did, encryptionKey: encryptionKey);

    try {
      final partialIdFiler = Filter.custom((record) =>
          (record.value as Map<String, Object?>)['id']
              ?.toString()
              .contains(partialId) ??
          false);

      final snapshots = await _storeRefWrapper.find(
        database,
        finder: Finder(filter: partialIdFiler),
      );

      return snapshots.map((snapshot) {
        return CredentialDTO.fromJson(snapshot.value);
      }).toList();
    } finally {
      database.close();
    }
  }

  /// Get a [CredentialDTO] filtered by id associated to the identity previously stored
  Future<CredentialDTO> getCredential({
    required String credentialId,
    required String did,
    required String encryptionKey,
  }) async {
    Database db = await getDatabase(did: did, encryptionKey: encryptionKey);

    try {
      Map<String, Object?>? credential =
          await _storeRefWrapper.get(db, credentialId);
      if (credential == null) {
        StacktraceManager stacktraceManager = getItSdk<StacktraceManager>();
        stacktraceManager.addError('Credential not found by id');
        throw CredentialNotFoundException(
          id: credentialId,
          errorMessage: 'Credential not found by id',
        );
      }

      CredentialDTO credentialDTO = CredentialDTO.fromJson(credential);
      return credentialDTO;
    } finally {
      db.close();
    }
  }
}
