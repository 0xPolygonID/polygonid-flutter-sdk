import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import '../../common_mocks.dart';
import 'get_env_use_case_test.mocks.dart';

// Dependencies
MockConfigRepository configRepository = MockConfigRepository();
MockStacktraceManager stacktraceStreamManager =
    MockStacktraceManager();

// Tested instance
GetEnvUseCase useCase = GetEnvUseCase(
  configRepository,
  stacktraceStreamManager,
);

@GenerateMocks([
  ConfigRepository,
  StacktraceManager,
])
void main() {
  test("When I call execute, I expect an EnvEntity to be returned", () async {
    // Given
    when(configRepository.getEnv())
        .thenAnswer((realInvocation) => Future.value(CommonMocks.env));

    // When
    expect(await useCase.execute(), CommonMocks.env);

    // Then
    verify(configRepository.getEnv());
  });

  test(
      "When I call execute and an error occurred, I expect an exception to be thrown",
      () async {
    // Given
    when(configRepository.getEnv())
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(useCase.execute(), throwsA(CommonMocks.exception));

    // Then
    verify(configRepository.getEnv());
  });
}
