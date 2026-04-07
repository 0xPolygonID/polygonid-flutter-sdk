import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/authenticate.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import '../common/common_mocks.dart';
import '../common/iden3comm_mocks.dart';
import '../common/identity_mocks.dart';
import '../common/proof_mocks.dart';
import 'authenticate_test.mocks.dart';

@GenerateMocks([
  GenerateIden3commProofUseCase,
  ProofGenerationStepsStreamManager,
  StacktraceManager,
])
void main() {
  group('Authenticate.createProofForEveryProofRequest', () {
    late MockGenerateIden3commProofUseCase mockGenerateProof;
    late MockProofGenerationStepsStreamManager mockStreamManager;
    late MockStacktraceManager mockStacktrace;
    late Authenticate authenticate;

    setUp(() async {
      mockGenerateProof = MockGenerateIden3commProofUseCase();
      mockStreamManager = MockProofGenerationStepsStreamManager();
      mockStacktrace = MockStacktraceManager();

      // Reset GetIt for isolation — createProofForEveryProofRequest resolves
      // GenerateIden3commProofUseCase from getItSdk via getAsync.
      await getItSdk.reset();
      getItSdk.registerFactoryAsync<GenerateIden3commProofUseCase>(
        () async => mockGenerateProof,
      );

      authenticate = Authenticate.forTest(
        proofGenerationStepsStreamManager: mockStreamManager,
        stacktraceManager: mockStacktrace,
      );
    });

    tearDown(() async {
      await getItSdk.reset();
    });

    test(
      'uses credentials.first directly without refresh '
      'when credentials are present',
      () async {
        final credential = CredentialEntity(
          id: 'cred-1',
          issuer: CommonMocks.issuer,
          did: CommonMocks.did,
          state: CredentialState.active,
          type: CommonMocks.type,
          info: {
            'credentialSubject': {
              'id': IdentityMocks.identity.profiles[GENESIS_PROFILE_NONCE],
            },
          },
          schema: CommonMocks.aMap,
          expiration: CommonMocks.expiration,
          credentialRawValue: CommonMocks.credentialRawValue,
        );
        final secondCredential = credential.copyWith(id: 'cred-2');

        final expectedProof = Iden3commProofEntity(
          id: Iden3commMocks.proofScopeRequest.id,
          circuitId: Iden3commMocks.proofScopeRequest.circuitId,
          proof: ProofMocks.zkProof.proof,
          pubSignals: ProofMocks.zkProof.pubSignals,
          publicStatesInfo: ProofMocks.publicStatesInfo,
        );

        when(mockGenerateProof.execute(param: anyNamed('param')))
            .thenAnswer((_) async => expectedProof);

        final requestsAndCreds = <RequestAndCredentials>[
          (
            request: Iden3commMocks.proofScopeRequest,
            credentials: [credential, secondCredential],
          ),
        ];

        final proofs = await authenticate.createProofForEveryProofRequest(
          requestsAndCreds: requestsAndCreds,
          identityEntity: IdentityMocks.identity,
          genesisDid: CommonMocks.did,
          profileNonce: CommonMocks.nonce,
          privateKey: CommonMocks.privateKey,
          challenge: null,
          env: CommonMocks.env,
          verifierDid: CommonMocks.did,
          transactionData: null,
        );

        expect(proofs.length, 1);
        expect(proofs.first, expectedProof);

        // Verify GenerateIden3commProofUseCase received the FIRST credential
        // directly — no refresh step.
        final captured = verify(
          mockGenerateProof.execute(param: captureAnyNamed('param')),
        ).captured;
        expect(captured.length, 1);
        final proofParam = captured.first as GenerateIden3commProofParam;
        expect(
          proofParam.credential.id,
          'cred-1',
          reason: 'Must use credentials.first without refresh',
        );
      },
    );

    test(
      'skips optional request when credentials list is empty',
      () async {
        final optionalRequest = ZeroKnowledgeProofRequest.fromJson({
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

        final requestsAndCreds = <RequestAndCredentials>[
          (request: optionalRequest, credentials: <CredentialEntity>[]),
        ];

        final proofs = await authenticate.createProofForEveryProofRequest(
          requestsAndCreds: requestsAndCreds,
          identityEntity: IdentityMocks.identity,
          genesisDid: CommonMocks.did,
          profileNonce: CommonMocks.nonce,
          privateKey: CommonMocks.privateKey,
          challenge: null,
          env: CommonMocks.env,
          verifierDid: CommonMocks.did,
          transactionData: null,
        );

        expect(proofs, isEmpty);
        verifyNever(mockGenerateProof.execute(param: anyNamed('param')));
      },
    );

    test(
      'throws NoCredentialsFoundException for non-optional request '
      'with empty credentials',
      () async {
        final requestsAndCreds = <RequestAndCredentials>[
          (
            request: Iden3commMocks.proofScopeRequest,
            credentials: <CredentialEntity>[],
          ),
        ];

        await expectLater(
          authenticate.createProofForEveryProofRequest(
            requestsAndCreds: requestsAndCreds,
            identityEntity: IdentityMocks.identity,
            genesisDid: CommonMocks.did,
            profileNonce: CommonMocks.nonce,
            privateKey: CommonMocks.privateKey,
            challenge: null,
            env: CommonMocks.env,
            verifierDid: CommonMocks.did,
            transactionData: null,
          ),
          throwsA(isA<NoCredentialsFoundException>()),
        );

        verifyNever(mockGenerateProof.execute(param: anyNamed('param')));
      },
    );

    group('expired-by-date safety-net', () {
      CredentialEntity _makeCredential(String id, String expiration) {
        return CredentialEntity(
          id: id,
          issuer: CommonMocks.issuer,
          did: CommonMocks.did,
          state: CredentialState.active, // state is stale
          type: CommonMocks.type,
          info: {
            'credentialSubject': {
              'id': IdentityMocks.identity.profiles[GENESIS_PROFILE_NONCE],
            },
          },
          schema: CommonMocks.aMap,
          expiration: expiration,
          credentialRawValue: CommonMocks.credentialRawValue,
        );
      }

      test(
        'skips expired first credential and uses the next non-expired one',
        () async {
          final expired = _makeCredential('cred-expired', '2020-01-01T00:00:00Z');
          final valid = _makeCredential('cred-valid', '2099-01-01T00:00:00Z');

          final expectedProof = Iden3commProofEntity(
            id: Iden3commMocks.proofScopeRequest.id,
            circuitId: Iden3commMocks.proofScopeRequest.circuitId,
            proof: ProofMocks.zkProof.proof,
            pubSignals: ProofMocks.zkProof.pubSignals,
            publicStatesInfo: ProofMocks.publicStatesInfo,
          );

          when(mockGenerateProof.execute(param: anyNamed('param')))
              .thenAnswer((_) async => expectedProof);

          final requestsAndCreds = <RequestAndCredentials>[
            (
              request: Iden3commMocks.proofScopeRequest,
              credentials: [expired, valid],
            ),
          ];

          final proofs = await authenticate.createProofForEveryProofRequest(
            requestsAndCreds: requestsAndCreds,
            identityEntity: IdentityMocks.identity,
            genesisDid: CommonMocks.did,
            profileNonce: CommonMocks.nonce,
            privateKey: CommonMocks.privateKey,
            challenge: null,
            env: CommonMocks.env,
            verifierDid: CommonMocks.did,
            transactionData: null,
          );

          expect(proofs.length, 1);

          final captured = verify(
            mockGenerateProof.execute(param: captureAnyNamed('param')),
          ).captured;
          final proofParam = captured.first as GenerateIden3commProofParam;
          expect(
            proofParam.credential.id,
            'cred-valid',
            reason: 'Should skip expired credential and use the valid one',
          );
        },
      );

      test(
        'throws ExpiredCredentialException when all credentials are '
        'expired by date for a non-optional request',
        () async {
          final expired1 = _makeCredential('cred-1', '2020-01-01T00:00:00Z');
          final expired2 = _makeCredential('cred-2', '2021-01-01T00:00:00Z');

          final requestsAndCreds = <RequestAndCredentials>[
            (
              request: Iden3commMocks.proofScopeRequest,
              credentials: [expired1, expired2],
            ),
          ];

          await expectLater(
            authenticate.createProofForEveryProofRequest(
              requestsAndCreds: requestsAndCreds,
              identityEntity: IdentityMocks.identity,
              genesisDid: CommonMocks.did,
              profileNonce: CommonMocks.nonce,
              privateKey: CommonMocks.privateKey,
              challenge: null,
              env: CommonMocks.env,
              verifierDid: CommonMocks.did,
              transactionData: null,
            ),
            throwsA(isA<ExpiredCredentialException>()),
          );

          verifyNever(mockGenerateProof.execute(param: anyNamed('param')));
        },
      );

      test(
        'skips optional request when all credentials are expired by date',
        () async {
          final expired = _makeCredential('cred-1', '2020-01-01T00:00:00Z');

          final optionalRequest = ZeroKnowledgeProofRequest.fromJson({
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

          final requestsAndCreds = <RequestAndCredentials>[
            (request: optionalRequest, credentials: [expired]),
          ];

          final proofs = await authenticate.createProofForEveryProofRequest(
            requestsAndCreds: requestsAndCreds,
            identityEntity: IdentityMocks.identity,
            genesisDid: CommonMocks.did,
            profileNonce: CommonMocks.nonce,
            privateKey: CommonMocks.privateKey,
            challenge: null,
            env: CommonMocks.env,
            verifierDid: CommonMocks.did,
            transactionData: null,
          );

          expect(proofs, isEmpty);
          verifyNever(mockGenerateProof.execute(param: anyNamed('param')));
        },
      );
    });
  });
}

