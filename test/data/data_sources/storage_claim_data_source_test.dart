import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/credential/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/fetch_claim_response_dto.dart';
import 'package:sembast/sembast.dart';

import '../dtos/fetch_claim_response_dto_test.dart';
import 'storage_claim_data_source_test.mocks.dart';

// Data
const issuers = ["theIssuer", "theIssuer1", "theIssuer2"];
const identifiers = ["theIdentifier", "theIdentifier1", "theIdentifier2"];

/// We assume [FetchClaimResponseDTO] has been tested
final credential =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim)).credential;
final mockClaims = [
  ClaimDTO(
      issuer: issuers[0], identifier: identifiers[0], credential: credential),
  ClaimDTO(
      issuer: issuers[1], identifier: identifiers[1], credential: credential),
  ClaimDTO(
      issuer: issuers[2], identifier: identifiers[2], credential: credential)
];
final exception = Exception();

// Dependencies
MockDatabase database = MockDatabase();
MockClaimStoreRefWrapper storeRefWrapper = MockClaimStoreRefWrapper();

// Tested instance
StorageClaimDataSource dataSource =
    StorageClaimDataSource(database, storeRefWrapper);

@GenerateMocks([Database, ClaimStoreRefWrapper])
void main() {
  group("Store claims", () {
    test(
        "Given a list of claims, when I call storeClaims, then I expect the claims to be saved in storage",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.value({}));

      // When
      await expectLater(
          dataSource.storeClaimsTransact(
              transaction: database, claims: mockClaims),
          completes);

      // Then
      var storeVerify =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny));
      expect(storeVerify.callCount, 3);

      int j = 0;
      for (int i = 0; i < mockClaims.length; i += 3) {
        expect(storeVerify.captured[i], database);
        expect(storeVerify.captured[i + 1], mockClaims[j].id);
        expect(storeVerify.captured[i + 2], mockClaims[j].toJson());
        j++;
      }
    });

    test(
        "Given a list of claims, when I call storeClaims and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.put(any, any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.storeClaimsTransact(
              transaction: database, claims: mockClaims),
          throwsA(exception));

      // Then
      var captured =
          verify(storeRefWrapper.put(captureAny, captureAny, captureAny))
              .captured;
      expect(captured.length, mockClaims.length);
      expect(captured[0], database);
      expect(captured[1], mockClaims[0].id);
      expect(captured[2], mockClaims[0].toJson());
    });
  });
}
