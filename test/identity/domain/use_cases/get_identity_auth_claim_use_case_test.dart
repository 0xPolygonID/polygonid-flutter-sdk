import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/credential_mocks.dart';
import 'get_identity_auth_claim_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetAuthClaimUseCase getAuthClaimUseCase = MockGetAuthClaimUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

GetIdentityAuthClaimUseCase useCase = GetIdentityAuthClaimUseCase(
  identityRepository,
  getAuthClaimUseCase,
  stacktraceManager,
);

@GenerateMocks([
  IdentityRepository,
  GetAuthClaimUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(identityRepository);
    reset(getAuthClaimUseCase);

    // Given
    when(identityRepository.getPublicKeys(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.pubKeys));
    when(getAuthClaimUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(CredentialMocks.authClaim));
  });

  test(
    'Given a param, when I call execute, then I expect an list of String to be returned',
    () async {
      // When
      expect(await useCase.execute(param: CommonMocks.privateKey),
          CredentialMocks.authClaim);

      // Then
      expect(
          verify(identityRepository.getPublicKeys(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          CommonMocks.privateKey);
      expect(
          verify(getAuthClaimUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.pubKeys);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(identityRepository.getPublicKeys(privateKey: anyNamed('privateKey')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(useCase.execute(param: CommonMocks.privateKey),
          throwsA(CommonMocks.exception));

      // Then
      expect(
          verify(identityRepository.getPublicKeys(
                  privateKey: captureAnyNamed('privateKey')))
              .captured
              .first,
          CommonMocks.privateKey);

      verifyNever(getAuthClaimUseCase.execute(param: captureAnyNamed('param')));
    },
  );
}
