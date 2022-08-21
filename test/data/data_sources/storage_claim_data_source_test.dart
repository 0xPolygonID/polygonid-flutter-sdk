import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/fetch_claim_response_dto.dart';
import 'package:sembast/sembast.dart' as sem;

import '../dtos/fetch_claim_response_dto_test.dart';
import 'storage_claim_data_source_test.mocks.dart';

class FakeRecordSnapshot
    implements sem.RecordSnapshot<String, Map<String, Object?>> {
  @override
  Object? operator [](String field) {
    throw UnimplementedError();
  }

  @override
  sem.RecordSnapshot<RK, RV> cast<RK, RV>() {
    throw UnimplementedError();
  }

  @override
  String get key => throw UnimplementedError();

  @override
  sem.RecordRef<String, Map<String, Object?>> get ref =>
      throw UnimplementedError();

  @override
  Map<String, Object?> get value => mockClaims[0].toJson();
}

// Data
const issuers = ["theIssuer", "theIssuer1", "theIssuer2"];
const identifiers = ["theIdentifier", "theIdentifier1", "theIdentifier2"];
const ids = ["theId", "theId1", "theId2"];
final snapshots = [
  FakeRecordSnapshot(),
  FakeRecordSnapshot(),
  FakeRecordSnapshot()
];
final sem.Filter filter =
    sem.Filter.and([sem.Filter.equals("theField", "theValue")]);

/// We assume [FetchClaimResponseDTO] has been tested
final credential =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim)).credential;
final mockClaims = [
  ClaimDTO(
      id: credential.id,
      issuer: issuers[0],
      identifier: identifiers[0],
      credential: credential),
  ClaimDTO(
      id: credential.id,
      issuer: issuers[1],
      identifier: identifiers[1],
      credential: credential),
  ClaimDTO(
      id: credential.id,
      issuer: issuers[2],
      identifier: identifiers[2],
      credential: credential)
];
final exception = Exception();

// Dependencies
MockDatabase database = MockDatabase();
MockClaimStoreRefWrapper storeRefWrapper = MockClaimStoreRefWrapper();

// Tested instance
StorageClaimDataSource dataSource =
    StorageClaimDataSource(database, storeRefWrapper);

@GenerateMocks([sem.Database, ClaimStoreRefWrapper])
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

  group("Get claims", () {
    test(
        "Given nothing, when I call getClaims, then I expect a list of claims to be returned",
        () async {
      // Given
      when(storeRefWrapper.find(any, finder: anyNamed("finder")))
          .thenAnswer((realInvocation) => Future.value(snapshots));

      // When
      expect(await dataSource.getClaims(), isA<List<ClaimDTO>>());

      // Then
      var storeCaptured = verify(storeRefWrapper.find(captureAny,
              finder: captureAnyNamed("finder")))
          .captured;

      expect(storeCaptured[0], database);
      expect(storeCaptured[1].toString(), sem.Finder(filter: null).toString());
    });

    test(
        "Given a Filter, when I call getClaims, then I expect a list of claims to be returned",
        () async {
      // Given
      when(storeRefWrapper.find(any, finder: anyNamed("finder")))
          .thenAnswer((realInvocation) => Future.value(snapshots));

      // When
      expect(await dataSource.getClaims(filter: filter), isA<List<ClaimDTO>>());

      // Then
      var storeCaptured = verify(storeRefWrapper.find(captureAny,
              finder: captureAnyNamed("finder")))
          .captured;

      expect(storeCaptured[0], database);
      expect(
          storeCaptured[1].toString(), sem.Finder(filter: filter).toString());
    });

    test(
        "Given a Filter, when I call getClaims and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.find(any, finder: anyNamed("finder")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.getClaims(filter: filter), throwsA(exception));

      // Then
      var storeCaptured = verify(storeRefWrapper.find(captureAny,
              finder: captureAnyNamed("finder")))
          .captured;

      expect(storeCaptured[0], database);
      expect(
          storeCaptured[1].toString(), sem.Finder(filter: filter).toString());
    });
  });

  group("Remove claims", () {
    test(
        "Given a list of ids, when I call removeClaims, then I expect the process to complete",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.value(""));

      // When
      await expectLater(
          dataSource.removeClaimsTransact(transaction: database, ids: ids),
          completes);

      // Then
      var storeVerify = verify(storeRefWrapper.remove(captureAny, captureAny));
      expect(storeVerify.callCount, ids.length);

      int j = 0;
      for (int i = 0; i < ids.length; i += 2) {
        expect(storeVerify.captured[i], database);
        expect(storeVerify.captured[i + 1], ids[j]);
        j++;
      }
    });

    test(
        "Given a list of ids, when I call removeClaims and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storeRefWrapper.remove(any, any))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          dataSource.removeClaimsTransact(transaction: database, ids: ids),
          throwsA(exception));

      // Then
      var storeVerify = verify(storeRefWrapper.remove(captureAny, captureAny));
      expect(storeVerify.callCount, 1);
      expect(storeVerify.captured[0], database);
      expect(storeVerify.captured[1], ids[0]);
    });
  });
}
