import 'package:polygonid_flutter_sdk/common/data/data_sources/env_datasource.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final EnvDataSource _envDataSource;

  ConfigRepositoryImpl(this._envDataSource);

  @override
  Future<String> getConfig({required PolygonIdConfig config}) {
    return Future.value(_envDataSource.getConfig(config: config));
  }
}
