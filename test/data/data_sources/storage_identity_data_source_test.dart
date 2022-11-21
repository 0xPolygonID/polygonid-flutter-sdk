import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:sembast/sembast.dart';

import 'storage_identity_data_source_test.mocks.dart';

// Data
const identifier = "theIdentifier";
final mockGet = {
  'identifier': identifier,
  'state': "theSmt",
  'publicKey': ["pub1", "pub2"]
};

final identityDTO = IdentityDTO.fromJson(mockGet);
final exception = Exception();

// Dependencies
MockDatabase database = MockDatabase();
MockIdentityStoreRefWrapper storeRefWrapper = MockIdentityStoreRefWrapper();
MockStorageKeyValueDataSource storageKeyValueDataSource =
    MockStorageKeyValueDataSource();
MockWalletDataSource walletDataSource = MockWalletDataSource();
MockHexMapper hexMapper = MockHexMapper();

// Tested instance
StorageIdentityDataSource dataSource = StorageIdentityDataSource(database,
    storeRefWrapper, storageKeyValueDataSource, walletDataSource, hexMapper);

@GenerateMocks([
  Database,
  IdentityStoreRefWrapper,
  StorageKeyValueDataSource,
  WalletDataSource,
  HexMapper
])
void main() {
  group("Get identity", () {
    test(
        "Given an identifier with an already stored identity, when I call getIdentity, then I expect an IdentityDTO to be returned",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.value(mockGet));

      // When
      expect(await dataSource.getIdentity(identifier: identifier), identityDTO);

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], identifier);
    });

    test(
        "Given an identifier with no stored identity, when I call getIdentity, then I expect a null to be returned",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.value(null));

      // When
      await dataSource
          .getIdentity(identifier: identifier)
          .then((_) => expect(true, false)) // Be sure we don't succeed
          .catchError((error) {
        expect(error, isA<UnknownIdentityException>());
        expect(error.identifier, identifier);
      });

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], identifier);
    });

    test(
        "Given an identifier, when I call getIdentity and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.getIdentity(identifier: identifier), throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], identifier);
    });
  });

  group("Store identity", () {
    setUp(() {
      when(storageKeyValueDataSource.remove(
              key: anyNamed('key'), database: anyNamed('database')))
          .thenAnswer((realInvocation) => Future.value(identifier));
      when(storageKeyValueDataSource.store(
              key: anyNamed('key'),
              value: anyNamed('value'),
              database: anyNamed('database')))
          .thenAnswer((realInvocation) => Future.value(null));
    });

    test(
        "Given an identifier and an identity, when I call storeIdentity, then I expect the process to be completed",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.value(mockGet));

      // When
      await expectLater(
          dataSource.storeIdentityTransact(
              transaction: database,
              identifier: identifier,
              identity: identityDTO),
          completes);

      // Then
      var capturedPut =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(capturedPut[0], database);
      expect(capturedPut[1], identifier);
      expect(capturedPut[2], identityDTO.toJson());

      var capturedRemove = verify(storageKeyValueDataSource.remove(
              key: captureAnyNamed('key'),
              database: captureAnyNamed('database')))
          .captured;
      expect(capturedRemove[0], currentIdentifierKey);
      expect(capturedRemove[1], database);

      var capturedStore = verify(storageKeyValueDataSource.store(
              key: captureAnyNamed('key'),
              value: captureAnyNamed('value'),
              database: captureAnyNamed('database')))
          .captured;
      expect(capturedStore[0], currentIdentifierKey);
      expect(capturedStore[1], identifier);
      expect(capturedStore[2], database);
    });

    test(
        "Given an identifier and an identity, when I call storeIdentity and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.storeIdentityTransact(
              transaction: database,
              identifier: identifier,
              identity: identityDTO),
          throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured[0], database);
      expect(captured[1], identifier);
      expect(captured[2], identityDTO.toJson());

      var capturedRemove = verify(storageKeyValueDataSource.remove(
              key: captureAnyNamed('key'),
              database: captureAnyNamed('database')))
          .captured;
      expect(capturedRemove[0], currentIdentifierKey);
      expect(capturedRemove[1], database);

      verifyNever(storageKeyValueDataSource.store(
          key: captureAnyNamed('key'),
          value: captureAnyNamed('value'),
          database: captureAnyNamed('database')));
    });
  });

  group("Remove identity", () {
    setUp(() {
      when(storageKeyValueDataSource.remove(
              key: anyNamed('key'), database: anyNamed('database')))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given an identifier, when I call removeIdentityTransact, then I expect the process to be completed",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.value());

      // When
      await expectLater(
          dataSource.removeIdentityTransact(
              transaction: database, identifier: identifier),
          completes);

      // Then
      var capturedKeyValue = verify(storageKeyValueDataSource.remove(
              key: captureAnyNamed('key'),
              database: captureAnyNamed('database')))
          .captured;
      expect(capturedKeyValue[0], currentIdentifierKey);
      expect(capturedKeyValue[1], database);

      var capturedStore =
          verify(storeRefWrapper.remove(captureAny, captureAny)).captured;
      expect(capturedStore[0], database);
      expect(capturedStore[1], identifier);
    });

    test(
        "Given an identifier, when I call removeIdentity and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storageKeyValueDataSource.remove(
              key: anyNamed('key'), database: anyNamed('database')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.removeIdentityTransact(
              transaction: database, identifier: identifier),
          throwsA(exception));

      // Then
      var capturedKeyValue = verify(storageKeyValueDataSource.remove(
              key: captureAnyNamed('key'),
              database: captureAnyNamed('database')))
          .captured;
      expect(capturedKeyValue[0], currentIdentifierKey);
      expect(capturedKeyValue[1], database);

      verifyNever(storeRefWrapper.remove(captureAny, captureAny));
    });
  });
}
