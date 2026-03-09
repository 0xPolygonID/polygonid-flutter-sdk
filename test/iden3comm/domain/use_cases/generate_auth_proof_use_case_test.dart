import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_auth_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/generate_inputs_response.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

import '../../../common/common_mocks.dart';
import '../../../common/proof_mocks.dart';
import 'generate_auth_proof_use_case_test.mocks.dart';

// --- Test data ---

final mockGenerateInputsResponse = GenerateInputsResponse(
  inputs: {"key": "value"},
  publicStatesInfo: ProofMocks.publicStatesInfo,
);

final param = GenerateAuthProofParam(
  genesisDid: CommonMocks.did,
  privateKey: CommonMocks.privateKey,
  profileNonce: CommonMocks.nonce,
  requestId: 2,
  circuitId: "authV3-8-32",
  challenge: "<attestation_hash>",
);

// --- Mocked dependencies ---

MockGetAuthInputsUseCase getAuthInputsUseCase = MockGetAuthInputsUseCase();
MockProofRepository proofRepository = MockProofRepository();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// --- Tested instance ---

GenerateAuthProofUseCase useCase = GenerateAuthProofUseCase(
  getAuthInputsUseCase,
  proofRepository,
  stacktraceManager,
);

@GenerateMocks([
  GetAuthInputsUseCase,
  ProofRepository,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(getAuthInputsUseCase);
    reset(proofRepository);
    reset(stacktraceManager);
  });

  void setupHappyPath() {
    when(getAuthInputsUseCase.execute(param: anyNamed('param'))).thenAnswer(
      (_) => Future.value(mockGenerateInputsResponse),
    );

    when(proofRepository.loadCircuitFiles(any)).thenAnswer(
      (_) => Future.value(ProofMocks.circuitData),
    );

    when(
      proofRepository.calculateWitness(
        circuitData: anyNamed('circuitData'),
        inputs: anyNamed('inputs'),
      ),
    ).thenAnswer((_) => Future.value(Uint8List(32)));

    when(
      proofRepository.prove(
        circuitData: anyNamed('circuitData'),
        wtnsBytes: anyNamed('wtnsBytes'),
      ),
    ).thenAnswer((_) => Future.value(ProofMocks.zkProof));
  }

  test(
    "given valid GenerateAuthProofParam, "
    "when call execute, "
    "then expect an Iden3commProofEntity to be returned with correct fields",
    () async {
      // Given
      setupHappyPath();

      // When
      final result = await useCase.execute(param: param);

      // Then
      expect(result, isA<Iden3commProofEntity>());
      expect(result.id, 2);
      expect(result.circuitId, "authV3-8-32");
      expect(result.proof, ProofMocks.zkProof.proof);
      expect(result.pubSignals, ProofMocks.zkProof.pubSignals);
      expect(result.publicStatesInfo, ProofMocks.publicStatesInfo);
    },
  );

  test(
    "given valid param, "
    "when call execute, "
    "then expect GetAuthInputsUseCase to be called with correct params",
    () async {
      // Given
      setupHappyPath();

      // When
      await useCase.execute(param: param);

      // Then
      final captured = verify(
        getAuthInputsUseCase.execute(param: captureAnyNamed('param')),
      ).captured.single as GetAuthInputsParam;

      expect(captured.challenge, "<attestation_hash>");
      expect(captured.genesisDid, CommonMocks.did);
      expect(captured.profileNonce, CommonMocks.nonce);
      expect(captured.privateKey, CommonMocks.privateKey);
      expect(captured.encryptionKey, CommonMocks.privateKey);
      expect(captured.circuitId.id, "authV3-8-32");
    },
  );

  test(
    "given valid param, "
    "when call execute, "
    "then expect ProofRepository methods to be called in correct order with correct inputs",
    () async {
      // Given
      setupHappyPath();

      // When
      await useCase.execute(param: param);

      // Then
      final loadCircuitFilesVerification = verify(
        proofRepository.loadCircuitFiles(captureAny),
      );
      expect(loadCircuitFilesVerification.captured.single, "authV3-8-32");

      final calculateWitnessVerification = verify(
        proofRepository.calculateWitness(
          circuitData: captureAnyNamed('circuitData'),
          inputs: captureAnyNamed('inputs'),
        ),
      );
      expect(
        calculateWitnessVerification.captured[0],
        ProofMocks.circuitData,
      );
      expect(
        calculateWitnessVerification.captured[1],
        jsonEncode(mockGenerateInputsResponse.inputs),
      );

      verify(
        proofRepository.prove(
          circuitData: anyNamed('circuitData'),
          wtnsBytes: anyNamed('wtnsBytes'),
        ),
      ).called(1);
    },
  );

  test(
    "given GetAuthInputsUseCase throws an exception, "
    "when call execute, "
    "then expect the exception to be rethrown",
    () async {
      // Given
      when(getAuthInputsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (_) => Future.error(CommonMocks.exception),
      );

      // When / Then
      await expectLater(
        useCase.execute(param: param),
        throwsA(CommonMocks.exception),
      );

      // ProofRepository methods should not have been called
      verifyNever(proofRepository.loadCircuitFiles(any));
      verifyNever(
        proofRepository.calculateWitness(
          circuitData: anyNamed('circuitData'),
          inputs: anyNamed('inputs'),
        ),
      );
      verifyNever(
        proofRepository.prove(
          circuitData: anyNamed('circuitData'),
          wtnsBytes: anyNamed('wtnsBytes'),
        ),
      );
    },
  );

  test(
    "given ProofRepository.loadCircuitFiles throws an exception, "
    "when call execute, "
    "then expect the exception to be rethrown",
    () async {
      // Given
      when(getAuthInputsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (_) => Future.value(mockGenerateInputsResponse),
      );
      when(proofRepository.loadCircuitFiles(any)).thenAnswer(
        (_) => Future.error(CommonMocks.exception),
      );

      // When / Then
      await expectLater(
        useCase.execute(param: param),
        throwsA(CommonMocks.exception),
      );

      verifyNever(
        proofRepository.calculateWitness(
          circuitData: anyNamed('circuitData'),
          inputs: anyNamed('inputs'),
        ),
      );
      verifyNever(
        proofRepository.prove(
          circuitData: anyNamed('circuitData'),
          wtnsBytes: anyNamed('wtnsBytes'),
        ),
      );
    },
  );

  test(
    "given ProofRepository.calculateWitness throws an exception, "
    "when call execute, "
    "then expect the exception to be rethrown",
    () async {
      // Given
      when(getAuthInputsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (_) => Future.value(mockGenerateInputsResponse),
      );
      when(proofRepository.loadCircuitFiles(any)).thenAnswer(
        (_) => Future.value(ProofMocks.circuitData),
      );
      when(
        proofRepository.calculateWitness(
          circuitData: anyNamed('circuitData'),
          inputs: anyNamed('inputs'),
        ),
      ).thenAnswer((_) => Future.error(CommonMocks.exception));

      // When / Then
      await expectLater(
        useCase.execute(param: param),
        throwsA(CommonMocks.exception),
      );

      verifyNever(
        proofRepository.prove(
          circuitData: anyNamed('circuitData'),
          wtnsBytes: anyNamed('wtnsBytes'),
        ),
      );
    },
  );

  test(
    "given ProofRepository.prove throws an exception, "
    "when call execute, "
    "then expect the exception to be rethrown",
    () async {
      // Given
      when(getAuthInputsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (_) => Future.value(mockGenerateInputsResponse),
      );
      when(proofRepository.loadCircuitFiles(any)).thenAnswer(
        (_) => Future.value(ProofMocks.circuitData),
      );
      when(
        proofRepository.calculateWitness(
          circuitData: anyNamed('circuitData'),
          inputs: anyNamed('inputs'),
        ),
      ).thenAnswer((_) => Future.value(Uint8List(32)));
      when(
        proofRepository.prove(
          circuitData: anyNamed('circuitData'),
          wtnsBytes: anyNamed('wtnsBytes'),
        ),
      ).thenAnswer((_) => Future.error(CommonMocks.exception));

      // When / Then
      await expectLater(
        useCase.execute(param: param),
        throwsA(CommonMocks.exception),
      );
    },
  );
}
