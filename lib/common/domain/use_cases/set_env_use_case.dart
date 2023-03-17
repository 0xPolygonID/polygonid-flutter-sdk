import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class SetEnvUseCase extends FutureUseCase<EnvEntity, void> {
  final ConfigRepository _configRepository;

  SetEnvUseCase(this._configRepository);

  @override
  Future<void> execute({required EnvEntity param}) {
    return _configRepository.setEnv(env: param).then((_) {
      logger().i("[SetEnvUseCase] $param env has been set");
    }).catchError((error) {
      logger().e("[SetEnvUseCase] Error: $error");

      throw error;
    });
  }
}
