import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_auth_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'get_auth_token_use_case_test.mocks.dart';

// Data
final param = GetAuthTokenParam(
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.genesisNonce,
  privateKey: CommonMocks.privateKey,
  message: CommonMocks.message,
  circuitId: CircuitId.authV2,
);
var exception = Exception();
var getAuthTokenException = GetAuthTokenException(errorMessage: "Error");

// Dependencies
MockGetJWZUseCase getJWZUseCase = MockGetJWZUseCase();
MockGetAuthChallengeUseCase getAuthChallengeUseCase =
    MockGetAuthChallengeUseCase();
MockGenerateAuthProofUseCase generateAuthProofUseCase =
    MockGenerateAuthProofUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
GetAuthTokenUseCase useCase = GetAuthTokenUseCase(
  getJWZUseCase,
  getAuthChallengeUseCase,
  generateAuthProofUseCase,
  stacktraceManager,
);

@GenerateMocks([
  GetJWZUseCase,
  GetAuthChallengeUseCase,
  GenerateAuthProofUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(getJWZUseCase);
    reset(getAuthChallengeUseCase);
    reset(generateAuthProofUseCase);
    reset(stacktraceManager);

    // Given
    when(
      getJWZUseCase.execute(param: anyNamed('param')),
    ).thenAnswer((realInvocation) => Future.value(Iden3commMocks.encodedJWZ));
    when(
      getAuthChallengeUseCase.execute(param: anyNamed('param')),
    ).thenAnswer((realInvocation) => Future.value(CommonMocks.challenge));
    when(generateAuthProofUseCase.execute(param: anyNamed('param'))).thenAnswer(
      (realInvocation) => Future.value(Iden3commMocks.iden3commProof),
    );
  });

  test(
    "Given a GetAuthTokenParam, when I call execute, then I expect a token String to be returned",
    () async {
      // When
      expect(await useCase.execute(param: param), Iden3commMocks.encodedJWZ);

      // Then
      var verifyGetJWZ = verify(
        getJWZUseCase.execute(param: captureAnyNamed('param')),
      );
      expect(verifyGetJWZ.callCount, 2);
      expect(verifyGetJWZ.captured[0].message, param.message);
      expect(verifyGetJWZ.captured[0].proof, null);
      expect(verifyGetJWZ.captured[0].circuitId, CircuitId.authV2);
      expect(verifyGetJWZ.captured[1].message, param.message);
      expect(verifyGetJWZ.captured[1].proof, Iden3commMocks.iden3commProof);
      expect(verifyGetJWZ.captured[1].circuitId, CircuitId.authV2);

      expect(
        verify(
          getAuthChallengeUseCase.execute(param: captureAnyNamed('param')),
        ).captured.first,
        Iden3commMocks.encodedJWZ,
      );

      var captureAuthProof =
          verify(
                generateAuthProofUseCase.execute(
                  param: captureAnyNamed('param'),
                ),
              ).captured.first
              as GenerateAuthProofParam;
      expect(captureAuthProof.genesisDid, CommonMocks.did);
      expect(captureAuthProof.privateKey, CommonMocks.privateKey);
      expect(captureAuthProof.profileNonce, CommonMocks.genesisNonce);
      expect(captureAuthProof.requestId, 0);
      expect(captureAuthProof.circuitId, CircuitId.authV2.id);
      expect(captureAuthProof.challenge, CommonMocks.challenge);
    },
  );

  test(
    "Given a GetAuthTokenParam, when I call execute and generateAuthProof fails, then I expect an exception to be thrown",
    () async {
      // Given
      when(
        generateAuthProofUseCase.execute(param: anyNamed('param')),
      ).thenAnswer((realInvocation) => Future.error(getAuthTokenException));

      // When
      await expectLater(
        useCase.execute(param: param),
        throwsA(getAuthTokenException),
      );

      // Then
      var verifyGetJWZ = verify(
        getJWZUseCase.execute(param: captureAnyNamed('param')),
      );
      expect(verifyGetJWZ.callCount, 1);
      expect(verifyGetJWZ.captured[0].message, param.message);
      expect(verifyGetJWZ.captured[0].proof, null);

      expect(
        verify(
          getAuthChallengeUseCase.execute(param: captureAnyNamed('param')),
        ).captured.first,
        Iden3commMocks.encodedJWZ,
      );

      verify(
        generateAuthProofUseCase.execute(param: anyNamed('param')),
      ).called(1);

      verifyNever(
        getJWZUseCase.execute(
          param: argThat(
            predicate((p) => p is GetJWZParam && p.proof != null),
            named: 'param',
          ),
        ),
      );
    },
  );

  test(
    "Given a GetAuthTokenParam, when I call execute and getAuthChallenge fails, then I expect a GetAuthTokenException to be thrown",
    () async {
      // Given
      when(
        getAuthChallengeUseCase.execute(param: anyNamed('param')),
      ).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
        useCase.execute(param: param),
        throwsA(isA<GetAuthTokenException>()),
      );

      // Then
      verify(getJWZUseCase.execute(param: anyNamed('param'))).called(1);
      verify(
        getAuthChallengeUseCase.execute(param: anyNamed('param')),
      ).called(1);
      verifyNever(generateAuthProofUseCase.execute(param: anyNamed('param')));
    },
  );

  test(
    "Given a GetAuthTokenParam, when I call execute and getJWZ fails on first call, then I expect a GetAuthTokenException to be thrown",
    () async {
      // Given
      when(
        getJWZUseCase.execute(param: anyNamed('param')),
      ).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
        useCase.execute(param: param),
        throwsA(isA<GetAuthTokenException>()),
      );

      // Then
      verify(getJWZUseCase.execute(param: anyNamed('param'))).called(1);
      verifyNever(getAuthChallengeUseCase.execute(param: anyNamed('param')));
      verifyNever(generateAuthProofUseCase.execute(param: anyNamed('param')));
    },
  );
}
