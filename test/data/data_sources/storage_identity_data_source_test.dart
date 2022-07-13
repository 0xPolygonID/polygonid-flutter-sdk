import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:sembast/sembast.dart';

import 'storage_identity_data_source_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
final mockGet = {
  'privateKey': privateKey,
  'identifier': identifier,
  'authClaim': authClaim
};
final identityDTO = IdentityDTO.fromJson(mockGet);
final exception = Exception();

// Dependencies
MockDatabase database = MockDatabase();
MockIdentityStoreRefWrapper storeRefWrapper = MockIdentityStoreRefWrapper();

// Tested instance
StorageIdentityDataSource dataSource =
    StorageIdentityDataSource(database, storeRefWrapper);

@GenerateMocks([Database, IdentityStoreRefWrapper])
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
      expect(await dataSource.getIdentity(identifier: identifier), null);

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
    test(
        "Given an identifier and an identity, when I call storeIdentity, then I expect the process to be completed",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.value(mockGet));

      // When
      await expectLater(
          dataSource.storeIdentity(
              identifier: identifier, identity: identityDTO),
          completes);

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured[0], database);
      expect(captured[1], identifier);
      expect(captured[2], identityDTO.toJson());
    });

    test(
        "Given an identifier and an identity, when I call storeIdentity and an error occurred, then I expect an exception to be thrown",
            () async {
          // Given
          when(storeRefWrapper.put(any, any, any))
              .thenAnswer((realInvocation) => Future.error(exception));

          // When
          await expectLater(
              dataSource.storeIdentity(
                  identifier: identifier, identity: identityDTO),
              throwsA(exception));

          // Then
          var captured =
              verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
                  .captured;
          expect(captured[0], database);
          expect(captured[1], identifier);
          expect(captured[2], identityDTO.toJson());
        });
  });
}
