import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

abstract class ConfigRepository {
  Future<String> getConfig({required PolygonIdConfig config});
}
