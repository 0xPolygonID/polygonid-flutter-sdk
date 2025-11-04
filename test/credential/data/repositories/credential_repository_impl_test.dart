import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/data/credential_repository_impl.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/credential_cache_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/local_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_issuance_response.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:sembast/sembast.dart';

import '../../../common/common_mocks.dart';
import '../../../iden3comm/data/dtos/credential_issuance_message_test.dart';
import 'credential_repository_impl_test.mocks.dart';

// Data®
const ids = ["theId", "theId1", "theId2"];
final exception = Exception();
final CredentialNotFoundException claimNotFoundException =
    CredentialNotFoundException(id: ids[0], errorMessage: "Claim not found");

/// We assume [FetchClaimResponseDTO] has been tested
final issuanceMessage = CredentialIssuanceMessage.fromJson(
  jsonDecode(mockIssuanceMessage),
);
final claimDTOs = [
  CredentialDTO(
    id: "id1",
    issuer: "",
    did: "",
    type: '',
    info: issuanceMessage.body.credential,
    credentialRawValue: mockIssuanceMessage,
  ),
  CredentialDTO(
    id: "id2",
    issuer: "",
    did: "",
    type: '',
    info: issuanceMessage.body.credential,
    credentialRawValue: mockIssuanceMessage,
  ),
];
final claimEntities = [
  CredentialEntity(
    issuer: "",
    did: "",
    expiration: "",
    info: {},
    type: "",
    state: CredentialState.active,
    id: "id1",
    credentialRawValue: mockIssuanceMessage,
  ),
  CredentialEntity(
    issuer: "",
    did: "",
    expiration: "",
    info: {},
    type: "",
    state: CredentialState.active,
    id: "id2",
    credentialRawValue: mockIssuanceMessage,
  ),
];
final filters = [
  FilterEntity(name: "theName", value: "theValue"),
  FilterEntity(name: "theName1", value: "theValue1"),
  FilterEntity(name: "theName2", value: "theValue2"),
];
final filter = Filter.equals("theField", "theValue");

// Dependencies
MockRemoteClaimDataSource remoteClaimDataSource = MockRemoteClaimDataSource();
MockCredentialStorageDataSource storageClaimDataSource =
    MockCredentialStorageDataSource();
MockLocalClaimDataSource localClaimDataSource = MockLocalClaimDataSource();
MockCredentialCacheDataSource cacheCredentialDataSource =
    MockCredentialCacheDataSource();
MockCredentialMapper claimMapper = MockCredentialMapper();
MockFiltersMapper filtersMapper = MockFiltersMapper();
MockGetEnvUseCase getEnvUseCase = MockGetEnvUseCase();
MockLocalContractFilesDataSource localContractFilesDataSource =
    MockLocalContractFilesDataSource();
MockIdentityRepository identityRepository = MockIdentityRepository();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
CredentialRepositoryImpl repository = CredentialRepositoryImpl(
  remoteClaimDataSource,
  storageClaimDataSource,
  localClaimDataSource,
  cacheCredentialDataSource,
  claimMapper,
  filtersMapper,
  getEnvUseCase,
  localContractFilesDataSource,
  identityRepository,
  stacktraceManager,
);

