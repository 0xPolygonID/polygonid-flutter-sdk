import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/env/sdk_env.dart';

class EnvDataSource {
  final SdkEnv _sdkEnv;

  EnvDataSource(this._sdkEnv);

  String? getConfig({required PolygonIdConfig config}) {
    if (config == PolygonIdConfig.pushUrl) {
      return _sdkEnv.pushUrl;
    }

    return null;
  }
}
