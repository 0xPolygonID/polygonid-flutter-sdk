import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';

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
    GetClaimsParam(identifier: identifier, privateKey: privateKey);
final GetClaimsParam paramFilters = GetClaimsParam(
    identifier: identifier, privateKey: privateKey, filters: filters);
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
      state: ClaimState.pending,
      id: "id2"),
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      info: {},
      type: "",
      state: ClaimState.revoked,
      id: "id3")
];
var exception = Exception();

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
GetClaimsUseCase useCase = GetClaimsUseCase(credentialRepository);

@GenerateMocks([CredentialRepository])
void main() {
  group("Get claims", () {
    setUp(() {
      reset(credentialRepository);

      // Given
      when(credentialRepository.getClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.value(claimEntities));
    });

    test(
        "Given no filters, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), claimEntities);

      // Then
      var capturedGet = verify(credentialRepository.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], identifier);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], null);
    });

    test(
        "Given a list of FilterEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: paramFilters), claimEntities);

      // Then
      var capturedGet = verify(credentialRepository.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], identifier);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], filters);
    });

    test(
        "Given a list of FilterEntity, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: paramFilters), throwsA(exception));

      // Then
      var capturedGet = verify(credentialRepository.getClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              filters: captureAnyNamed('filters')))
          .captured;
      expect(capturedGet[0], identifier);
      expect(capturedGet[1], privateKey);
      expect(capturedGet[2], filters);
    });
  });
}
