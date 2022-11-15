import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/credential_request_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:sembast/sembast.dart';

import '../dtos/fetch_claim_response_dto_test.dart';
import 'credential_repository_impl_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const token = "theToken";
const url = "theUrl";
const ids = ["theId", "theId1", "theId2"];
final exception = Exception();

final CredentialRequestEntity requestEntity =
    CredentialRequestEntity("", url, "", "", "");

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final claimDTOs = [
  ClaimDTO(
      id: "id1",
      issuer: "",
      identifier: "",
      type: '',
      info: fetchClaimDTO.credential),
  ClaimDTO(
      id: "id2",
      issuer: "",
      identifier: "",
      type: '',
      info: fetchClaimDTO.credential),
];
final claimEntities = [
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.active,
      id: "id1"),
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.active,
      id: "id2")
];
final filters = [
  FilterEntity(name: "theName", value: "theValue"),
  FilterEntity(name: "theName1", value: "theValue1"),
  FilterEntity(name: "theName2", value: "theValue2")
];
final filter = Filter.equals("theField", "theValue");

// Dependencies
MockRemoteClaimDataSource remoteClaimDataSource = MockRemoteClaimDataSource();
MockStorageClaimDataSource storageClaimDataSource =
    MockStorageClaimDataSource();
MockLibIdentityDataSource libIdentityDataSource =
    MockLibIdentityDataSource();
MockCredentialRequestMapper credentialRequestMapper =
    MockCredentialRequestMapper();
MockClaimMapper claimMapper = MockClaimMapper();
MockFiltersMapper filtersMapper = MockFiltersMapper();
MockIdFilterMapper idFilterMapper = MockIdFilterMapper();
MockRevocationStatusMapper revocationStatusMapper =
    MockRevocationStatusMapper();

// Tested instance
CredentialRepositoryImpl repository = CredentialRepositoryImpl(
  remoteClaimDataSource,
  storageClaimDataSource,
  libIdentityDataSource,
  credentialRequestMapper,
  claimMapper,
  filtersMapper,
  idFilterMapper,
  revocationStatusMapper,
);

