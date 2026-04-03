import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_and_refresh_expired_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

import '../../../common/common_mocks.dart';
import '../../../common/credential_mocks.dart';
import 'check_and_refresh_expired_credential_use_case_test.mocks.dart';

// Active credential — expiration in 2050, state active
CredentialEntity _activeCredential() => CredentialMocks.claim;

// Expired by date (2020), state active (no refreshService)
CredentialEntity _expiredCredential() => CredentialEntity(
      id: CommonMocks.id,
      issuer: CommonMocks.issuer,
      did: CommonMocks.did,
      state: CredentialState.active,
      type: CommonMocks.type,
      expiration: "2020-01-01T00:00:00Z",
      info: CommonMocks.aMap,
      credentialRawValue: CommonMocks.credentialRawValue,
    );

// Expired by date (2020), has refreshService
CredentialEntity _expiredWithRefreshService() => CredentialEntity(
      id: CommonMocks.id,
      issuer: CommonMocks.issuer,
      did: CommonMocks.did,
      state: CredentialState.active,
      type: CommonMocks.type,
      expiration: "2020-01-01T00:00:00Z",
      info: {
        ...CommonMocks.aMap,
        'refreshService': {
          'id': 'https://refresh.example.com',
          'type': 'Iden3RefreshService2023',
        },
      },
      credentialRawValue: CommonMocks.credentialRawValue,
    );

// Null expiration — treated as non-expiring
CredentialEntity _nullExpirationCredential() => CredentialEntity(
      id: CommonMocks.id,
      issuer: CommonMocks.issuer,
      did: CommonMocks.did,
      state: CredentialState.active,
      type: CommonMocks.type,
      expiration: null,
      info: CommonMocks.aMap,
      credentialRawValue: CommonMocks.credentialRawValue,
    );

// Expired via state flag (future date, but state=expired)
CredentialEntity _stateExpiredCredential() =>
    CredentialMocks.claim.copyWith(state: CredentialState.expired);

CheckAndRefreshExpiredCredentialParam _makeParam(
  List<CredentialEntity> credentials,
) =>
    CheckAndRefreshExpiredCredentialParam(
      credentials: credentials,
      genesisDid: CommonMocks.did,
      privateKey: CommonMocks.privateKey,
    );

// Mocked dependencies
MockRefreshCredentialUseCase refreshCredentialUseCase =
    MockRefreshCredentialUseCase();
MockUpdateClaimUseCase updateClaimUseCase = MockUpdateClaimUseCase();
MockProofGenerationStepsStreamManager proofGenerationStepsStreamManager =
    MockProofGenerationStepsStreamManager();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
CheckAndRefreshExpiredCredentialUseCase useCase =
    CheckAndRefreshExpiredCredentialUseCase(
  refreshCredentialUseCase,
  updateClaimUseCase,
  proofGenerationStepsStreamManager,
  stacktraceManager,
);

