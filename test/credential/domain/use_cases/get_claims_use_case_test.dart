import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'get_claims_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
final filters = [
  FilterEntity(name: "theName", value: "theValue"),
  FilterEntity(
      operator: FilterOperator.lesser, name: "theName1", value: "theValue1"),
  FilterEntity(
      operator: FilterOperator.inList,
      name: "theName2",
      value: ["theValue2", "theValue3"])
];
final GetClaimsParam param =
    GetClaimsParam(did: identifier, privateKey: privateKey);
final GetClaimsParam paramFilters =
    GetClaimsParam(did: identifier, privateKey: privateKey, filters: filters);
final GetClaimsParam profileParam =
    GetClaimsParam(did: identifier, profileNonce: 1, privateKey: privateKey);
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
      state: ClaimState.pending,
      id: "id2"),
  ClaimEntity(
      issuer: "",
      did: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.revoked,
      id: "id3")
];
final profilesClaimEntities = [
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
      state: ClaimState.pending,
      id: "id2"),
  ClaimEntity(
      issuer: "",
      did: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.revoked,
      id: "id3"),
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
      state: ClaimState.pending,
      id: "id2"),
  ClaimEntity(
      issuer: "",
      did: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.revoked,
      id: "id3")
];
var exception = Exception();

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();

// Tested instance
GetClaimsUseCase useCase = GetClaimsUseCase(credentialRepository,
    getCurrentEnvDidIdentifierUseCase, getIdentityUseCase);

@GenerateMocks([
  CredentialRepository,
  GetCurrentEnvDidIdentifierUseCase,
  GetIdentityUseCase
])
void main() {
  group("Get claims", () {
    setUp(() {
      reset(credentialRepository);
      reset(getCurrentEnvDidIdentifierUseCase);
      reset(getIdentityUseCase);

      // Given
      when(credentialRepository.getClaims(
              did: anyNamed('did'),
              privateKey: anyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.value(claimEntities));
      when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
      when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
          (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    });

    test(
        "Given no filters, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), profilesClaimEntities);

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedGet = verify(credentialRepository.getClaims(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.profiles[0]);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], null);
    });

    test(
        "Given no filters and a non genesis profile, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: profileParam), claimEntities);

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

      var capturedGet = verify(credentialRepository.getClaims(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], null);
    });

    test(
        "Given a list of FilterEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: paramFilters), profilesClaimEntities);

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedGet = verify(credentialRepository.getClaims(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.profiles[0]);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], filters);
    });

    test(
        "Given a list of FilterEntity, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaims(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: paramFilters), throwsA(exception));

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedGet = verify(credentialRepository.getClaims(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.profiles[0]);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], filters);
    });
  });
}
