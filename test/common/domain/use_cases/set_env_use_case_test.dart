import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/set_env_use_case.dart';

import '../../common_mocks.dart';
import 'set_env_use_case_test.mocks.dart';

// Dependencies
MockConfigRepository configRepository = MockConfigRepository();

// Tested instance
SetEnvUseCase useCase = SetEnvUseCase(configRepository);

@GenerateMocks([ConfigRepository])
void main() {
  test(
      "Given an EnvEntity, when I call execute, I expect an EnvEntity to be returned",
      () async {
    // Given
    when(configRepository.setEnv(env: anyNamed('env')))
        .thenAnswer((realInvocation) => Future.value());

    // When
    await expectLater(useCase.execute(param: CommonMocks.env), completes);

    // Then
    expect(
        verify(configRepository.setEnv(env: captureAnyNamed('env')))
            .captured
            .first,
        CommonMocks.env);
  });

  test(
      "Given an EnvEntity, when I call execute and an error occurred, I expect an exception to be thrown",
      () async {
    // Given
    when(configRepository.setEnv(env: anyNamed('env')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(useCase.execute(param: CommonMocks.env),
        throwsA(CommonMocks.exception));

    // Then
    expect(
        verify(configRepository.setEnv(env: captureAnyNamed('env')))
            .captured
            .first,
        CommonMocks.env);
  });
}
