import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

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
final GetFiltersParam param =
    GetFiltersParam(message: Iden3commMocks.authRequest);
var exception = Exception();

// Dependencies
MockIden3commRepository iden3commRepository = MockIden3commRepository();
MockIsProofCircuitSupportedUseCase isProofCircuitSupportedUseCase =
    MockIsProofCircuitSupportedUseCase();
MockGetProofRequestsUseCase getProofRequestsUseCase =
    MockGetProofRequestsUseCase();
// Tested instance
GetFiltersUseCase useCase = GetFiltersUseCase(iden3commRepository,
    isProofCircuitSupportedUseCase, getProofRequestsUseCase);

@GenerateMocks([
  Iden3commRepository,
  IsProofCircuitSupportedUseCase,
  GetProofRequestsUseCase
])
void main() {
  group("Get filters", () {
    setUp(() {
      // Given
      reset(iden3commRepository);
      reset(isProofCircuitSupportedUseCase);
      reset(getProofRequestsUseCase);

      when(iden3commRepository.getFilters(request: anyNamed('request')))
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
      expect(await useCase.execute(param: param), filters);

      // Then
      var capturedGet = verify(iden3commRepository.getFilters(
        request: captureAnyNamed('request'),
      )).captured;
      expect(capturedGet[0], Iden3commMocks.proofRequestList[0]);
      expect(capturedGet[1], Iden3commMocks.proofRequestList[1]);
    });
  });
}
