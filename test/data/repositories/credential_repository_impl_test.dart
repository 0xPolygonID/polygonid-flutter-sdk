import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/credential/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/data/credential/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/data/credential/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/credential_request_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data_entity.dart';

import '../dtos/fetch_claim_response_dto_test.dart';
import 'credential_repository_impl_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const token = "theToken";
const url = "theUrl";
final exception = Exception();

final CredentialRequestEntity requestEntity = CredentialRequestEntity(
    "",
    CircuitDataEntity("", Uint8List.fromList([]), Uint8List.fromList([])),
    url,
    "",
    "",
    "");

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final claimDTO =
    ClaimDTO(issuer: "", identifier: "", credential: fetchClaimDTO.credential);
final claimEntities = [
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      data: {},
      type: "",
      state: ClaimState.active,
      id: "id1"),
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      data: {},
      type: "",
      state: ClaimState.active,
      id: "id2")
];

// Dependencies
MockRemoteClaimDataSource remoteClaimDataSource = MockRemoteClaimDataSource();
MockStorageClaimDataSource storageClaimDataSource =
    MockStorageClaimDataSource();
MockCredentialRequestMapper credentialRequestMapper =
    MockCredentialRequestMapper();
MockClaimMapper claimMapper = MockClaimMapper();

// Tested instance
CredentialRepositoryImpl repository = CredentialRepositoryImpl(
    remoteClaimDataSource,
    storageClaimDataSource,
    credentialRequestMapper,
    claimMapper);

@GenerateMocks([
  RemoteClaimDataSource,
  StorageClaimDataSource,
  CredentialRequestMapper,
  ClaimMapper
])
void main() {
  group("Fetch claim", () {
    setUp(() {
      reset(remoteClaimDataSource);
      reset(claimMapper);

      // Given
      when(remoteClaimDataSource.fetchClaim(
              token: anyNamed('token'),
              url: anyNamed('url'),
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(claimDTO));
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
    });

    test(
        "Given parameters, when I call fetchClaim, then I expect a ClaimEntity to be returned",
        () async {
      // When
      expect(
          await repository.fetchClaim(
              identifier: identifier,
              token: token,
              credentialRequest: requestEntity),
          claimEntities[0]);

      // Then
      var fetchCaptured = verify(remoteClaimDataSource.fetchClaim(
              token: captureAnyNamed('token'),
              url: captureAnyNamed('url'),
              identifier: captureAnyNamed('identifier')))
          .captured;

      expect(fetchCaptured[0], token);
      expect(fetchCaptured[1], url);
      expect(fetchCaptured[2], identifier);

      expect(verify(claimMapper.mapFrom(captureAny)).captured.first, claimDTO);
    });

    test(
        "Given parameters, when I call fetchClaim and an error occurred, then I expect a FetchClaimException to be thrown",
        () async {
      // Given
      when(remoteClaimDataSource.fetchClaim(
              token: anyNamed('token'),
              url: anyNamed('url'),
              identifier: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .fetchClaim(
              identifier: identifier,
              token: token,
              credentialRequest: requestEntity)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<FetchClaimException>());
        expect(error.error, exception);
      });

      // Then
      var fetchCaptured = verify(remoteClaimDataSource.fetchClaim(
              token: captureAnyNamed('token'),
              url: captureAnyNamed('url'),
              identifier: captureAnyNamed('identifier')))
          .captured;

      expect(fetchCaptured[0], token);
      expect(fetchCaptured[1], url);
      expect(fetchCaptured[2], identifier);

      verifyNever(claimMapper.mapFrom(captureAny));
    });
  });

  group("Save claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.storeClaims(claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value());
      when(claimMapper.mapTo(any)).thenReturn(claimDTO);
    });

    test(
        "Given a list of ClaimEntity, when I call saveClaims, then I expect the process to complete",
        () async {
      // When
      await expectLater(
          repository.saveClaims(claims: claimEntities), completes);

      // Then
      expect(
          verify(storageClaimDataSource.storeClaims(
                  claims: captureAnyNamed('claims')))
              .captured
              .first,
          [claimDTO, claimDTO]);

      var mapperVerify = verify(claimMapper.mapTo(captureAny));
      expect(mapperVerify.callCount, claimEntities.length);
      for (int i = 0; i < claimEntities.length; i++) {
        expect(mapperVerify.captured[i], claimEntities[i]);
      }
    });

    test(
        "Given a list of ClaimEntity, when I call saveClaims and an error occurred, then I expect a SaveClaimException to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.storeClaims(claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .saveClaims(claims: claimEntities)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<SaveClaimException>());
        expect(error.error, exception);
      });

      // Then
      expect(
          verify(storageClaimDataSource.storeClaims(
                  claims: captureAnyNamed('claims')))
              .captured
              .first,
          [claimDTO, claimDTO]);

      verify(claimMapper.mapTo(captureAny));
    });
  });
}
