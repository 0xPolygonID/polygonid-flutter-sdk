import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

import '../../../common/common_mocks.dart';
import '../../../common/credential_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import '../../../common/identity_mocks.dart';
import '../../../common/proof_mocks.dart';
import 'get_iden3comm_proofs_use_case_test.mocks.dart';

// Data
List<FilterEntity> filters = [CommonMocks.filter, CommonMocks.filter];
List<JWZSDProofEntity> result = [
  Iden3commMocks.jwzSdProof,
  Iden3commMocks.jwzSdProof
];

GetIden3commProofsParam param = GetIden3commProofsParam(
  message: Iden3commMocks.authRequest,
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

var exception = ProofsNotFoundException([]);

// Mocked dependencies
MockProofRepository proofRepository = MockProofRepository();
MockGetIden3commClaimsUseCase getIden3commClaimsUseCase =
    MockGetIden3commClaimsUseCase();
MockGenerateProofUseCase generateProofUseCase = MockGenerateProofUseCase();
MockIsProofCircuitSupportedUseCase isProofCircuitSupportedUseCase =
    MockIsProofCircuitSupportedUseCase();
MockGetProofRequestsUseCase getProofRequestsUseCase =
    MockGetProofRequestsUseCase();
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockProofGenerationStepsStreamManager proofGenerationStepsStreamManager =
    MockProofGenerationStepsStreamManager();

// Tested instance
GetIden3commProofsUseCase useCase = GetIden3commProofsUseCase(
  proofRepository,
  getIden3commClaimsUseCase,
  generateProofUseCase,
  isProofCircuitSupportedUseCase,
  getProofRequestsUseCase,
  getIdentityUseCase,
  proofGenerationStepsStreamManager,
);

@GenerateMocks([
  ProofRepository,
  GetIden3commClaimsUseCase,
  GenerateProofUseCase,
  IsProofCircuitSupportedUseCase,
  GetProofRequestsUseCase,
  GetIdentityUseCase,
  ProofGenerationStepsStreamManager,
])
main() {
  setUp(() {
    reset(proofRepository);
    reset(getIden3commClaimsUseCase);
    reset(generateProofUseCase);
    reset(isProofCircuitSupportedUseCase);
    reset(getProofRequestsUseCase);
    reset(getIdentityUseCase);

    //Given
    when(getProofRequestsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(Iden3commMocks.proofRequestList));

    when(isProofCircuitSupportedUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(true));

    when(getIden3commClaimsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) =>
            Future.value([CredentialMocks.claim, CredentialMocks.claim]));

    when(proofRepository.loadCircuitFiles(any))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.circuitData));

    when(generateProofUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(Iden3commMocks.jwzSdProof));

    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
      "given GetProofsParam as param, when call execute, then expect a list of ProofEntity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var getRequestsCaptured =
        verify(getProofRequestsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getRequestsCaptured[0], Iden3commMocks.authRequest);

    var verifyIsFilterSupported = verify(isProofCircuitSupportedUseCase.execute(
        param: captureAnyNamed('param')));
    expect(verifyIsFilterSupported.callCount,
        Iden3commMocks.proofRequestList.length);

    var verifyGetClaims = verify(
        getIden3commClaimsUseCase.execute(param: captureAnyNamed('param')));
    expect(verifyGetClaims.callCount, 1);
    expect(verifyGetClaims.captured.first.genesisDid, param.genesisDid);
    expect(verifyGetClaims.captured.first.privateKey, param.privateKey);

    var verifyLoadCircuit =
        verify(proofRepository.loadCircuitFiles(captureAny));
    expect(verifyLoadCircuit.callCount, Iden3commMocks.proofRequestList.length);

    var verifyGenerateProof =
        verify(generateProofUseCase.execute(param: captureAnyNamed('param')));
    expect(
        verifyGenerateProof.callCount, Iden3commMocks.proofRequestList.length);

    for (int i = 0; i < Iden3commMocks.proofRequestList.length; i++) {
      expect(verifyIsFilterSupported.captured[i],
          Iden3commMocks.proofRequestList[i].scope.circuitId);

      expect(verifyLoadCircuit.captured[i],
          Iden3commMocks.proofRequestList[i].scope.circuitId);

      expect(verifyGenerateProof.captured[i].did, IdentityMocks.did.did);
      expect(verifyGenerateProof.captured[i].profileNonce, param.profileNonce);
      expect(verifyGenerateProof.captured[i].claimSubjectProfileNonce,
          CommonMocks.genesisNonce);
      expect(verifyGenerateProof.captured[i].credential, CredentialMocks.claim);
      expect(verifyGenerateProof.captured[i].request,
          Iden3commMocks.proofRequestList[i].scope);
      expect(
          verifyGenerateProof.captured[i].circuitData, ProofMocks.circuitData);
    }

    var getIdentityCapture =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(getIdentityCapture.genesisDid, CommonMocks.did);
  });

  test(
      "Given GetProofsFromIden3MsgParam as param, when call execute and error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getIden3commClaimsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(
        useCase.execute(param: param), throwsA(CommonMocks.exception));

    // Then
    var getRequestsCaptured =
        verify(getProofRequestsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getRequestsCaptured[0], Iden3commMocks.authRequest);

    verifyNever(isProofCircuitSupportedUseCase.execute(
        param: captureAnyNamed('param')));
    verifyNever(proofRepository.loadCircuitFiles(captureAny));
    verifyNever(generateProofUseCase.execute(param: captureAnyNamed('param')));
    verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
