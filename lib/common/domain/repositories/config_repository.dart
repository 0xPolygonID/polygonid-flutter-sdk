import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';

abstract class ConfigRepository {
  Future<EnvEntity> getEnv();

  Future<void> setEnv({required EnvEntity env});

  Future<String?> getSelectedChainId();

  Future<void> setSelectedChainId({required String chainId});
}
