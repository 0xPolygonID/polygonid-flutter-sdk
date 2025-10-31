import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';

/// https://github.com/0xPolygonID/c-polygonid?tab=readme-ov-file#configuration
class EnvConfigEntity {
  final String ipfsNodeUrl;
  final String ipfsGatewayUrl;
  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;
  final String? cacheDir;
  final String? didResolverUrl;

  EnvConfigEntity({
    required this.ipfsNodeUrl,
    required this.ipfsGatewayUrl,
    this.chainConfigs = const {},
    this.didMethods = const [],
    this.cacheDir,
    this.didResolverUrl,
  });

  factory EnvConfigEntity.fromJson(Map<String, dynamic> json) {
    return EnvConfigEntity(
      ipfsNodeUrl: json['ipfsNodeUrl'],
      ipfsGatewayUrl: json['ipfsGatewayUrl'],
      chainConfigs: (json['chainConfigs'] as Map<dynamic, dynamic>).map(
          (key, value) => MapEntry(key, ChainConfigEntity.fromJson(value))),
      didMethods: (json['didMethods'] as List<dynamic>)
          .map((value) => DidMethodEntity.fromJson(value))
          .toList(),
      cacheDir: json['cacheDir'],
      didResolverUrl: json['didResolverUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ipfsNodeUrl': ipfsNodeUrl,
      'ipfsGatewayUrl': ipfsGatewayUrl,
      'chainConfigs':
          chainConfigs.map((key, value) => MapEntry(key, value.toJson())),
      'didMethods': didMethods.map((e) => e.toJson()).toList(),
      'cacheDir': cacheDir,
      'didResolverUrl': didResolverUrl,
    };
  }
}
