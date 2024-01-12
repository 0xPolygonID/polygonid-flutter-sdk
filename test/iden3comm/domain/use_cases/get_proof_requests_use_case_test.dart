import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'get_proof_requests_use_case_test.mocks.dart';

// Data
final List<Iden3MessageEntity> messages = [
  Iden3commMocks.authRequest,
  Iden3commMocks.contractFunctionCallRequest
];

final expectations = [
  [
    ProofRequestEntity(Iden3commMocks.proofScopeRequest,
        Iden3commMocks.mockContext, proofQueryParamEntity),
    ProofRequestEntity(Iden3commMocks.otherProofScopeRequest,
        Iden3commMocks.mockContext, proofQueryParamEntity)
  ],
  [
    ProofRequestEntity(Iden3commMocks.proofScopeRequest,
        Iden3commMocks.mockContext, proofQueryParamEntity)
  ]
];

final ProofQueryParamEntity proofQueryParamEntity = ProofQueryParamEntity(
    CommonMocks.field, CommonMocks.intValues, CommonMocks.operator);
final exception = Exception();

// Dependencies
MockGetProofQueryContextUseCase getProofQueryContextUseCase =
    MockGetProofQueryContextUseCase();
MockGetProofQueryUseCase getProofQueryUseCase = MockGetProofQueryUseCase();
MockStacktraceManager stacktraceStreamManager = MockStacktraceManager();

// Tested instance
GetProofRequestsUseCase useCase = GetProofRequestsUseCase(
  getProofQueryContextUseCase,
  getProofQueryUseCase,
  stacktraceStreamManager,
);

@GenerateMocks([
  GetProofQueryUseCase,
  GetProofQueryContextUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    // Given
    reset(getProofQueryContextUseCase);
    reset(getProofQueryUseCase);

    when(getProofQueryUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(proofQueryParamEntity));
    when(getProofQueryContextUseCase.execute(param: anyNamed('param')))
        .thenAnswer(
            (realInvocation) => Future.value(Iden3commMocks.mockContext));
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
      // When
      await useCase
          .execute(param: Iden3commMocks.fetchRequest)
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<UnsupportedIden3MsgTypeException>());
        expect(error.type, Iden3MessageType.credentialIssuanceResponse);
      });

      // Then
      verifyNever(
          getProofQueryUseCase.execute(param: captureAnyNamed('param')));
    },
  );

  test(
    'Given a Iden3MessageEntity, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      when(getProofQueryContextUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(useCase.execute(param: Iden3commMocks.authRequest),
          throwsA(CommonMocks.exception));

      // Then
      var verifyQueryContext = verify(
          getProofQueryContextUseCase.execute(param: captureAnyNamed('param')));
      expect(verifyQueryContext.callCount, 1);
      expect(verifyQueryContext.captured,
          [Iden3commMocks.authRequest.body.scope![0]]);

      verifyNever(
          getProofQueryUseCase.execute(param: captureAnyNamed('param')));
    },
  );
}
