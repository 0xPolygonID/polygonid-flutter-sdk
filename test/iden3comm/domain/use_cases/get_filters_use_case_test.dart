import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'get_filters_use_case_test.mocks.dart';

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

// Dependencies
MockIden3commCredentialRepository iden3commCredentialRepository =
    MockIden3commCredentialRepository();
MockIsProofCircuitSupportedUseCase isProofCircuitSupportedUseCase =
    MockIsProofCircuitSupportedUseCase();
MockGetProofRequestsUseCase getProofRequestsUseCase =
    MockGetProofRequestsUseCase();
// Tested instance
GetFiltersUseCase useCase = GetFiltersUseCase(iden3commCredentialRepository,
    isProofCircuitSupportedUseCase, getProofRequestsUseCase);

@GenerateMocks([
  Iden3commCredentialRepository,
  IsProofCircuitSupportedUseCase,
  GetProofRequestsUseCase
])
void main() {
  group("Get filters", () {
    setUp(() {
      // Given
      reset(iden3commCredentialRepository);
      reset(isProofCircuitSupportedUseCase);
      reset(getProofRequestsUseCase);

      when(iden3commCredentialRepository.getFilters(
              request: anyNamed('request')))
          .thenAnswer((realInvocation) => Future.value(filters));

      when(isProofCircuitSupportedUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(true));

      when(getProofRequestsUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) =>
              Future.value(Iden3commMocks.proofRequestList));
    });

    test(
        "When I call execute, then I expect a list of FilterEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: Iden3commMocks.authRequest), filters);

      // Then
      expect(
          verify(getProofRequestsUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first,
          Iden3commMocks.authRequest);

      var capturedCircuit = verify(isProofCircuitSupportedUseCase.execute(
              param: captureAnyNamed('param')))
          .captured;
      var capturedGet = verify(iden3commCredentialRepository.getFilters(
        request: captureAnyNamed('request'),
      )).captured;

      for (int i = 0; i < Iden3commMocks.proofRequestList.length; i++) {
        expect(capturedCircuit[i],
            Iden3commMocks.proofRequestList[i].scope.circuitId);
        expect(capturedGet[i], Iden3commMocks.proofRequestList[i]);
      }
    });

    test(
        "When I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(getProofRequestsUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(useCase.execute(param: Iden3commMocks.authRequest),
          throwsA(CommonMocks.exception));

      // Then
      verifyNever(isProofCircuitSupportedUseCase.execute(
          param: captureAnyNamed('param')));
      verifyNever(iden3commCredentialRepository.getFilters(
          request: captureAnyNamed('request')));
    });
  });
}
