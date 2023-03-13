import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

class EnvNotSetException implements Exception {}

class ConfigNotSetException implements Exception {
  final PolygonIdConfig config;

  ConfigNotSetException(this.config);
}
