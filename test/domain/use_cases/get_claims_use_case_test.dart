import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/common/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/credential_repository.dart';

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
      state: ClaimState.pending,
      id: "id2"),
  ClaimEntity(
      issuer: "",
      identifier: "",
      expiration: "",
      data: {},
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
      when(credentialRepository.getClaims(filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.value(claimEntities));
    });

    test(
        "Given nothing, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(), claimEntities);

      // Then
      verify(credentialRepository.getClaims());
    });

    test(
        "Given a list of FilterEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: filters), claimEntities);

      // Then
      expect(
          verify(credentialRepository.getClaims(
                  filters: captureAnyNamed("filters")))
              .captured
              .first,
          filters);
    });

    test(
        "Given a list of FilterEntity, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaims(filters: anyNamed("filters")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: filters), throwsA(exception));

      // Then
      expect(
          verify(credentialRepository.getClaims(
                  filters: captureAnyNamed("filters")))
              .captured
              .first,
          filters);
    });
  });
}
