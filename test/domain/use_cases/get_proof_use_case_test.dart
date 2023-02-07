import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/credential_mocks.dart';
import '../../common/iden3com_mocks.dart';
import '../../common/identity_mocks.dart';
import '../../common/proof_mocks.dart';
import 'get_proof_use_case_test.mocks.dart';

// Data
List<FilterEntity> filters = [CommonMocks.filter, CommonMocks.filter];
List<JWZProofEntity> result = [
  Iden3commMocks.jwzProof,
  Iden3commMocks.jwzProof
];

GetProofsParam param = GetProofsParam(
  message: Iden3commMocks.authRequest,
  did: CommonMocks.did,
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

var exception = ProofsNotFoundException([]);

// Mocked dependencies
MockProofRepository proofRepository = MockProofRepository();
MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetClaimsUseCase getClaimsUseCase = MockGetClaimsUseCase();
MockGenerateProofUseCase generateProofUseCase = MockGenerateProofUseCase();
MockIsProofCircuitSupportedUseCase isProofCircuitSupportedUseCase =
    MockIsProofCircuitSupportedUseCase();
MockGetProofRequestsUseCase getProofRequestsUseCase =
    MockGetProofRequestsUseCase();

// Tested instance
GetProofsUseCase useCase = GetProofsUseCase(
  proofRepository,
  identityRepository,
  getClaimsUseCase,
  generateProofUseCase,
  isProofCircuitSupportedUseCase,
  getProofRequestsUseCase,
);

@GenerateMocks([
  ProofRepository,
  IdentityRepository,
  GetClaimsUseCase,
  GenerateProofUseCase,
  IsProofCircuitSupportedUseCase,
  GetProofRequestsUseCase,
])
main() {
  setUp(() {
    reset(proofRepository);
    reset(identityRepository);
    reset(getClaimsUseCase);
    reset(generateProofUseCase);
    reset(isProofCircuitSupportedUseCase);
    reset(getProofRequestsUseCase);

    //Given
    when(identityRepository.getIdentity(did: anyNamed('did'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    when(getProofRequestsUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(Iden3commMocks.proofRequestList));

    when(isProofCircuitSupportedUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(true));

    when(proofRepository.getFilters(request: anyNamed('request')))
        .thenAnswer((realInvocation) => Future.value(filters));

    when(getClaimsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value([CredentialMocks.claim]));

    when(proofRepository.loadCircuitFiles(any))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.circuitData));

    when(identityRepository.signMessage(
            privateKey: anyNamed('privateKey'), message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.signature));

    when(generateProofUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.jwzProof));
  });

  test(
      "given GetProofsParam as param, when call execute, then expect a list of ProofEntity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var getIdentityCaptured =
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured;
    expect(getIdentityCaptured[0], CommonMocks.did);

    var getRequestsCaptured =
        verify(getProofRequestsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getRequestsCaptured[0], Iden3commMocks.authRequest);

    var verifyIsFilterSupported = verify(isProofCircuitSupportedUseCase.execute(
        param: captureAnyNamed('param')));
    expect(verifyIsFilterSupported.callCount,
        Iden3commMocks.proofRequestList.length);

    var verifyGetFilters =
        verify(proofRepository.getFilters(request: captureAnyNamed('request')));
    expect(verifyGetFilters.callCount, Iden3commMocks.proofRequestList.length);

    var verifyGetClaims =
        verify(getClaimsUseCase.execute(param: captureAnyNamed('param')));
    expect(verifyGetClaims.callCount, Iden3commMocks.proofRequestList.length);

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

      expect(verifyGetFilters.captured[i], Iden3commMocks.proofRequestList[i]);

      expect(verifyGetClaims.captured[i].filters, filters);
      expect(verifyGetClaims.captured[i].did, param.did);
      expect(verifyGetClaims.captured[i].privateKey, param.privateKey);

      expect(verifyLoadCircuit.captured[i],
          Iden3commMocks.proofRequestList[i].scope.circuitId);

      expect(verifyGenerateProof.captured[i].id, IdentityMocks.did.identifier);
      expect(verifyGenerateProof.captured[i].profileNonce, param.profileNonce);
      expect(verifyGenerateProof.captured[i].claimSubjectProfileNonce, 0);
      expect(verifyGenerateProof.captured[i].credential, CredentialMocks.claim);
      expect(verifyGenerateProof.captured[i].request,
          Iden3commMocks.proofRequestList[i].scope);
      expect(
          verifyGenerateProof.captured[i].circuitData, ProofMocks.circuitData);
    }
  });

  test(
      "Given GetProofsParam as param, when call execute and error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(proofRepository.getFilters(request: anyNamed('request')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(
        useCase.execute(param: param), throwsA(CommonMocks.exception));

    // Then
    var getIdentityCaptured =
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured;
    expect(getIdentityCaptured[0], CommonMocks.did);

    var getRequestsCaptured =
        verify(getProofRequestsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getRequestsCaptured[0], Iden3commMocks.authRequest);

    var verifyIsFilterSupported = verify(isProofCircuitSupportedUseCase.execute(
        param: captureAnyNamed('param')));
    expect(verifyIsFilterSupported.callCount, 1);

    expect(verifyIsFilterSupported.captured[0],
        Iden3commMocks.proofRequestList[0].scope.circuitId);

    var verifyGetFilters =
        verify(proofRepository.getFilters(request: captureAnyNamed('request')));
    expect(verifyGetFilters.callCount, 1);
    expect(verifyGetFilters.captured[0], Iden3commMocks.proofRequestList[0]);

    verifyNever(getClaimsUseCase.execute(param: captureAnyNamed('param')));
    verifyNever(proofRepository.loadCircuitFiles(captureAny));
    verifyNever(generateProofUseCase.execute(param: captureAnyNamed('param')));
  });
}