@GenerateMocks([
  RemoteClaimDataSource,
  StorageClaimDataSource,
  RemoteIdentityDataSource,
  LibIdentityDataSource,
  CredentialRequestMapper,
  ClaimMapper,
  FiltersMapper,
  IdFilterMapper,
  RevocationStatusMapper,
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
          .thenAnswer((realInvocation) => Future.value(claimDTOs[0]));
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

      expect(
          verify(claimMapper.mapFrom(captureAny)).captured.first, claimDTOs[0]);
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
      when(storageClaimDataSource.storeClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value());
      when(claimMapper.mapTo(any)).thenReturn(claimDTOs[0]);
    });

    test(
        "Given a list of ClaimEntity, when I call saveClaims, then I expect the process to complete",
        () async {
      // When
      await expectLater(
          repository.saveClaims(
              identifier: identifier,
              privateKey: privateKey,
              claims: claimEntities),
          completes);

      // Then
      var captureStore = verify(storageClaimDataSource.storeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claims: captureAnyNamed('claims')))
          .captured;
      expect(captureStore[0], identifier);
      expect(captureStore[1], privateKey);
      expect(captureStore[2], [claimDTOs[0], claimDTOs[0]]);

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
      when(storageClaimDataSource.storeClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .saveClaims(
              identifier: identifier,
              privateKey: privateKey,
              claims: claimEntities)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<SaveClaimException>());
        expect(error.error, exception);
      });

      // Then
      var captureStore = verify(storageClaimDataSource.storeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claims: captureAnyNamed('claims')))
          .captured;
      expect(captureStore[0], identifier);
      expect(captureStore[1], privateKey);
      expect(captureStore[2], [claimDTOs[0], claimDTOs[0]]);

      verify(claimMapper.mapTo(captureAny));
    });
  });

  group("Get claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.value(claimDTOs));
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
      when(filtersMapper.mapTo(any)).thenReturn(filter);
    });

    test(
        "Given nothing, when I call getClaims, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(
          await repository.getClaims(
            identifier: identifier,
            privateKey: privateKey,
          ),
          [claimEntities[0], claimEntities[0]]);

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);

      verifyNever(filtersMapper.mapTo(captureAny));

      var mapperVerify = verify(claimMapper.mapFrom(captureAny));
      expect(mapperVerify.callCount, claimDTOs.length);
      for (int i = 0; i < claimDTOs.length; i++) {
        expect(mapperVerify.captured[i], claimDTOs[i]);
      }
    });

    test(
        "Given a list of FilterEntity, when I call getClaims, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(
          await repository.getClaims(
              identifier: identifier, privateKey: privateKey, filters: filters),
          [claimEntities[0], claimEntities[0]]);

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);
      expect(captureGet[2], filter);

      expect(verify(filtersMapper.mapTo(captureAny)).captured.first, filters);

      var mapperVerify = verify(claimMapper.mapFrom(captureAny));
      expect(mapperVerify.callCount, claimDTOs.length);
      for (int i = 0; i < claimDTOs.length; i++) {
        expect(mapperVerify.captured[i], claimDTOs[i]);
      }
    });

    test(
        "Given a list of FilterEntity, when I call getClaims and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .getClaims(
              identifier: identifier, privateKey: privateKey, filters: filters)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<GetClaimsException>());
        expect(error.error, exception);
      });

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);
      expect(captureGet[2], filter);

      expect(verify(filtersMapper.mapTo(captureAny)).captured.first, filters);

      verifyNever(claimMapper.mapFrom(captureAny));
    });
  });

  group("Get claim", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.value([claimDTOs[0]]));
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
      when(idFilterMapper.mapTo(any)).thenReturn(filter);
    });

    test(
        "Given an id, when I call getClaim, then I expect a ClaimEntity to be returned",
        () async {
      // When
      expect(
          await repository.getClaim(
              identifier: identifier, privateKey: privateKey, claimId: ids[0]),
          claimEntities[0]);

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);
      expect(captureGet[2], filter);

      expect(
          verify(claimMapper.mapFrom(captureAny)).captured.first, claimDTOs[0]);
    });

    test(
        "Given an id, when I call getClaim and no claim are found, then I expect a ClaimNotFoundException to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.value([]));
      // When
      await repository
          .getClaim(
              identifier: identifier, privateKey: privateKey, claimId: ids[0])
          .then((value) => expect(true, false))
          .catchError((error) {
        expect(error, isA<ClaimNotFoundException>());
        expect(error.id, ids[0]);
      });

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);
      expect(captureGet[2], filter);

      verifyNever(claimMapper.mapFrom(captureAny));
    });

    test(
        "Given an id, when I call getClaim and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.error(exception));
      // When
      await expectLater(
          repository.getClaim(
              identifier: identifier, privateKey: privateKey, claimId: ids[0]),
          throwsA(exception));

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], identifier);
      expect(captureGet[1], privateKey);
      expect(captureGet[2], filter);

      verifyNever(claimMapper.mapFrom(captureAny));
    });
  });

  group("Remove claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.removeClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claimIds: anyNamed('claimIds')))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given a list of ids, when I call removeClaims, then I expect the process to completes",
        () async {
      // When
      await expectLater(
          repository.removeClaims(
              identifier: identifier, privateKey: privateKey, claimIds: ids),
          completes);

      // Then
      var captureRemove = verify(storageClaimDataSource.removeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(captureRemove[0], identifier);
      expect(captureRemove[1], privateKey);
      expect(captureRemove[2], ids);
    });

    test(
        "Given a list of ids, when I call removeClaims and an error occurred, then I expect a RemoveClaimsException exception to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.removeClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claimIds: anyNamed('claimIds')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .removeClaims(
              identifier: identifier, privateKey: privateKey, claimIds: ids)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<RemoveClaimsException>());
        expect(error.error, exception);
      });

      // Then
      var captureRemove = verify(storageClaimDataSource.removeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(captureRemove[0], identifier);
      expect(captureRemove[1], privateKey);
      expect(captureRemove[2], ids);
    });
  });
}
