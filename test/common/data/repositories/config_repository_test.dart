import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/env_datasource.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/env_mapper.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/env_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/data/repositories/config_repository_impl.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../../common_mocks.dart';
import 'config_repository_test.mocks.dart';

// Dependencies
MockEnvDataSource envDataSource = MockEnvDataSource();
MockStorageKeyValueDataSource storageKeyValueDataSource =
    MockStorageKeyValueDataSource();
MockEnvMapper envMapper = MockEnvMapper();

// Tested instance
ConfigRepository repository =
    ConfigRepositoryImpl(envDataSource, storageKeyValueDataSource, envMapper);

@GenerateMocks([
  EnvDataSource,
  StorageKeyValueDataSource,
  EnvMapper,
])
void main() {
  group("Get config", () {
    test(
        "Given a PolygonIdConfig, when I call getConfig, I expect a String to be returned",
        () async {
      // Given
      when(envDataSource.getConfig(config: anyNamed('config')))
          .thenReturn(CommonMocks.config);

      // When
      expect(await repository.getConfig(config: PolygonIdConfig.network),
          CommonMocks.config);

      // Then
      expect(
          verify(envDataSource.getConfig(config: captureAnyNamed('config')))
              .captured
              .first,
          PolygonIdConfig.network);
    });

    test(
        "Given a PolygonIdConfig which has no value, when I call getConfig, I expect a ConfigNotSetException to be thrown",
        () async {
      // Given
      when(envDataSource.getConfig(config: anyNamed('config')))
          .thenReturn(null);

      // When
      await repository
          .getConfig(config: PolygonIdConfig.network)
          .then((value) => expect(true, false))
          .catchError((error) {
        expect(error, isA<ConfigNotSetException>());
        expect(error.config, PolygonIdConfig.network);
      });

      // Then
      expect(
          verify(envDataSource.getConfig(config: captureAnyNamed('config')))
              .captured
              .first,
          PolygonIdConfig.network);
    });

    test(
        "Given a PolygonIdConfig, when I call getConfig and an error occurred, I expect a ConfigNotSetException to be thrown",
        () async {
      // Given
      when(envDataSource.getConfig(config: anyNamed('config')))
          .thenThrow(CommonMocks.exception);

      // When
      await repository
          .getConfig(config: PolygonIdConfig.network)
          .then((value) => expect(true, false))
          .catchError((error) => expect(error, CommonMocks.exception));

      // Then
      expect(
          verify(envDataSource.getConfig(config: captureAnyNamed('config')))
              .captured
              .first,
          PolygonIdConfig.network);
    });
  });

  group("Get env", () {
    setUp(() {
      // Given
      when(storageKeyValueDataSource.get(key: anyNamed('key')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.envJson));
      when(envMapper.mapFrom(any))
          .thenAnswer((realInvocation) => CommonMocks.env);
    });

    test("When I call getEnv, I expect an EnvEntity to be returned", () async {
      // When
      expect(await repository.getEnv(), CommonMocks.env);

      // Then
      expect(
          verify(storageKeyValueDataSource.get(key: captureAnyNamed('key')))
              .captured
              .first,
          "env");
      expect(verify(envMapper.mapFrom(captureAny)).captured.first,
          CommonMocks.envJson);
    });

    test(
        "When I call getEnv with no env set, I expect an EnvNotSetException to be thrown",
        () async {
      // Given
      when(storageKeyValueDataSource.get(key: anyNamed('key')))
          .thenAnswer((realInvocation) => Future.value());

      // When
      await expectLater(
          repository.getEnv(), throwsA(isA<EnvNotSetException>()));

      // Then
      expect(
          verify(storageKeyValueDataSource.get(key: captureAnyNamed('key')))
              .captured
              .first,
          "env");
      verifyNever(envMapper.mapFrom(captureAny));
    });

    test(
        "When I call getEnv and an error occurred, I expect an exception to be thrown",
        () async {
      // Given
      when(storageKeyValueDataSource.get(key: anyNamed('key')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(repository.getEnv(), throwsA(CommonMocks.exception));

      // Then
      expect(
          verify(storageKeyValueDataSource.get(key: captureAnyNamed('key')))
              .captured
              .first,
          "env");
      verifyNever(envMapper.mapFrom(captureAny));
    });
  });

  group("Set env", () {
    setUp(() {
      // Given
      when(storageKeyValueDataSource.store(
              key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((realInvocation) => Future.value());
      when(envMapper.mapTo(any))
          .thenAnswer((realInvocation) => CommonMocks.envJson);
    });

    test(
        "Given a EnvEntity, when I call setEnv, I expect the process to complete",
        () async {
      // When
      await expectLater(repository.setEnv(env: CommonMocks.env), completes);

      // Then
      var captureStore = verify(storageKeyValueDataSource.store(
              key: captureAnyNamed('key'), value: captureAnyNamed('value')))
          .captured;
      expect(captureStore[0], "env");
      expect(captureStore[1], CommonMocks.envJson);
      expect(
          verify(envMapper.mapTo(captureAny)).captured.first, CommonMocks.env);
    });

    test(
        "Given a EnvEntity, when I call setEnv and an error occurred, I expect an exception to be thrown",
        () async {
      // Given
      when(storageKeyValueDataSource.store(
              key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(repository.setEnv(env: CommonMocks.env),
          throwsA(CommonMocks.exception));

      // Then
      var captureStore = verify(storageKeyValueDataSource.store(
              key: captureAnyNamed('key'), value: captureAnyNamed('value')))
          .captured;
      expect(captureStore[0], "env");
      expect(captureStore[1], CommonMocks.envJson);
      expect(
          verify(envMapper.mapTo(captureAny)).captured.first, CommonMocks.env);
    });
  });
}
