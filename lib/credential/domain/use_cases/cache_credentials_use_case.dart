import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';

class CacheCredentialsUseCase {
  final CacheCredentialUseCase _cacheCredentialUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final StacktraceManager _stacktraceManager;

  CacheCredentialsUseCase(
    this._cacheCredentialUseCase,
    this._stacktraceManager,
    this._getEnvUseCase,
  );

  Future<void> execute({
    required List<ClaimEntity> credentials,
    ConfigParam? configParam,
  }) async {
    // if we don't have the configParam, we get it from the environment
    if (configParam == null) {
      final env = await _getEnvUseCase.execute();
      configParam = ConfigParam(
        ipfsNodeURL: env.ipfsUrl,
        chainConfigs: env.chainConfigs,
        didMethods: env.didMethods,
      );
    }

    for (var credential in credentials) {
      try {
        await _cacheCredentialUseCase.execute(
          param: CacheCredentialParam(
            credential: credential,
            config: configParam,
          ),
        );
      } catch (e) {
        logger().e(
            "[FetchAndSaveClaimsUseCase] Error while caching credential: $e");
        _stacktraceManager.addTrace(
            "[FetchAndSaveClaimsUseCase] Error while caching credential: $e");
      }
    }
  }
}
