import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/utils/collection_utils.dart';
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
    final EnvConfigEntity configEntity;
    if (param != null) {
      configEntity = param;
    } else {
      final env = await _getEnvUseCase.execute();
      configEntity = env.config;
    }

    final config = jsonEncode(configEntity.toJson());

    try {
      _credentialRepository.cleanCache(
        config: config,
      );
    } on CoreLibraryException {
      await _tryEraseCache(configEntity);
    }

    return;
  }
}

Future<void> _tryEraseCache(EnvConfigEntity config) async {
  final configCachePath = config.cacheDir;
  final cacheDir = configCachePath == null ? null : Directory(configCachePath);
  final possibleLocations = {
    if (cacheDir != null) cacheDir,
    await getApplicationCacheDirectory(),
    await getApplicationDocumentsDirectory(),
  };

  for (final location in possibleLocations) {
    _tryDeleteCPolygonIDCache(location);
  }
}

const _cacheFolderName = "c-polygonid-cache";

void _tryDeleteCPolygonIDCache(Directory location) {
  if (!location.existsSync()) {
    return;
  }

  final cPolygonIdCacheDir = location
      .listSync()
      .firstWhereOrNull((f) => f.path.contains(_cacheFolderName));
  if (cPolygonIdCacheDir != null && cPolygonIdCacheDir.existsSync()) {
    try {
      cPolygonIdCacheDir.deleteSync(recursive: true);
    } catch (e) {
      // Log the error or handle it as needed
      logger().d("Failed to delete cache directory: ${e.toString()}");
    }
  }
}
