import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/env/sdk_env.dart';

class EnvDataSource {
  final SdkEnv _sdkEnv;

  EnvDataSource(this._sdkEnv);

  String getConfig({required PolygonIdConfig config}) {
    switch (config) {
      case PolygonIdConfig.polygonIdAccessMessage:
        return _sdkEnv.polygonIdAccessMessage;
      case PolygonIdConfig.networkName:
        return _sdkEnv.polygonIdAccessMessage;
      case PolygonIdConfig.networkEnv:
        return _sdkEnv.networkEnv;
      case PolygonIdConfig.infuraUrl:
        return _sdkEnv.infuraUrl;
      case PolygonIdConfig.infuraRdpUrl:
        return _sdkEnv.infuraRdpUrl;
      case PolygonIdConfig.infuraApiKey:
        return _sdkEnv.infuraApiKey;
      case PolygonIdConfig.reverseHashServiceUrl:
        return _sdkEnv.reverseHashServiceUrl;
      case PolygonIdConfig.idStateContractAddress:
        return _sdkEnv.idStateContractAddress;
      case PolygonIdConfig.pushUrl:
        return _sdkEnv.pushUrl;
    }
  }
}
