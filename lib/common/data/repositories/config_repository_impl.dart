import 'package:polygonid_flutter_sdk/common/data/data_sources/env_datasource.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/env_mapper.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/env_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final EnvDataSource _envDataSource;
  final StorageKeyValueDataSource _storageKeyValueDataSource;
  final EnvMapper _envMapper;

  ConfigRepositoryImpl(
    this._envDataSource,
    this._storageKeyValueDataSource,
    this._envMapper,
  );

  @override
  Future<String> getConfig({required PolygonIdConfig config}) {
    return Future(() => _envDataSource.getConfig(config: config)).then((value) {
      if (value == null) {
        return Future.error(ConfigNotSetException(config));
      }

      return value;
    });
  }

  @override
  Future<EnvEntity> getEnv() {
    return _storageKeyValueDataSource.get(key: "env").then((value) {
      if (value == null) {
        return Future.error(EnvNotSetException());
      }

      return _envMapper.mapFrom(value);
    });
  }

  @override
  Future<void> setEnv({required EnvEntity env}) {
    return _storageKeyValueDataSource.store(
        key: "env", value: _envMapper.mapTo(env));
  }
}