@GenerateMocks([
  RemoteClaimDataSource,
  CredentialStorageDataSource,
  LocalClaimDataSource,
  CredentialCacheDataSource,
  CredentialMapper,
  FiltersMapper,
  GetEnvUseCase,
  LocalContractFilesDataSource,
  IdentityRepository,
  StacktraceManager,
])
void main() {
  group("Save claims", () {
    setUp(() {
      // Given
      when(
        storageClaimDataSource.storeCredentials(
          did: anyNamed('did'),
          encryptionKey: anyNamed('encryptionKey'),
          credentials: anyNamed('credentials'),
        ),
      ).thenAnswer((realInvocation) => Future.value());
      when(claimMapper.mapTo(any)).thenReturn(claimDTOs[0]);
    });

    test(
      "Given a list of ClaimEntity, when I call saveClaims, then I expect the process to complete",
      () async {
        // When
        await expectLater(
          repository.saveCredentials(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
            credentials: claimEntities,
          ),
          completes,
        );

        // Then
        var captureStore = verify(
          storageClaimDataSource.storeCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentials: captureAnyNamed('credentials'),
          ),
        ).captured;
        expect(captureStore[0], CommonMocks.identifier);
        expect(captureStore[1], CommonMocks.encryptionKey);
        expect(captureStore[2], [claimDTOs[0], claimDTOs[0]]);

        var mapperVerify = verify(claimMapper.mapTo(captureAny));
        expect(mapperVerify.callCount, claimEntities.length);
        for (int i = 0; i < claimEntities.length; i++) {
          expect(mapperVerify.captured[i], claimEntities[i]);
        }
      },
    );

    test(
      "Given a list of ClaimEntity, when I call saveClaims and an error occurred, then I expect a SaveClaimException to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.storeCredentials(
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
            credentials: anyNamed('credentials'),
          ),
        ).thenAnswer((realInvocation) => Future.error(exception));

        // When
        await repository
            .saveCredentials(
              genesisDid: CommonMocks.identifier,
              encryptionKey: CommonMocks.encryptionKey,
              credentials: claimEntities,
            )
            .then((_) => expect(true, false))
            .catchError((error) {
              expect(error, isA<SaveClaimException>());
              expect(error.error, exception);
            });

        // Then
        var captureStore = verify(
          storageClaimDataSource.storeCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentials: captureAnyNamed('credentials'),
          ),
        ).captured;
        expect(captureStore[0], CommonMocks.identifier);
        expect(captureStore[1], CommonMocks.encryptionKey);
        expect(captureStore[2], [claimDTOs[0], claimDTOs[0]]);

        verify(claimMapper.mapTo(captureAny));
      },
    );
  });

  group("Get claims", () {
    setUp(() {
      // Given
      when(
        storageClaimDataSource.getCredentials(
          did: anyNamed('did'),
          encryptionKey: anyNamed('encryptionKey'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((realInvocation) => Future.value(claimDTOs));
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
      when(filtersMapper.mapTo(any)).thenReturn(filter);
    });

    test(
      "Given nothing, when I call getClaims, then I expect a list of ClaimEntity to be returned",
      () async {
        // When
        expect(
          await repository.getCredentials(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
          ),
          [claimEntities[0], claimEntities[0]],
        );

        // Then
        var captureGet = verify(
          storageClaimDataSource.getCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
          ),
        ).captured;
        expect(captureGet[0], CommonMocks.identifier);
        expect(captureGet[1], CommonMocks.encryptionKey);

        verifyNever(filtersMapper.mapTo(captureAny));

        var mapperVerify = verify(claimMapper.mapFrom(captureAny));
        expect(mapperVerify.callCount, claimDTOs.length);
        for (int i = 0; i < claimDTOs.length; i++) {
          expect(mapperVerify.captured[i], claimDTOs[i]);
        }
      },
    );

    test(
      "Given a list of FilterEntity, when I call getClaims, then I expect a list of ClaimEntity to be returned",
      () async {
        // When
        expect(
          await repository.getCredentials(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
            filters: filters,
          ),
          [claimEntities[0], claimEntities[0]],
        );

        // Then
        var captureGet = verify(
          storageClaimDataSource.getCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            filter: captureAnyNamed('filter'),
          ),
        ).captured;
        expect(captureGet[0], CommonMocks.identifier);
        expect(captureGet[1], CommonMocks.encryptionKey);
        expect(captureGet[2], filter);

        expect(verify(filtersMapper.mapTo(captureAny)).captured.first, filters);

        var mapperVerify = verify(claimMapper.mapFrom(captureAny));
        expect(mapperVerify.callCount, claimDTOs.length);
        for (int i = 0; i < claimDTOs.length; i++) {
          expect(mapperVerify.captured[i], claimDTOs[i]);
        }
      },
    );

    test(
      "Given a list of FilterEntity, when I call getClaims and an error occurred, then I expect an exception to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.getCredentials(
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
            filter: anyNamed('filter'),
          ),
        ).thenAnswer((realInvocation) => Future.error(exception));

        // When
        await repository
            .getCredentials(
              genesisDid: CommonMocks.identifier,
              encryptionKey: CommonMocks.encryptionKey,
              filters: filters,
            )
            .then((_) => expect(true, false))
            .catchError((error) {
              expect(error, isA<GetClaimsException>());
              expect(error.error, exception);
            });

        // Then
        var captureGet = verify(
          storageClaimDataSource.getCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            filter: captureAnyNamed('filter'),
          ),
        ).captured;
        expect(captureGet[0], CommonMocks.identifier);
        expect(captureGet[1], CommonMocks.encryptionKey);
        expect(captureGet[2], filter);

        expect(verify(filtersMapper.mapTo(captureAny)).captured.first, filters);

        verifyNever(claimMapper.mapFrom(captureAny));
      },
    );
  });

  group("Get credential", () {
    setUp(() {
      // Given
      when(
        storageClaimDataSource.getCredentials(
          did: anyNamed('did'),
          encryptionKey: anyNamed('encryptionKey'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((realInvocation) => Future.value([claimDTOs[0]]));
      when(
        storageClaimDataSource.getCredential(
          credentialId: anyNamed('credentialId'),
          did: anyNamed('did'),
          encryptionKey: CommonMocks.encryptionKey,
        ),
      ).thenAnswer((realInvocation) => Future.value(claimDTOs[0]));

      when(filtersMapper.mapTo(any)).thenReturn(filter);
      when(claimMapper.mapFrom(any)).thenReturn(claimEntities[0]);
    });

    test(
      "Given an id, when I call getClaim, then I expect a ClaimEntity to be returned",
      () async {
        // When
        expect(
          await repository.getCredential(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
            claimId: ids[0],
          ),
          claimEntities[0],
        );

        var captureGet = verify(
          storageClaimDataSource.getCredential(
            credentialId: captureAnyNamed('credentialId'),
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
          ),
        ).captured;

        expect(captureGet[0], CommonMocks.id);
        expect(captureGet[1], CommonMocks.identifier);
        expect(captureGet[2], CommonMocks.encryptionKey);

        expect(
          verify(claimMapper.mapFrom(captureAny)).captured.first,
          claimDTOs[0],
        );
      },
    );

    test(
      "Given an id, when I call getClaim and no claim are found, then I expect a ClaimNotFoundException to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.getCredential(
            credentialId: anyNamed('credentialId'),
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
          ),
        ).thenAnswer(
          (realInvocation) => Future.error(
            CredentialNotFoundException(
              id: ids[0],
              errorMessage: "Claim not found",
            ),
          ),
        );
        // When
        await repository
            .getCredential(
              genesisDid: CommonMocks.identifier,
              encryptionKey: CommonMocks.encryptionKey,
              claimId: ids[0],
            )
            .then((value) => expect(true, false))
            .catchError((error) {
              expect(error, isA<CredentialNotFoundException>());
              expect(error.id, ids[0]);
            });

        var captureGet = verify(
          storageClaimDataSource.getCredential(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentialId: captureAnyNamed('credentialId'),
          ),
        ).captured;

        expect(captureGet[0], CommonMocks.identifier);
        expect(captureGet[1], CommonMocks.encryptionKey);
        expect(captureGet[2], CommonMocks.id);

        verifyNever(claimMapper.mapFrom(captureAny));
      },
    );

    test(
      "Given an id, when I call getClaim and an error occurred, then I expect an exception to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.getCredential(
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
            credentialId: anyNamed('credentialId'),
          ),
        ).thenAnswer((realInvocation) => Future.error(claimNotFoundException));

        await expectLater(
          repository.getCredential(
            genesisDid: CommonMocks.identifier,
            claimId: ids[0],
            encryptionKey: CommonMocks.encryptionKey,
          ),
          throwsA(claimNotFoundException),
        );

        // Then
        final captureGet = verify(
          storageClaimDataSource.getCredential(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentialId: captureAnyNamed('credentialId'),
          ),
        ).captured;

        expect(captureGet[0], CommonMocks.identifier);
        expect(captureGet[1], CommonMocks.encryptionKey);
        expect(captureGet[2], CommonMocks.id);

        verifyNever(claimMapper.mapFrom(captureAny));
      },
    );
  });

  group("Remove all claims", () {
    setUp(() {
      // Given
      when(
        storageClaimDataSource.removeAllCredentials(
          did: anyNamed('did'),
          encryptionKey: anyNamed('encryptionKey'),
        ),
      ).thenAnswer((realInvocation) => Future.value());
    });

    test(
      "When I call removeAllClaims, then I expect the process to completes",
      () async {
        // When
        await expectLater(
          repository.removeAllCredentials(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
          ),
          completes,
        );

        // Then
        var captureRemove = verify(
          storageClaimDataSource.removeAllCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
          ),
        ).captured;
        expect(captureRemove[0], CommonMocks.identifier);
        expect(captureRemove[1], CommonMocks.encryptionKey);
      },
    );

    test(
      "When I call removeAllClaims and an error occurred, then I expect a RemoveClaimsException exception to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.removeAllCredentials(
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
          ),
        ).thenAnswer((realInvocation) => Future.error(exception));

        // When
        await repository
            .removeAllCredentials(
              genesisDid: CommonMocks.identifier,
              encryptionKey: CommonMocks.encryptionKey,
            )
            .then((_) => expect(true, false))
            .catchError((error) {
              expect(error, isA<RemoveClaimsException>());
              expect(error.error, exception);
            });

        // Then
        var captureRemove = verify(
          storageClaimDataSource.removeAllCredentials(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
          ),
        ).captured;
        expect(captureRemove[0], CommonMocks.identifier);
        expect(captureRemove[1], CommonMocks.encryptionKey);
      },
    );
  });

  group("Remove credentials", () {
    setUp(() {
      // Given
      when(
        storageClaimDataSource.removeCredential(
          did: anyNamed('did'),
          encryptionKey: anyNamed('encryptionKey'),
          credentialIds: anyNamed('credentialIds'),
        ),
      ).thenAnswer((realInvocation) => Future.value());
    });

    test(
      "Given a list of ids, when I call removeClaims, then I expect the process to completes",
      () async {
        // When
        await expectLater(
          repository.removeCredentials(
            genesisDid: CommonMocks.identifier,
            encryptionKey: CommonMocks.encryptionKey,
            claimIds: ids,
          ),
          completes,
        );

        // Then
        var captureRemove = verify(
          storageClaimDataSource.removeCredential(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentialIds: captureAnyNamed('credentialIds'),
          ),
        ).captured;
        expect(captureRemove[0], CommonMocks.identifier);
        expect(captureRemove[1], CommonMocks.encryptionKey);
        expect(captureRemove[2], ids);
      },
    );

    test(
      "Given a list of ids, when I call removeClaims and an error occurred, then I expect a RemoveClaimsException exception to be thrown",
      () async {
        // Given
        when(
          storageClaimDataSource.removeCredential(
            did: anyNamed('did'),
            encryptionKey: anyNamed('encryptionKey'),
            credentialIds: anyNamed('credentialIds'),
          ),
        ).thenAnswer((realInvocation) => Future.error(exception));

        // When
        await repository
            .removeCredentials(
              genesisDid: CommonMocks.identifier,
              encryptionKey: CommonMocks.encryptionKey,
              claimIds: ids,
            )
            .then((_) => expect(true, false))
            .catchError((error) {
              expect(error, isA<RemoveClaimsException>());
              expect(error.error, exception);
            });

        // Then
        var captureRemove = verify(
          storageClaimDataSource.removeCredential(
            did: captureAnyNamed('did'),
            encryptionKey: captureAnyNamed('encryptionKey'),
            credentialIds: captureAnyNamed('credentialIds'),
          ),
        ).captured;
        expect(captureRemove[0], CommonMocks.identifier);
        expect(captureRemove[1], CommonMocks.encryptionKey);
        expect(captureRemove[2], ids);
      },
    );
  });
}
