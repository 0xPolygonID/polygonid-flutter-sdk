import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/check_identity_validity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_private_key_use_case.dart';

import '../../../../common/common_mocks.dart';
import 'check_identity_validity_use_case_test.mocks.dart';

// Dependencies
MockGetPrivateKeyUseCase getPrivateKeyUseCase = MockGetPrivateKeyUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
CheckIdentityValidityUseCase useCase = CheckIdentityValidityUseCase(
  getPrivateKeyUseCase,
  getCurrentEnvDidIdentifierUseCase,
  stacktraceManager,
);

@GenerateMocks([
  GetPrivateKeyUseCase,
  GetCurrentEnvDidIdentifierUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    // Given
    when(getPrivateKeyUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.privateKey));
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
      "Given a secret, when I call execute, then I the process to complete successfully",
      () async {
    // When
    await expectLater(useCase.execute(param: CommonMocks.message), completes);

    // Then
    expect(
        verify(getPrivateKeyUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.message);
    expect(
        verify(getCurrentEnvDidIdentifierUseCase.execute(
                param: captureAnyNamed('param')))
            .captured
            .first
            .privateKey,
        CommonMocks.privateKey);
  });

  test(
      "Given a secret, when I call execute and an error occurs, then I expect an exception to be thrown",
      () async {
    // Given
    when(getPrivateKeyUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(useCase.execute(param: CommonMocks.message),
        throwsA(CommonMocks.exception));

    // Then
    expect(
        verify(getPrivateKeyUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.message);

    verifyNever(getCurrentEnvDidIdentifierUseCase.execute(
        param: captureAnyNamed('param')));
  });
}
