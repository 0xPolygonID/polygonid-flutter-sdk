import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';

import '../../common_mocks.dart';
import 'get_config_use_case_test.mocks.dart';

// class MockGetEnvUseCase extends Mock implements GetEnvUseCase {}

// Dependencies
MockConfigRepository configRepository = MockConfigRepository();
MockGetEnvUseCase getEnvUseCase = MockGetEnvUseCase();

// Tested instance
GetConfigUseCase useCase = GetConfigUseCase(configRepository, getEnvUseCase);

// Result
List<PolygonIdConfig> envParam = [
  PolygonIdConfig.blockchain,
  PolygonIdConfig.network,
  PolygonIdConfig.envUrl,
  PolygonIdConfig.envRdpUrl,
  PolygonIdConfig.envApiKey,
  PolygonIdConfig.idStateContractAddress,
];
List<PolygonIdConfig> configParam = [PolygonIdConfig.pushUrl];

@GenerateMocks([
  ConfigRepository,
  GetEnvUseCase,
])
void main() {
  setUp(() {
    // Given
    when(getEnvUseCase.execute())
        .thenAnswer((realInvocation) => Future.value(CommonMocks.env));
    when(configRepository.getConfig(config: anyNamed('config')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.config));
  });

  test(
      "Given a PolygonIdConfig, when I call execute, then I expect a String to be returned",
      () async {
    // When
    for (var config in PolygonIdConfig.values) {
      expect(await useCase.execute(param: config), isA<String>());
    }

    // Then
    var captureEnv =
        verify(getEnvUseCase.execute(param: captureAnyNamed('param'))).captured;
    expect(captureEnv.length, envParam.length);

    for (int i = 0; i < envParam.length; i++) {
      expect(captureEnv[i], null);
    }

    var captureConfig =
        verify(configRepository.getConfig(config: captureAnyNamed('config')))
            .captured;
    expect(captureConfig.length, configParam.length);

    for (int i = 0; i < configParam.length; i++) {
      expect(captureConfig[i], configParam[i]);
    }
  });

  test(
      "Given a PolygonIdConfig, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getEnvUseCase.execute())
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));
    when(configRepository.getConfig(config: anyNamed('config')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    for (var config in PolygonIdConfig.values) {
      await expectLater(
          useCase.execute(param: config), throwsA(CommonMocks.exception));
    }

    // Then
    var captureEnv =
        verify(getEnvUseCase.execute(param: captureAnyNamed('param'))).captured;
    expect(captureEnv.length, envParam.length);

    for (int i = 0; i < envParam.length; i++) {
      expect(captureEnv[i], null);
    }

    var captureConfig =
        verify(configRepository.getConfig(config: captureAnyNamed('config')))
            .captured;
    expect(captureConfig.length, configParam.length);

    for (int i = 0; i < configParam.length; i++) {
      expect(captureConfig[i], configParam[i]);
    }
  });
}
