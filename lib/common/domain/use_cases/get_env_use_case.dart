import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class GetEnvUseCase extends FutureUseCase<void, EnvEntity> {
  final ConfigRepository _configRepository;

  GetEnvUseCase(this._configRepository);

  @override
  Future<EnvEntity> execute({dynamic param}) {
    return _configRepository.getEnv().then((env) {
      logger().i("[GetEnvUseCase] Current env is: $env");

      return env;
    }).catchError((error) {
      logger().e("[GetEnvUseCase] Error: $error");

      throw error;
    });
  }
}
