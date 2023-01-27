import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:sembast/sembast.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import '../dtos/fetch_claim_response_dto_test.dart';
import 'credential_repository_impl_test.mocks.dart';

// Data®
const ids = ["theId", "theId1", "theId2"];
final exception = Exception();

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final claimDTOs = [
  ClaimDTO(
      id: "id1", issuer: "", did: "", type: '', info: fetchClaimDTO.credential),
  ClaimDTO(
      id: "id2", issuer: "", did: "", type: '', info: fetchClaimDTO.credential),
];
final claimEntities = [
  ClaimEntity(
      issuer: "",
      did: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.active,
      id: "id1"),
  ClaimEntity(
      issuer: "",
      did: "",
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

Map<String, Object?> mockDb = {
  "id": "id",
};
String encryptedDb = "theEncryptedDb";
String destinationPath = "theDestinationPath";
String privateKey = "thePrivateKey";
Key encryptionKey = Key(Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]));

IV mockIv = IV(Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));

// Dependencies
MockRemoteClaimDataSource remoteClaimDataSource = MockRemoteClaimDataSource();
MockStorageClaimDataSource storageClaimDataSource =
    MockStorageClaimDataSource();
MockLibIdentityDataSource libIdentityDataSource = MockLibIdentityDataSource();
MockClaimMapper claimMapper = MockClaimMapper();
MockFiltersMapper filtersMapper = MockFiltersMapper();
MockIdFilterMapper idFilterMapper = MockIdFilterMapper();
MockRevocationStatusMapper revocationStatusMapper =
    MockRevocationStatusMapper();
MockEncryptionDbDataSource encryptionDbDataSource =
    MockEncryptionDbDataSource();
MockDestinationPathDataSource destinationPathDataSource =
    MockDestinationPathDataSource();
MockEncryptionKeyMapper encryptionKeyMapper = MockEncryptionKeyMapper();
MockSembastCodec sembastCodec = MockSembastCodec();

// Tested instance
CredentialRepositoryImpl repository = CredentialRepositoryImpl(
  remoteClaimDataSource,
  storageClaimDataSource,
  libIdentityDataSource,
  claimMapper,
  filtersMapper,
  idFilterMapper,
  revocationStatusMapper,
  encryptionDbDataSource,
  destinationPathDataSource,
  encryptionKeyMapper,
);

