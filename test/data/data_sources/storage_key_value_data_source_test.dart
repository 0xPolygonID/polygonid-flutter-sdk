import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_key_value_data_source.dart';
import 'package:sembast/sembast.dart';

import 'storage_key_value_data_source_test.mocks.dart';

// Data
const key = 'key';
const value = 'value';
final exception = Exception();

// Dependencies
MockDatabase database = MockDatabase();
MockDatabase anotherDatabase = MockDatabase();
MockKeyValueStoreRefWrapper storeRefWrapper = MockKeyValueStoreRefWrapper();

// Tested instance
StorageKeyValueDataSource dataSource =
    StorageKeyValueDataSource(database, storeRefWrapper);

@GenerateMocks([Database, KeyValueStoreRefWrapper])
void main() {
  group("Get", () {
    test(
        "Given a key with an already stored value, when I call get, then I expect a value to be returned",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.value(value));

      // When
      expect(await dataSource.get(key: key), value);

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], key);
    });

    test(
        "Given a key with no associated stored value, when I call get, then I expect a null to be returned",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.value(null));

      // When
      expect(await dataSource.get(key: key), null);

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], key);
    });

    test(
        "Given a key and another database, with an already stored value, when I call get, then I expect a value to be returned",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.value(value));

      // When
      expect(await dataSource.get(key: key, database: anotherDatabase), value);

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], anotherDatabase);
      expect(captured[1], key);
    });

    test(
        "Given a key, when I call get and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.get(any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(dataSource.get(key: key), throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.get(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], key);
    });
  });

  group("Store", () {
    test(
        "Given a key and value, when I call store, then I expect the process to complete",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.value(value));

      // When
      await expectLater(dataSource.store(key: key, value: value), completes);

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured[0], database);
      expect(captured[1], key);
      expect(captured[2], value);
    });

    test(
        "Given a key and value, with another database, when I call store, then I expect the process to complete",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.value(value));

      // When
      await expectLater(
          dataSource.store(key: key, value: value, database: anotherDatabase),
          completes);

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured[0], anotherDatabase);
      expect(captured[1], key);
      expect(captured[2], value);
    });

    test(
        "Given a key and value, when I call store and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.store(key: key, value: value), throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured[0], database);
      expect(captured[1], key);
      expect(captured[2], value);
    });
  });

  group("Remove", () {
    test(
        "Given a key with an already stored value, when I call remove, then I expect the process to complete",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.value());

      // When
      await expectLater(dataSource.remove(key: key), completes);

      // Then
      var captured =
          verify(storeRefWrapper.remove(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], key);
    });

    test(
        "Given a key and another database, with an already stored value, when I call remove, then I expect the process to complete",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.value());

      // When
      await expectLater(
          dataSource.remove(key: key, database: anotherDatabase), completes);

      // Then
      var captured =
          verify(storeRefWrapper.remove(captureAny, captureAny)).captured;
      expect(captured[0], anotherDatabase);
      expect(captured[1], key);
    });

    test(
        "Given a key, when I call remove and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(dataSource.remove(key: key), throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.remove(captureAny, captureAny)).captured;
      expect(captured[0], database);
      expect(captured[1], key);
    });
  });
}
