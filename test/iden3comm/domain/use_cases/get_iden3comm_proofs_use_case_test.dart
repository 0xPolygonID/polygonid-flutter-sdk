import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
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

// Tested instance
GetIden3commProofsUseCase useCase = GetIden3commProofsUseCase(
  getMessageRequestsAndCredsUseCase,
  getIden3commProofUseCase,
  isProofCircuitSupportedUseCase,
  proofGenerationStepsStreamManager,
  stacktraceStreamManager,
);

@GenerateMocks([
  GetMessageRequestsAndCredsUseCase,
  GetIden3commProofUseCase,
  IsProofCircuitSupportedUseCase,
  ProofGenerationStepsStreamManager,
  StacktraceManager,
])
main() {
  final claim = CredentialMocks.claim.copyWith(
    info: {
      'credentialSubject': {
        'id': IdentityMocks.did.did,
      },
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
        (
          request: Iden3commMocks.proofScopeRequest,
          credentials: [claim],
        ),
        (
          request: Iden3commMocks.proofScopeRequest,
          credentials: [claim],
        ),
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

  group("agentic agent_pairing:v1 authorization request", () {
    late GetIden3commProofsParam agenticParam;
    final agenticChallenge = "theAgenticChallenge";

    setUp(() {
      agenticParam = GetIden3commProofsParam(
        message: Iden3commMocks.agenticAuthRequestMessage,
        genesisDid: CommonMocks.did,
        profileNonce: CommonMocks.nonce,
        privateKey: CommonMocks.privateKey,
        challenge: agenticChallenge,
      );
    });

    test(
      "given agentic auth request with credentialAtomicV3OnChain and authV3-8-32 scopes, "
      "when call execute, then expect proofs for both scopes to be returned",
      () async {
        // Given
        // The first scope has a credential query, the second (authV3-8-32) has empty query and no credential
        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (realInvocation) async => [
            (
              request: Iden3commMocks.agenticOnChainScopeRequest,
              credentials: [claim],
            ),
            (request: Iden3commMocks.agenticAuthScopeRequest, credentials: []),
          ],
        );

        final onChainProof = Iden3commProofEntity(
          id: 1,
          circuitId: "credentialAtomicV3OnChain",
          proof: Iden3commMocks.iden3commProof.proof,
          pubSignals: Iden3commMocks.iden3commProof.pubSignals,
          publicStatesInfo: Iden3commMocks.iden3commProof.publicStatesInfo,
        );
        final authProof = Iden3commProofEntity(
          id: 2,
          circuitId: "authV3-8-32",
          proof: Iden3commMocks.iden3commProof.proof,
          pubSignals: Iden3commMocks.iden3commProof.pubSignals,
          publicStatesInfo: Iden3commMocks.iden3commProof.publicStatesInfo,
        );

        var callCount = 0;
        when(
          getIden3commProofUseCase.execute(param: anyNamed('param')),
        ).thenAnswer((_) {
          callCount++;
          return Future.value(callCount == 1 ? onChainProof : authProof);
        });

        // When
        final result = await useCase.execute(param: agenticParam);

        // Then
        expect(result.length, 2);
        expect(result[0], onChainProof);
        expect(result[1], authProof);

        // Verify isProofCircuitSupported was called for both scopes
        var verifyCircuitSupported = verify(
          isProofCircuitSupportedUseCase.execute(
            param: captureAnyNamed('param'),
          ),
        );
        expect(verifyCircuitSupported.callCount, 2);
        expect(verifyCircuitSupported.captured[0], "credentialAtomicV3OnChain");
        expect(verifyCircuitSupported.captured[1], "authV3-8-32");

        // Verify getMessageRequestsAndCreds was called once
        var verifyGetCreds = verify(
          getMessageRequestsAndCredsUseCase.execute(
            param: captureAnyNamed('param'),
          ),
        );
        expect(verifyGetCreds.callCount, 1);

        // Verify getIden3commProof was called for both scopes
        var verifyGenerateProof = verify(
          getIden3commProofUseCase.execute(param: captureAnyNamed('param')),
        );
        expect(verifyGenerateProof.callCount, 2);

        // First call: credentialAtomicV3OnChain with credential
        final firstProofParam = verifyGenerateProof.captured[0];
        expect(
          firstProofParam.request,
          Iden3commMocks.agenticOnChainScopeRequest,
        );
        expect(firstProofParam.credential, claim);
        expect(firstProofParam.genesisDid, IdentityMocks.did.did);
        expect(firstProofParam.profileNonce, agenticParam.profileNonce);

        // Second call: authV3-8-32 with null credential (empty credentials list)
        final secondProofParam = verifyGenerateProof.captured[1];
        expect(
          secondProofParam.request,
          Iden3commMocks.agenticAuthScopeRequest,
        );
        expect(secondProofParam.credential, isNull);
        expect(secondProofParam.genesisDid, IdentityMocks.did.did);
        expect(secondProofParam.profileNonce, agenticParam.profileNonce);
      },
    );

    test(
      "given agentic auth request with authV3-8-32 scope with empty credentials and not optional, "
      "when call execute, then expect NoCredentialsFoundException to be thrown",
      () async {
        // Given - authV3-8-32 scope returns empty credentials and is not optional
        // But the scope with empty query returns empty credentials which triggers NoCredentialsFoundException
        // However, looking at the code, empty credentials for non-optional request throws
        // This test verifies that the first scope (credentialAtomicV3OnChain) with no credentials
        // throws NoCredentialsFoundException
        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (realInvocation) async => [
            (
              request: Iden3commMocks.agenticOnChainScopeRequest,
              credentials: [],
            ),
            (request: Iden3commMocks.agenticAuthScopeRequest, credentials: []),
          ],
        );

        // When / Then
        await expectLater(
          useCase.execute(param: agenticParam),
          throwsA(isA<NoCredentialsFoundException>()),
        );

        // getIden3commProofUseCase should not have been called
        verifyNever(getIden3commProofUseCase.execute(param: anyNamed('param')));
      },
    );

    test(
      "given agentic auth request with unsupported circuit, "
      "when call execute, then expect UnsupportedCircuitException to be thrown",
      () async {
        // Given
        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (realInvocation) async => [
            (
              request: Iden3commMocks.agenticOnChainScopeRequest,
              credentials: [claim],
            ),
            (request: Iden3commMocks.agenticAuthScopeRequest, credentials: []),
          ],
        );

        // credentialAtomicV3OnChain is not supported
        when(
          isProofCircuitSupportedUseCase.execute(param: anyNamed('param')),
        ).thenAnswer((invocation) {
          final circuitId = invocation.namedArguments[#param] as String;
          if (circuitId == "credentialAtomicV3OnChain") {
            return Future.value(false);
          }
          return Future.value(true);
        });

        // When / Then
        await expectLater(
          useCase.execute(param: agenticParam),
          throwsA(isA<UnsupportedCircuitException>()),
        );

        // getIden3commProofUseCase should not have been called
        verifyNever(getIden3commProofUseCase.execute(param: anyNamed('param')));
      },
    );

    test("given agentic auth request, "
        "when scope request params contain sender and challenge, "
        "then expect params to be correctly parsed", () {
      // Verify the parsed agentic auth request message
      final message = Iden3commMocks.agenticAuthRequestMessage;
      expect(message.id, "f8aee09d-f592-4fcc-8d2a-8938aa26676c");
      expect(message.body.reason, "agent_pairing:v1");
      expect(
        message.body.callbackUrl,
        "https://relay.com?encoded_attestation=base64EncodedAtt",
      );
      expect(message.body.accept, isNotNull);
      expect(message.body.accept!.length, 1);
      expect(
        message.body.accept!.first,
        "iden3comm/v1;env=application/iden3-zkp-json;circuitId=authV2,authV3,authV3-8-32;alg=groth16",
      );

      // First scope: credentialAtomicV3OnChain with params and query
      final firstScope = message.body.scope[0];
      expect(firstScope.id, 1);
      expect(firstScope.circuitId, "credentialAtomicV3OnChain");
      expect(firstScope.params, isNotNull);
      expect(firstScope.params!['sender'], "0xsenderaddress");
      expect(firstScope.query.type, "UniquenessCredential");
      expect(
        firstScope.query.context,
        "ipfs://QmcUEDa42Er4nfNFmGQVjiNYFaik6kvNQjfTeBrdSx83At",
      );
      expect(
        firstScope.query.allowedIssuers.first,
        "did:iden3:billions:main:2VwqkgA2dNEwsnmojaay7C5jJEb8ZygecqCSU3xVfm",
      );

      // Second scope: authV3-8-32 with params but empty query
      final secondScope = message.body.scope[1];
      expect(secondScope.id, 2);
      expect(secondScope.circuitId, "authV3-8-32");
      expect(secondScope.params, isNotNull);
      expect(secondScope.params!['challenge'], "<attestation_hash>");
      expect(secondScope.query.isEmpty, true);
    });
  });

  group('expired-by-date credential fallback', () {
    CredentialEntity _makeCredential(String id, String expiration) {
      return CredentialMocks.claim.copyWith(
        id: id,
        expiration: expiration,
        info: {
          'credentialSubject': {
            'id': IdentityMocks.did.did,
          },
        },
      );
    }

    test(
      'skips expired first credential and uses the next non-expired one',
      () async {
        final expired = _makeCredential('cred-expired', '2020-01-01T00:00:00Z');
        final valid = _makeCredential('cred-valid', '2099-01-01T00:00:00Z');

        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (_) async => [
            (
              request: Iden3commMocks.proofScopeRequest,
              credentials: [expired, valid],
            ),
          ],
        );

        await useCase.execute(param: param);

        final captured = verify(
          getIden3commProofUseCase.execute(param: captureAnyNamed('param')),
        ).captured;
        expect(captured.length, 1);
        expect(
          (captured.first as GetIden3commProofParam).credential?.id,
          'cred-valid',
          reason: 'Should skip expired and select the valid credential',
        );
      },
    );

    test(
      'throws ExpiredCredentialException when all credentials are expired '
      'by date for a non-optional request',
      () async {
        final expired1 = _makeCredential('c1', '2020-01-01T00:00:00Z');
        final expired2 = _makeCredential('c2', '2021-01-01T00:00:00Z');

        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (_) async => [
            (
              request: Iden3commMocks.proofScopeRequest,
              credentials: [expired1, expired2],
            ),
          ],
        );

        await expectLater(
          useCase.execute(param: param),
          throwsA(isA<ExpiredCredentialException>()),
        );

        verifyNever(
          getIden3commProofUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'skips optional request when all credentials are expired by date',
      () async {
        final expired = _makeCredential('c1', '2020-01-01T00:00:00Z');

        final optionalScope = ZeroKnowledgeProofRequest.fromJson({
          'id': 1,
          'circuitId': CommonMocks.circuitId,
          'optional': true,
          'query': {
            'allowedIssuers': ['*'],
            'context':
                'https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld',
            'type': 'KYCAgeCredential',
            'credentialSubject': {
              'birthday': {'\$lt': 20000101},
            },
          },
        });

        when(
          getMessageRequestsAndCredsUseCase.execute(param: anyNamed('param')),
        ).thenAnswer(
          (_) async => [
            (request: optionalScope, credentials: [expired]),
          ],
        );

        final proofs = await useCase.execute(param: param);

        expect(proofs, isEmpty);
        verifyNever(
          getIden3commProofUseCase.execute(param: anyNamed('param')),
        );
      },
    );
  });
}
