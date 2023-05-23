import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'get_claims_use_case_test.mocks.dart';

// Data
final filters = [
  FilterEntity(name: "theName", value: "theValue"),
  FilterEntity(
      operator: FilterOperator.lesser, name: "theName1", value: "theValue1"),
  FilterEntity(
      operator: FilterOperator.inList,
      name: "theName2",
      value: ["theValue2", "theValue3"])
];
final GetClaimsParam param = GetClaimsParam(
    genesisDid: CommonMocks.did,
    profileNonce: BigInt.zero,
    privateKey: CommonMocks.privateKey);
final GetClaimsParam negativeParam = GetClaimsParam(
    genesisDid: CommonMocks.did,
    profileNonce: CommonMocks.negativeNonce,
    privateKey: CommonMocks.privateKey);
final GetClaimsParam paramFilters = GetClaimsParam(
    genesisDid: CommonMocks.did,
    profileNonce: BigInt.zero,
    privateKey: CommonMocks.privateKey,
    filters: filters);
final GetClaimsParam profileParam = GetClaimsParam(
    genesisDid: CommonMocks.did,
    profileNonce: BigInt.one,
    privateKey: CommonMocks.privateKey);
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
      id: "id3")
];
var exception = Exception();

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();
MockCheckProfileAndDidCurrentEnvUseCase checkProfileAndDidCurrentEnvUseCase =
    MockCheckProfileAndDidCurrentEnvUseCase();
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();

// Tested instance
GetClaimsUseCase useCase = GetClaimsUseCase(credentialRepository,
    checkProfileAndDidCurrentEnvUseCase, getIdentityUseCase);

@GenerateMocks([
  CredentialRepository,
  CheckProfileAndDidCurrentEnvUseCase,
  GetIdentityUseCase
])
void main() {
  group("Get claims", () {
    setUp(() {
      reset(credentialRepository);
      reset(checkProfileAndDidCurrentEnvUseCase);
      reset(getIdentityUseCase);

      // Given
      when(credentialRepository.getClaims(
              genesisDid: anyNamed('genesisDid'),
              privateKey: anyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.value(claimEntities));
      when(checkProfileAndDidCurrentEnvUseCase.execute(
              param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(null));
      when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
          (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    });

    test(
        "Given no filters, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), profilesClaimEntities);

      // Then
      var capturedCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedCheck.did, CommonMocks.did);
      expect(capturedCheck.privateKey, CommonMocks.privateKey);
      expect(capturedCheck.profileNonce, param.profileNonce);

      var capturedGet = verify(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.privateKey);
      expect(capturedGet[2], null);
    });

    test(
        "Given no filters and a non genesis profile, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: profileParam), claimEntities);

      // Then
      var capturedCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedCheck.did, CommonMocks.did);
      expect(capturedCheck.privateKey, CommonMocks.privateKey);
      expect(capturedCheck.profileNonce, profileParam.profileNonce);

      verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

      var capturedGet = verify(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.privateKey);
      expect(capturedGet[2], null);
    });

    test(
        "Given a list of FilterEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: paramFilters), profilesClaimEntities);

      // Then
      var capturedCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedCheck.did, CommonMocks.did);
      expect(capturedCheck.privateKey, CommonMocks.privateKey);
      expect(capturedCheck.profileNonce, param.profileNonce);

      var capturedGet = verify(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.privateKey);
      expect(capturedGet[2], filters);
    });

    test(
        "Given a list of FilterEntity, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: paramFilters), throwsA(exception));

      // Then
      var capturedCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedCheck.did, CommonMocks.did);
      expect(capturedCheck.privateKey, CommonMocks.privateKey);
      expect(capturedCheck.profileNonce, param.profileNonce);

      var capturedGet = verify(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.privateKey);
      expect(capturedGet[2], filters);
    });

    test(
        "Given no filters and a non genesis profile, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: profileParam), throwsA(exception));

      // Then
      var capturedCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedCheck.did, CommonMocks.did);
      expect(capturedCheck.privateKey, CommonMocks.privateKey);
      expect(capturedCheck.profileNonce, profileParam.profileNonce);

      verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

      var capturedGet = verify(credentialRepository.getClaims(
              genesisDid: captureAnyNamed('genesisDid'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.privateKey);
      expect(capturedGet[2], null);
    });
  });
}
