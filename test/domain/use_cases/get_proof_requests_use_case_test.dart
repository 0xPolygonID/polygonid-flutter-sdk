import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import 'get_proof_requests_use_case_test.mocks.dart';

// Data
final List<Iden3MessageEntity> messages = [
  Iden3commMocks.authRequest,
  Iden3commMocks.contractFunctionCallRequest
];
final expectations = [
  [
    ProofRequestEntity(Iden3commMocks.proofScopeRequest, proofQueryParamEntity),
    ProofRequestEntity(
        Iden3commMocks.otherProofScopeRequest, proofQueryParamEntity)
  ],
  [ProofRequestEntity(Iden3commMocks.proofScopeRequest, proofQueryParamEntity)]
];

final ProofQueryParamEntity proofQueryParamEntity = ProofQueryParamEntity(
    CommonMocks.field, CommonMocks.intValues, CommonMocks.operator);
final exception = Exception();

// Dependencies
MockGetProofQueryUseCase getProofQueryUseCase = MockGetProofQueryUseCase();

// Tested instance
GetProofRequestsUseCase useCase = GetProofRequestsUseCase(getProofQueryUseCase);

@GenerateMocks([GetProofQueryUseCase])
void main() {
  setUp(() {
    // Given
    reset(getProofQueryUseCase);
    when(getProofQueryUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(proofQueryParamEntity));
  });

  test(
    'Given a Iden3MessageEntity, when I call execute, I expect a list of ProofRequestEntity to be returned',
    () async {
      for (int i = 0; i < messages.length; i++) {
        // When
        expect(await useCase.execute(param: messages[i]), expectations[i]);

        // Then
        var verifyQuery = verify(
            getProofQueryUseCase.execute(param: captureAnyNamed('param')));
        expect(verifyQuery.callCount, messages[i].body.scope.length);
        expect(verifyQuery.captured, messages[i].body.scope);
      }
    },
  );

  test(
    'Given a Iden3MessageEntity with an unsupported type, when I call execute, I expect a list of UnsupportedIden3MsgTypeException to be thrown',
    () async {
      await useCase
          .execute(param: Iden3commMocks.fetchRequest)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<UnsupportedIden3MsgTypeException>());
        expect(error.type, Iden3MessageType.issuance);
      });

      // Then
      verifyNever(
          getProofQueryUseCase.execute(param: captureAnyNamed('param')));
    },
  );

  test(
    'Given a Iden3MessageEntity, when I call execute and an error occurred, I expect an empty array to be returned',
    () async {
      when(getProofQueryUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(exception));

      expect(await useCase.execute(param: Iden3commMocks.authRequest), []);

      // Then
      var verifyQuery =
          verify(getProofQueryUseCase.execute(param: captureAnyNamed('param')));
      expect(
          verifyQuery.callCount, Iden3commMocks.authRequest.body.scope?.length);
      expect(verifyQuery.captured, Iden3commMocks.authRequest.body.scope);
    },
  );
}