@GenerateMocks([
  RemoteClaimDataSource,
  StorageClaimDataSource,
  RemoteIdentityDataSource,
  LibIdentityDataSource,
  ClaimMapper,
  FiltersMapper,
  IdFilterMapper,
  RevocationStatusMapper,
  EncryptionDbDataSource,
  DestinationPathDataSource,
  EncryptionKeyMapper,
  SembastCodec,
])
void main() {
  setUp(() {
    if (getItSdk.isRegistered<SembastCodec>(instanceName: sembastCodecName)) {
      getItSdk.unregister<SembastCodec>(instanceName: sembastCodecName);
    }

    getItSdk.registerFactoryParamAsync<SembastCodec, String, String>(
        (_, __) => Future.value(sembastCodec),
        instanceName: sembastCodecName);
  });

  group("Fetch claim", () {
    setUp(() {
      reset(remoteClaimDataSource);
      reset(claimMapper);

      // Given
      when(remoteClaimDataSource.fetchSchema(url: anyNamed('url')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.aMap));
      when(remoteClaimDataSource.fetchVocab(
              schema: anyNamed('schema'), type: anyNamed('type')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.aMap));
      when(remoteClaimDataSource.fetchClaim(
              token: anyNamed('token'),
              url: anyNamed('url'),
              did: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(claimDTOs[0]));
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
    });

    test(
        "Given parameters, when I call fetchClaim, then I expect a ClaimEntity to be returned",
        () async {
      // When
      expect(
          await repository.fetchClaim(
              did: CommonMocks.identifier,
              token: CommonMocks.token,
              message: Iden3commMocks.offerRequest),
          claimEntities[0]);

      // Then
      var fetchCaptured = verify(remoteClaimDataSource.fetchClaim(
              token: captureAnyNamed('token'),
              url: captureAnyNamed('url'),
              did: captureAnyNamed('identifier')))
          .captured;

      expect(fetchCaptured[0], CommonMocks.token);
      expect(fetchCaptured[1], Iden3commMocks.offerUrl);
      expect(fetchCaptured[2], CommonMocks.identifier);

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
              did: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .fetchClaim(
              did: CommonMocks.identifier,
              token: CommonMocks.token,
              message: Iden3commMocks.offerRequest)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<FetchClaimException>());
        expect(error.error, exception);
      });

      // Then
      var fetchCaptured = verify(remoteClaimDataSource.fetchClaim(
              token: captureAnyNamed('token'),
              url: captureAnyNamed('url'),
              did: captureAnyNamed('identifier')))
          .captured;

      expect(fetchCaptured[0], CommonMocks.token);
      expect(fetchCaptured[1], Iden3commMocks.offerUrl);
      expect(fetchCaptured[2], CommonMocks.identifier);

      verifyNever(claimMapper.mapFrom(captureAny));
    });

    test(
        "Given parameters, when I call fetchClaim and an error occurred during fetchVocab, then I expect a ClaimEntity to be returned",
        () async {
      // Given
      when(remoteClaimDataSource.fetchVocab(
              schema: anyNamed('schema'), type: anyNamed('type')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      expect(
          await repository.fetchClaim(
              did: CommonMocks.identifier,
              token: CommonMocks.token,
              message: Iden3commMocks.offerRequest),
          claimEntities[0]);

      // Then
      var fetchCaptured = verify(remoteClaimDataSource.fetchClaim(
              token: captureAnyNamed('token'),
              url: captureAnyNamed('url'),
              did: captureAnyNamed('identifier')))
          .captured;
      expect(fetchCaptured[0], CommonMocks.token);
      expect(fetchCaptured[1], Iden3commMocks.offerUrl);
      expect(fetchCaptured[2], CommonMocks.identifier);

      expect(
          verify(claimMapper.mapFrom(captureAny)).captured.first, claimDTOs[0]);
    });
  });

  group("Save claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.storeClaims(
              did: anyNamed('identifier'),
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
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claims: claimEntities),
          completes);

      // Then
      var captureStore = verify(storageClaimDataSource.storeClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claims: captureAnyNamed('claims')))
          .captured;
      expect(captureStore[0], CommonMocks.identifier);
      expect(captureStore[1], CommonMocks.privateKey);
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
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .saveClaims(
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claims: claimEntities)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<SaveClaimException>());
        expect(error.error, exception);
      });

      // Then
      var captureStore = verify(storageClaimDataSource.storeClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claims: captureAnyNamed('claims')))
          .captured;
      expect(captureStore[0], CommonMocks.identifier);
      expect(captureStore[1], CommonMocks.privateKey);
      expect(captureStore[2], [claimDTOs[0], claimDTOs[0]]);

      verify(claimMapper.mapTo(captureAny));
    });
  });

  group("Get claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.getClaims(
              did: anyNamed('identifier'),
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
            did: CommonMocks.identifier,
            privateKey: CommonMocks.privateKey,
          ),
          [claimEntities[0], claimEntities[0]]);

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);

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
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              filters: filters),
          [claimEntities[0], claimEntities[0]]);

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);
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
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .getClaims(
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              filters: filters)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<GetClaimsException>());
        expect(error.error, exception);
      });

      // Then
      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);
      expect(captureGet[2], filter);

      expect(verify(filtersMapper.mapTo(captureAny)).captured.first, filters);

      verifyNever(claimMapper.mapFrom(captureAny));
    });
  });

  group("Get claim", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.getClaims(
              did: anyNamed('identifier'),
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
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claimId: ids[0]),
          claimEntities[0]);

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);
      expect(captureGet[2], filter);

      expect(
          verify(claimMapper.mapFrom(captureAny)).captured.first, claimDTOs[0]);
    });

    test(
        "Given an id, when I call getClaim and no claim are found, then I expect a ClaimNotFoundException to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.getClaims(
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.value([]));
      // When
      await repository
          .getClaim(
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claimId: ids[0])
          .then((value) => expect(true, false))
          .catchError((error) {
        expect(error, isA<ClaimNotFoundException>());
        expect(error.id, ids[0]);
      });

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);
      expect(captureGet[2], filter);

      verifyNever(claimMapper.mapFrom(captureAny));
    });

    test(
        "Given an id, when I call getClaim and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.getClaims(
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filter: anyNamed('filter')))
          .thenAnswer((realInvocation) => Future.error(exception));
      // When
      await expectLater(
          repository.getClaim(
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claimId: ids[0]),
          throwsA(exception));

      // Then
      expect(verify(idFilterMapper.mapTo(captureAny)).captured.first, ids[0]);

      var captureGet = verify(storageClaimDataSource.getClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filter: captureAnyNamed('filter')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);
      expect(captureGet[2], filter);

      verifyNever(claimMapper.mapFrom(captureAny));
    });
  });

  group("Remove claims", () {
    setUp(() {
      // Given
      when(storageClaimDataSource.removeClaims(
              did: anyNamed('identifier'),
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
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claimIds: ids),
          completes);

      // Then
      var captureRemove = verify(storageClaimDataSource.removeClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(captureRemove[0], CommonMocks.identifier);
      expect(captureRemove[1], CommonMocks.privateKey);
      expect(captureRemove[2], ids);
    });

    test(
        "Given a list of ids, when I call removeClaims and an error occurred, then I expect a RemoveClaimsException exception to be thrown",
        () async {
      // Given
      when(storageClaimDataSource.removeClaims(
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claimIds: anyNamed('claimIds')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await repository
          .removeClaims(
              did: CommonMocks.identifier,
              privateKey: CommonMocks.privateKey,
              claimIds: ids)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<RemoveClaimsException>());
        expect(error.error, exception);
      });

      // Then
      var captureRemove = verify(storageClaimDataSource.removeClaims(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(captureRemove[0], CommonMocks.identifier);
      expect(captureRemove[1], CommonMocks.privateKey);
      expect(captureRemove[2], ids);
    });
  });

  group("Encrypt db", () {
    setUp(() {
      when(storageClaimDataSource.getClaimsDb(
              did: anyNamed('identifier'), privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.value(mockDb));

      when(encryptionKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => encryptionKey);

      when(encryptionDbDataSource.encryptData(
        data: anyNamed('data'),
        key: anyNamed('key'),
      )).thenAnswer((realInvocation) => encryptedDb);
    });

    test(
        "Given an identifier and a privateKey as param, when I call exportEncryptedClaimsDb, then I expect the process to completes",
        () async {
      // When
      expect(
        await repository.exportClaims(
            did: CommonMocks.identifier, privateKey: CommonMocks.privateKey),
        encryptedDb,
      );

      // Then
      var captureGet = verify(storageClaimDataSource.getClaimsDb(
              did: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(captureGet[0], CommonMocks.identifier);
      expect(captureGet[1], CommonMocks.privateKey);

      var captureEncryptionKeyMapper =
          verify(encryptionKeyMapper.mapFrom(captureAny)).captured;
      expect(captureEncryptionKeyMapper[0], CommonMocks.privateKey);

      var captureEncrypt = verify(encryptionDbDataSource.encryptData(
        data: captureAnyNamed('data'),
        key: captureAnyNamed('key'),
      )).captured;
      expect(captureEncrypt[0], mockDb);
      expect(captureEncrypt[1], encryptionKey);
    });
  });

  group("Decrypt an imported encrypted claims db", () {
    setUp(() {
      when(encryptionDbDataSource.decryptData(
        encryptedData: anyNamed('encryptedData'),
        key: anyNamed('key'),
      )).thenAnswer((realInvocation) => mockDb);

      when(encryptionKeyMapper.mapFrom(any))
          .thenAnswer((realInvocation) => encryptionKey);

      when(destinationPathDataSource.getDestinationPath(
              did: anyNamed('identifier')))
          .thenAnswer((realInvocation) => Future.value(destinationPath));

      when(storageClaimDataSource.saveClaimsDb(
        exportableDb: anyNamed('exportableDb'),
        databaseFactory: anyNamed('databaseFactory'),
        destinationPath: anyNamed('destinationPath'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given an encrypted db, a privateKey and an identinfier, when I call importEncryptedClaimsDb, then I expect the process to completes",
        () {
      // When
      expect(
        repository.importClaims(
            encryptedDb: encryptedDb,
            privateKey: CommonMocks.privateKey,
            did: CommonMocks.identifier),
        completes,
      );
    });
  });
}
