import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/contract_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/fetch_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/offer_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_query_param_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/proof_requests_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/libs/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/use_cases/generate_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/proof.dart';

import 'get_proof_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const publicKeys = ["pubX", "pubY"];
const message = "theMessage";
const challenge = "theChallenge";

const privateIdentityEntity = PrivateIdentityEntity(
  identifier: identifier,
  publicKey: publicKeys,
  privateKey: privateKey,
);

String proofRequestData = '''
{
  "id": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/proofs/1.0/contract-invoke-request",
  "thid": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "from": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
  "body": {
    "transaction_data": {
      "contract_address": "0x516D8DBece16890d0670Dfd3Cb1740FcdF375B10",
      "method_id": "b68967e2",
      "chain_id": 80001,
      "network": "polygon-mumbai"
    },
    "reason": "airdrop participation",
    "scope": [
      {
        "id": 1,
        "circuit_id": "credentialAtomicQueryMTP",
        "rules": {
          "query": {
            "allowed_issuers": [
              "*"
            ],
            "req": {
              "birthday": {
                "\$lt": 20000101
              }
            },
            "schema": {
              "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
              "type": "KYCAgeCredential"
            }
          }
        }
      }
    ]
  }
}
''';

ClaimEntity mockClaimEntity = ClaimEntity(
  id: "1",
  issuer: "theIssuer",
  identifier: identifier,
  state: ClaimState.active,
  type: "theType",
  info: {},
);

String jwzProofData = '''
{
     "proof": {
         "pi_a": [
             "10412436197494479587396667385707368282568055118269864457927476990636419702451",
             "10781739095445201996467414817941805879982410676386176845296376344985187663334",
             "1"
         ],
         "pi_b": [
             [
                 "18067868740006225615447194471370658980999926369695293115712951366707744064606",
                 "21599241570547731234304039989166406415899717659171760043899509152011479663757"
             ],
             [
                 "6699540705074924997967275186324755442260607671536434403065529164769702477398",
                 "11257643293201627450293185164288482420559806649937371568160742601386671659800"
             ],
             [
                 "1",
                 "0"
             ]
         ],
         "pi_c": [
             "6216423503289496292944052032190353625422411483383378979029667243785319208095",
             "14816218045158388758567608605576384994339714390370300963580658386534158603711",
             "1"
         ],
         "protocol": "groth16"
     },
     "pub_signals": [
         "4976943943966365062123221999838013171228156495366270377261380449787871898672",
         "18656147546666944484453899241916469544090258810192803949522794490493271005313",
         "379949150130214723420589610911161895495647789006649785264738141299135414272"
     ]
   }
''';
JWZProof mockJwzProof = JWZProof(
    proof: const JWZBaseProof(
      piA: [
        "10412436197494479587396667385707368282568055118269864457927476990636419702451",
        "10781739095445201996467414817941805879982410676386176845296376344985187663334",
        "1",
      ],
      piB: [
        [
          "18067868740006225615447194471370658980999926369695293115712951366707744064606",
          "21599241570547731234304039989166406415899717659171760043899509152011479663757"
        ],
        [
          "6699540705074924997967275186324755442260607671536434403065529164769702477398",
          "11257643293201627450293185164288482420559806649937371568160742601386671659800"
        ],
        [
          "1",
          "0",
        ]
      ],
      piC: [
        "6216423503289496292944052032190353625422411483383378979029667243785319208095",
        "14816218045158388758567608605576384994339714390370300963580658386534158603711",
        "1",
      ],
      protocol: "groth16",
      curve: "",
    ),
    pubSignals: const [
      "4976943943966365062123221999838013171228156495366270377261380449787871898672",
      "18656147546666944484453899241916469544090258810192803949522794490493271005313",
      "379949150130214723420589610911161895495647789006649785264738141299135414272",
    ]);

List<ProofEntity> result = [
  ProofEntity(
    id: int.parse(proofRequestList[0].id),
    circuitId: proofRequestList[0].circuitId,
    proof: mockJwzProof.proof,
    pubSignals: mockJwzProof.pubSignals,
  )
];

GetClaimsParam mockGetClaimsParam = GetClaimsParam(
  filters: [],
  identifier: identifier,
  privateKey: privateKey,
);

Iden3MessageEntity iden3messageEntity =
    Iden3MessageMapper(Iden3MessageTypeMapper()).mapFrom(proofRequestData);
ProofRequestsMapper proofRequestsMapper = ProofRequestsMapper(
  AuthRequestMapper(Iden3MessageTypeDataMapper()),
  FetchRequestMapper(Iden3MessageTypeDataMapper()),
  OfferRequestMapper(Iden3MessageTypeDataMapper()),
  ContractRequestMapper(Iden3MessageTypeDataMapper()),
  ProofQueryParamMapper(),
);

List<ProofRequestEntity> proofRequestList =
    proofRequestsMapper.mapFrom(iden3messageEntity);

GetProofsParam param = GetProofsParam(
  message: iden3messageEntity,
  identifier: identifier,
  privateKey: privateKey,
  challenge: challenge,
);
const circuitId = "credentialAtomicQueryMTP";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(circuitId, datFile, zKeyFile);
CircuitDataEntity mockCircuitDataEntity = CircuitDataEntity(
  circuitId,
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

// Tested instance
GetProofsUseCase useCase = GetProofsUseCase(
  proofRepository,
  identityRepository,
  getClaimsUseCase,
  generateProofUseCase,
  isProofCircuitSupportedUseCase,
);

@GenerateMocks([
  ProofRepository,
  IdentityRepository,
  GetClaimsUseCase,
  GenerateProofUseCase,
  IsProofCircuitSupportedUseCase,
])
main() {
  test(
      "given GetProofsParam as param, when call execute, then expect a list of ProofEntity to be returned",
      () async {
    //Given
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(privateIdentityEntity));

    when(proofRepository.getRequests(message: anyNamed('message')))
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
        .thenAnswer((realInvocation) => Future.value(mockJwzProof));

    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var getIdentityCaptured = verify(identityRepository.getIdentity(
            identifier: captureAnyNamed('identifier')))
        .captured;
    expect(getIdentityCaptured[0], identifier);

    var getRequestsCaptured =
        verify(proofRepository.getRequests(message: captureAnyNamed('message')))
            .captured;
    expect(getRequestsCaptured[0], iden3messageEntity);

    var isFilterSupportedCaptured = verify(isProofCircuitSupportedUseCase
            .execute(param: captureAnyNamed('param')))
        .captured;
    expect(isFilterSupportedCaptured[0], circuitId);

    var getFiltersCaptured =
        verify(proofRepository.getFilters(request: captureAnyNamed('request')))
            .captured;
    expect(getFiltersCaptured[0], proofRequestList[0]);

    var getClaimsCaptured =
        verify(getClaimsUseCase.execute(param: captureAnyNamed('param')))
            .captured;
    expect(getClaimsCaptured[0].identifier, mockGetClaimsParam.identifier);
    expect(getClaimsCaptured[0].privateKey, mockGetClaimsParam.privateKey);
    expect(getClaimsCaptured[0].filters, mockGetClaimsParam.filters);

    var loadCircuitFilesCaptured =
        verify(proofRepository.loadCircuitFiles(captureAny)).captured;
    expect(loadCircuitFilesCaptured[0], circuitId);

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
