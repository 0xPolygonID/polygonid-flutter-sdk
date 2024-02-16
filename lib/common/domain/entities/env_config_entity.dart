import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';

class EnvConfigEntity {
  final String ipfsNodeUrl;
  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;

  EnvConfigEntity({
    required this.ipfsNodeUrl,
    this.chainConfigs = const {},
    this.didMethods = const [],
  });
}
