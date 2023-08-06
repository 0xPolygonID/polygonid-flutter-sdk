import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

class GetEnvUseCase extends FutureUseCase<void, EnvEntity> {
  final ConfigRepository _configRepository;
  final StacktraceStreamManager _stacktraceStreamManager;

  GetEnvUseCase(
    this._configRepository,
    this._stacktraceStreamManager,
  );

  @override
  Future<EnvEntity> execute({dynamic param}) {
    return _configRepository.getEnv().then((env) {
      logger().i("[GetEnvUseCase] Current env is: $env");

      return env;
    }).catchError((error) {
      logger().e("[GetEnvUseCase] Error: $error");
      _stacktraceStreamManager.addTrace("[GetEnvUseCase] Error: $error");
      throw error;
    });
  }
}
