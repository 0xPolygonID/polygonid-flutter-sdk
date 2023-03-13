import 'package:polygonid_flutter_sdk/common/data/exceptions/env_exceptions.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';

enum PolygonIdConfig {
  blockchain,
  network,
  envUrl,
  envRdpUrl,
  envApiKey,
  idStateContractAddress,
  pushUrl,
}

class GetConfigUseCase extends FutureUseCase<PolygonIdConfig, String> {
  final ConfigRepository _configRepository;
  final GetEnvUseCase _getEnvUseCase;

  GetConfigUseCase(this._configRepository, this._getEnvUseCase);

  @override
  Future<String> execute({required PolygonIdConfig param}) {
    /// Shortcut for backward compatibility, but we should use
    /// [GetEnvUseCase] instead
    switch (param) {
      case PolygonIdConfig.blockchain:
      case PolygonIdConfig.network:
      case PolygonIdConfig.envUrl:
      case PolygonIdConfig.envRdpUrl:
      case PolygonIdConfig.envApiKey:
      case PolygonIdConfig.idStateContractAddress:
        return _getEnvUseCase.execute().then((env) {
          if (param == PolygonIdConfig.blockchain) {
            return env.blockchain;
          }

          if (param == PolygonIdConfig.network) {
            return env.network;
          }

          if (param == PolygonIdConfig.envUrl) {
            return env.url;
          }

          if (param == PolygonIdConfig.envRdpUrl) {
            return env.rdpUrl;
          }

          if (param == PolygonIdConfig.envApiKey) {
            return env.apiKey;
          }

          if (param == PolygonIdConfig.idStateContractAddress) {
            return env.idStateContract;
          }

          return Future.error(ConfigNotSetException(param));
        });
      default:
        return _configRepository.getConfig(config: param);
    }
  }
}
