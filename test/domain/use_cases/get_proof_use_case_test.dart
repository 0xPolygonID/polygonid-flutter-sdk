import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import '../../common/proof_mocks.dart';
import 'get_proof_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const publicKeys = ["pubX", "pubY"];
const message = "theMessage";
const challenge = "theChallenge";

const privateIdentityEntity = PrivateIdentityEntity(
  did: identifier,
  publicKey: publicKeys,
  privateKey: privateKey,
);

ClaimEntity mockClaimEntity = ClaimEntity(
  id: "1",
  issuer: "theIssuer",
  did: identifier,
  state: ClaimState.active,
  type: "theType",
  info: {},
);

List<JWZProofEntity> result = [
  JWZProofEntity(
    id: proofRequestList[0].scope.id,
    circuitId: proofRequestList[0].scope.circuit_id,
    proof: ProofMocks.jwzProof.proof,
    pubSignals: ProofMocks.jwzProof.pubSignals,
  )
];

GetClaimsParam mockGetClaimsParam = GetClaimsParam(
  filters: [],
  did: identifier,
  privateKey: privateKey,
);

List<ProofRequestEntity> proofRequestList = [
  ProofRequestEntity(Iden3commMocks.proofScopeRequest,
      ProofQueryParamEntity('theField', [0, 1, 2], 3))
];

GetProofsParam param = GetProofsParam(
  message: Iden3commMocks.authRequest,
  did: identifier,
  privateKey: privateKey,
  challenge: challenge,
);
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(CommonMocks.circuitId, datFile, zKeyFile);
CircuitDataEntity mockCircuitDataEntity = CircuitDataEntity(
  CommonMocks.circuitId,
  datFile,
  zKeyFile,
);

var exception = ProofsNotFoundException([]);

const mockSignature = "theSignature";

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
    getProofRequestsUseCase);

@GenerateMocks([
  ProofRepository,
  IdentityRepository,
  GetClaimsUseCase,
  GenerateProofUseCase,
  IsProofCircuitSupportedUseCase,
  GetProofRequestsUseCase
])
main() {
  test(
      "given GetProofsParam as param, when call execute, then expect a list of ProofEntity to be returned",
      () async {
    //Given
    when(identityRepository.getIdentity(did: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(privateIdentityEntity));

    when(getProofRequestsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(proofRequestList));

    when(isProofCircuitSupportedUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(true));

    when(proofRepository.getFilters(request: anyNamed('request')))
        .thenAnswer((realInvocation) => Future.value([]));

    when(getClaimsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value([mockClaimEntity]));

    when(proofRepository.loadCircuitFiles(any))
        .thenAnswer((realInvocation) => Future.value(mockCircuitDataEntity));

    when(identityRepository.signMessage(
            privateKey: anyNamed('privateKey'), message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.value(mockSignature));

    when(generateProofUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.jwzProof));

    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var getIdentityCaptured = verify(
            identityRepository.getIdentity(did: captureAnyNamed('identifier')))
        .captured;
    expect(getIdentityCaptured[0], identifier);

    var getRequestsCaptured =
        verify(getProofRequestsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getRequestsCaptured[0], Iden3commMocks.authRequest);

    var isFilterSupportedCaptured = verify(isProofCircuitSupportedUseCase
            .execute(param: captureAnyNamed('param')))
        .captured;
    expect(isFilterSupportedCaptured[0], CommonMocks.circuitId);

    var getFiltersCaptured =
        verify(proofRepository.getFilters(request: captureAnyNamed('request')))
            .captured;
    expect(getFiltersCaptured[0], proofRequestList[0]);

    var getClaimsCaptured =
        verify(getClaimsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getClaimsCaptured[0].did, mockGetClaimsParam.did);
    expect(getClaimsCaptured[0].privateKey, mockGetClaimsParam.privateKey);
    expect(getClaimsCaptured[0].filters, mockGetClaimsParam.filters);

    var loadCircuitFilesCaptured =
        verify(proofRepository.loadCircuitFiles(captureAny)).captured;
    expect(loadCircuitFilesCaptured[0], CommonMocks.circuitId);

    var signMessageCaptured = verify(identityRepository.signMessage(
            privateKey: captureAnyNamed('privateKey'),
            message: captureAnyNamed('message')))
        .captured;
    expect(signMessageCaptured[0], param.privateKey);
    expect(signMessageCaptured[1], param.challenge);

    var generateProofCaptured =
        verify(generateProofUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(generateProofCaptured[0].circuitData, mockCircuitDataEntity);
  });

  test(
      "Given GetProofsParam as param, when call execute and error occurred, then I expect an exception to be thrown",
      () async {
    /*reset(identityRepository);
    reset(proofRepository);

    // Given
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(privateIdentityEntity));

    when(proofRepository.getRequests(message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.value(proofRequestList));

    when(isProofCircuitSupportedUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(false));

    // When
    expect(useCase.execute(param: param), throwsA(exception));*/
  });
}