@GenerateMocks([
  RefreshCredentialUseCase,
  UpdateClaimUseCase,
  ProofGenerationStepsStreamManager,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(refreshCredentialUseCase);
    reset(updateClaimUseCase);
    reset(proofGenerationStepsStreamManager);
    reset(stacktraceManager);
    when(proofGenerationStepsStreamManager.add(any)).thenReturn(null);
    when(stacktraceManager.addError(any, log: anyNamed('log'))).thenReturn(
        null);
    when(stacktraceManager.addTrace(any, log: anyNamed('log'))).thenReturn(
        null);
    // Default: DB write succeeds (return value is not used by the use case).
    when(updateClaimUseCase.execute(param: anyNamed('param')))
        .thenAnswer((_) => Future.value(_expiredCredential()));
  });

  group('single active credential', () {
    test(
      'given an active (non-expired) credential, when executed, '
          'then returns the credential without calling refresh',
          () async {
        final credential = _activeCredential();

        final result = await useCase.execute(param: _makeParam([credential]));

        expect(result, credential);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given a credential with null expiration, when executed, '
          'then returns the credential without calling refresh',
          () async {
        final credential = _nullExpirationCredential();

        final result = await useCase.execute(param: _makeParam([credential]));

        expect(result, credential);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );
  });

  group('single expired credential', () {
    test(
      'given an expired credential (past date) without refreshService, when executed, '
          'then returns null without calling refresh',
          () async {
        final result = await useCase.execute(
          param: _makeParam([_expiredCredential()]),
        );

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given a credential with state=expired (future date), when executed, '
          'then treats it as expired and returns null',
          () async {
        final result = await useCase.execute(
          param: _makeParam([_stateExpiredCredential()]),
        );

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given a credential with state=expired and null expiration, when executed, '
          'then treats it as expired and returns null (does not crash or return it as usable)',
          () async {
        final credential = CredentialEntity(
          id: CommonMocks.id,
          issuer: CommonMocks.issuer,
          did: CommonMocks.did,
          state: CredentialState.expired,
          expiration: null,
          // no date, but state flag is set
          type: CommonMocks.type,
          info: CommonMocks.aMap,
          credentialRawValue: CommonMocks.credentialRawValue,
        );

        final result = await useCase.execute(param: _makeParam([credential]));

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given an expired credential with refreshService, when refresh succeeds, '
          'then returns the refreshed credential',
          () async {
        final refreshed = _activeCredential();
        when(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        ).thenAnswer((_) => Future.value(refreshed));

        final result = await useCase.execute(
          param: _makeParam([_expiredWithRefreshService()]),
        );

        expect(result, refreshed);
        verify(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        ).called(1);
      },
    );

    test(
      'given a credential with an unparseable expiration string, when executed, '
          'then returns null without calling refresh and logs the parse error',
          () async {
        final credential = CredentialEntity(
          id: CommonMocks.id,
          issuer: CommonMocks.issuer,
          did: CommonMocks.did,
          state: CredentialState.active,
          type: CommonMocks.type,
          expiration: "not-a-date",
          info: CommonMocks.aMap,
          credentialRawValue: CommonMocks.credentialRawValue,
        );

        final result = await useCase.execute(param: _makeParam([credential]));

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
        verify(stacktraceManager.addError(
          argThat(contains('[CheckAndRefreshExpiredCredentialUseCase]')),
          log: true,
        )).called(1);
      },
    );

    test(
      'given an expired credential with refreshService, when refresh throws, '
          'then returns null, logs the error via StacktraceManager, '
          'and emits a failure step',
          () async {
        when(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        ).thenThrow(Exception('refresh failed'));

        final result = await useCase.execute(
          param: _makeParam([_expiredWithRefreshService()]),
        );

        expect(result, isNull);
        verify(stacktraceManager.addError(
          argThat(contains('[CheckAndRefreshExpiredCredentialUseCase]')),
          log: true,
        )).called(1);
        verify(proofGenerationStepsStreamManager.add(
          argThat(contains('Credential refresh failed')),
        )).called(1);
      },
    );
  });

  group('empty credentials list', () {
    test(
      'given an empty list, when executed, then returns null',
          () async {
        final result = await useCase.execute(param: _makeParam([]));

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );
  });

  group('multiple credentials — fallthrough behaviour', () {
    test(
      'given [expired (no refresh), active], when executed, '
          'then skips first and returns second credential',
          () async {
        final active = _activeCredential();

        final result = await useCase.execute(
          param: _makeParam([_expiredCredential(), active]),
        );

        expect(result, active);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given [expired+refreshService, active], when executed, '
          'then marks expired in DB and returns active WITHOUT attempting refresh',
          () async {
        final active = _activeCredential();

        final result = await useCase.execute(
          param: _makeParam([_expiredWithRefreshService(), active]),
        );

        expect(result, active);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
        verify(
          updateClaimUseCase.execute(param: anyNamed('param')),
        ).called(1);
      },
    );

    test(
      'given all expired credentials without refreshService, when executed, '
          'then returns null',
          () async {
        final result = await useCase.execute(
          param: _makeParam([_expiredCredential(), _expiredCredential()]),
        );

        expect(result, isNull);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );

    test(
      'given [expired+refreshService, active], when executed, '
          'then returns the active credential without attempting refresh '
          '(valid credential takes priority over refresh)',
          () async {
        final anotherActive = CredentialEntity(
          id: 'anotherId',
          issuer: CommonMocks.issuer,
          did: CommonMocks.did,
          state: CredentialState.active,
          type: CommonMocks.type,
          expiration: "2050-06-01T00:00:00Z",
          info: CommonMocks.aMap,
          credentialRawValue: CommonMocks.credentialRawValue,
        );

        final result = await useCase.execute(
          param: _makeParam([_expiredWithRefreshService(), anotherActive]),
        );

        expect(result, anotherActive);
        verifyNever(
          refreshCredentialUseCase.execute(param: anyNamed('param')),
        );
      },
    );
    group('DB state update', () {
      test(
        'given an expired-by-date credential with state:active, '
            'when executed, then marks it as expired in DB (Phase 1)',
            () async {
          final expired = _expiredCredential(); // state:active, date:2020

          await useCase.execute(param: _makeParam([expired]));

          final captured = verify(
            updateClaimUseCase.execute(param: captureAnyNamed('param')),
          ).captured.single as UpdateClaimParam;
          expect(captured.id, expired.id);
          expect(captured.state, CredentialState.expired);
          expect(captured.genesisDid, CommonMocks.did);
          expect(captured.encryptionKey, CommonMocks.privateKey);
        },
      );

      test(
        'given a credential already state:expired, '
            'when executed, then does NOT write to DB again',
            () async {
          await useCase.execute(
            param: _makeParam([_stateExpiredCredential()]),
          );

          verifyNever(updateClaimUseCase.execute(param: anyNamed('param')));
        },
      );

      test(
        'given a non-expired credential, '
            'when executed, then does NOT write to DB',
            () async {
          await useCase.execute(param: _makeParam([_activeCredential()]));

          verifyNever(updateClaimUseCase.execute(param: anyNamed('param')));
        },
      );

      test(
        'given an expired credential where the DB write fails, '
            'when executed, then logs the error and still attempts refresh',
            () async {
          when(updateClaimUseCase.execute(param: anyNamed('param')))
              .thenThrow(Exception('DB write failed'));
          final refreshed = _activeCredential();
          when(refreshCredentialUseCase.execute(param: anyNamed('param')))
              .thenAnswer((_) => Future.value(refreshed));

          final result = await useCase.execute(
            param: _makeParam([_expiredWithRefreshService()]),
          );

          expect(result, refreshed);
          verify(stacktraceManager.addError(
            argThat(contains('[CheckAndRefreshExpiredCredentialUseCase]')),
            log: true,
          )).called(1);
          verify(refreshCredentialUseCase.execute(param: anyNamed('param')))
              .called(1);
        },
      );
    });
  });
}
