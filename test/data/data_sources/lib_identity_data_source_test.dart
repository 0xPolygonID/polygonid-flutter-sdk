import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/libs/iden3core/iden3core.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/exceptions/proof_generation_exceptions.dart';

import 'lib_identity_data_source_test.mocks.dart';

// Data
const id = "theId";
const otherId = "theOtherId";
const pubX = "thePubX";
const pubY = "thePubY";
const identifier = "3DFF";
const authClaim = "theAuthClaim";
const resultIdentifier = "5ie";
const mockCoreIdentity = {"id": identifier, "authClaim": authClaim};
var exception = Exception();

// Dependencies
MockIden3CoreLib coreLib = MockIden3CoreLib();

// Tested instance
LibIdentityDataSource dataSource = LibIdentityDataSource(coreLib);

@GenerateMocks([Iden3CoreLib])
void main() {
  group("Get the id", () {
    test("Given an id, when I call getId, then I expect an id to be returned",
        () async {
      // Given
      when(coreLib.getIdFromString(any)).thenReturn(otherId);

      // When
      expect(await dataSource.getId(id), otherId);

      // Then
      expect(verify(coreLib.getIdFromString(captureAny)).captured.first, id);
    });

    test(
        "Given an id, when I call getId and the generated id is empty, then I expect a GenerateNonRevProofException to be thrown",
        () async {
      // Given
      when(coreLib.getIdFromString(any)).thenReturn("");

      // When
      await dataSource
          .getId(id)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<GenerateNonRevProofException>());
        expect(error.error, id);
      });

      // Then
      expect(verify(coreLib.getIdFromString(captureAny)).captured.first, id);
    });

    test(
        "Given an id, when I call getId and an error occured, then I expect an exception to be thrown",
        () async {
      // Given
      when(coreLib.getIdFromString(any)).thenThrow(exception);

      // When
      await expectLater(dataSource.getId(id), throwsA(exception));

      // Then
      expect(verify(coreLib.getIdFromString(captureAny)).captured.first, id);
    });
  });

  /*group("Get identifier", () {
    test(
        "Given a pubX and a pubY, when I call getIdentifier, then I expect an identifier to be returned",
        () async {
      // Given
      when(coreLib.generateIdentity(any, any))
          .thenAnswer((realInvocation) => mockCoreIdentity);

      // When
      expect(await dataSource.getIdentifier(pubX: pubX, pubY: pubY),
          resultIdentifier);

      // Then
      var captured =
          verify(coreLib.generateIdentity(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });

    test(
        "Given a pubX and a pubY, when I call getIdentifier and an error occured, then I expect an error is thrown",
        () async {
      // Given
      when(coreLib.generateIdentity(any, any)).thenThrow(exception);

      // When
      await expectLater(
          dataSource.getIdentifier(pubX: pubX, pubY: pubY), throwsA(exception));

      // Then
      var captured =
          verify(coreLib.generateIdentity(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });
  });*/

  group("Get auth claim", () {
    test(
        "Given a pubX and a pubY, when I call getAuthclaim, then I expect an authclaim to be returned",
        () async {
      // Given
      when(coreLib.getAuthClaim(any, any))
          .thenAnswer((realInvocation) => authClaim);

      // When
      expect(await dataSource.getAuthClaim(pubX: pubX, pubY: pubY), authClaim);

      // Then
      var captured =
          verify(coreLib.getAuthClaim(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });

    test(
        "Given a pubX and a pubY, when I call getAuthclaim and an error occured, then I expect an error is thrown",
        () async {
      // Given
      when(coreLib.getAuthClaim(any, any)).thenThrow(exception);

      // When
      await expectLater(
          dataSource.getAuthClaim(pubX: pubX, pubY: pubY), throwsA(exception));

      // Then
      var captured =
          verify(coreLib.getAuthClaim(captureAny, captureAny)).captured;
      expect(captured[0], pubX);
      expect(captured[1], pubY);
    });
  });
}
