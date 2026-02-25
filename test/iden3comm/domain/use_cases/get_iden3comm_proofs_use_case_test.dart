import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

import '../../../common/common_mocks.dart';
import '../../../common/credential_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'get_iden3comm_proofs_use_case_test.mocks.dart';

// Data
List<FilterEntity> filters = [CommonMocks.filter, CommonMocks.filter];
List<Iden3commProofEntity> result = [
  Iden3commMocks.iden3commSDProof,
  Iden3commMocks.iden3commSDProof,
];

GetIden3commProofsParam param = GetIden3commProofsParam(
  message: Iden3commMocks.authRequest,
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

var exception = ProofsNotCreatedException(
  errorMessage: 'Error',
  proofRequests: [],
);

// Mocked dependencies
MockGetMessageRequestsAndCredsUseCase getMessageRequestsAndCredsUseCase =
    MockGetMessageRequestsAndCredsUseCase();
MockGetIden3commProofUseCase getIden3commProofUseCase =
    MockGetIden3commProofUseCase();
MockIsProofCircuitSupportedUseCase isProofCircuitSupportedUseCase =
    MockIsProofCircuitSupportedUseCase();
MockProofGenerationStepsStreamManager proofGenerationStepsStreamManager =
    MockProofGenerationStepsStreamManager();
MockStacktraceManager stacktraceStreamManager = MockStacktraceManager();
MockRefreshCredentialUseCase refreshCredentialUseCase =
    MockRefreshCredentialUseCase();

// Tested instance
GetIden3commProofsUseCase useCase = GetIden3commProofsUseCase(
  getMessageRequestsAndCredsUseCase,
  getIden3commProofUseCase,
  isProofCircuitSupportedUseCase,
  proofGenerationStepsStreamManager,
  stacktraceStreamManager,
  refreshCredentialUseCase,
);

@GenerateMocks([
  GetMessageRequestsAndCredsUseCase,
  GetIden3commProofUseCase,
  IsProofCircuitSupportedUseCase,
  ProofGenerationStepsStreamManager,
  StacktraceManager,
  RefreshCredentialUseCase,
])
void main() {
  final claim = CredentialMocks.claim.copyWith(
    info: {
      'credentialSubject': {'id': IdentityMocks.did.did},
    },
  );

  setUp(() {
    reset(getMessageRequestsAndCredsUseCase);
    reset(getIden3commProofUseCase);
    reset(isProofCircuitSupportedUseCase);

    when(
      isProofCircuitSupportedUseCase.execute(param: anyNamed('param')),
    ).thenAnswer((realInvocation) => Future.value(true));

    when(
      getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
    ).thenAnswer(
      (realInvocation) async => [
        (request: Iden3commMocks.proofScopeRequest, credentials: [claim]),
        (request: Iden3commMocks.proofScopeRequest, credentials: [claim]),
      ],
    );

    when(getIden3commProofUseCase.execute(param: anyNamed('param'))).thenAnswer(
      (realInvocation) => Future.value(Iden3commMocks.iden3commSDProof),
    );
  });

  test(
    "given GetProofsParam as param, when call execute, then expect a list of ProofEntity to be returned",
    () async {
      // When
      expect(await useCase.execute(param: param), result);

      // Then
      var verifyIsFilterSupported = verify(
        isProofCircuitSupportedUseCase.execute(param: captureAnyNamed('param')),
      );
      expect(
        verifyIsFilterSupported.callCount,
        Iden3commMocks.proofRequestList.length,
      );

      var verifyGetClaims = verify(
        getMessageRequestsAndCredsUseCase.execute(
          param: captureAnyNamed('param'),
        ),
      );
      expect(verifyGetClaims.callCount, 1);
      expect(verifyGetClaims.captured.first.genesisDid, param.genesisDid);
      expect(verifyGetClaims.captured.first.encryptionKey, param.privateKey);

      var verifyGenerateProof = verify(
        getIden3commProofUseCase.execute(param: captureAnyNamed('param')),
      );
      expect(
        verifyGenerateProof.callCount,
        Iden3commMocks.proofRequestList.length,
      );

      for (int i = 0; i < Iden3commMocks.proofRequestList.length; i++) {
        expect(
          verifyIsFilterSupported.captured[i],
          Iden3commMocks.proofRequestList[i].scope.circuitId,
        );

        expect(
          verifyGenerateProof.captured[i].genesisDid,
          IdentityMocks.did.did,
        );
        expect(
          verifyGenerateProof.captured[i].profileNonce,
          param.profileNonce,
        );
        expect(verifyGenerateProof.captured[i].credential, claim);
        expect(
          verifyGenerateProof.captured[i].request,
          Iden3commMocks.proofRequestList[i].scope,
        );
      }
    },
  );

  test(
    "Given GetProofsFromIden3MsgParam as param, when call execute and error occurred, then I expect an exception to be thrown",
    () async {
      // Given
      when(
        getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
      ).thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
        useCase.execute(param: param),
        throwsA(CommonMocks.exception),
      );

      // Then
      verifyNever(
        isProofCircuitSupportedUseCase.execute(param: captureAnyNamed('param')),
      );
      verifyNever(
        getIden3commProofUseCase.execute(param: captureAnyNamed('param')),
      );
    },
  );
}
