import 'package:polygonid_flutter_sdk/common/data/data_sources/storage_key_value_data_source.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/env_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final StorageKeyValueDataSource _storageKeyValueDataSource;

  ConfigRepositoryImpl(this._storageKeyValueDataSource,);

  @override
  Future<EnvEntity> getEnv() {
    return _storageKeyValueDataSource.get(key: "env").then((value) {
      if (value == null) {
        return Future.error(EnvNotSetException());
      }

      return EnvEntity.fromJsonV1(value);
    });
  }

  @override
  Future<void> setEnv({required EnvEntity env}) {
    return _storageKeyValueDataSource.store(key: "env", value: env.toJson());
  }

  @override
  Future<String?> getSelectedChainId() {
    return _storageKeyValueDataSource.get(key: "selected_chain").then((value) {
      return value;
    });
  }

  @override
  Future<void> setSelectedChainId({required String chainId}) {
    return _storageKeyValueDataSource.store(
        key: "selected_chain", value: chainId);
  }
}
