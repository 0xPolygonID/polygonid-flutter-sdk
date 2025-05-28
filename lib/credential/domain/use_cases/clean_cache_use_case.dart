import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class CleanCredentialCacheUseCase
    extends FutureUseCase<EnvConfigEntity?, void> {
  final CredentialRepository _credentialRepository;
  final GetEnvUseCase _getEnvUseCase;

  CleanCredentialCacheUseCase(
    this._credentialRepository,
    this._getEnvUseCase,
  );

  @override
  Future<void> execute({
    required EnvConfigEntity? param,
  }) async {
    String? config;
    if (param != null) {
      config = jsonEncode(param.toJson());
    } else {
      final env = await _getEnvUseCase.execute();
      config = jsonEncode(env.config.toJson());
    }

    return _credentialRepository.cleanCache(
      config: config,
    );
  }
}
