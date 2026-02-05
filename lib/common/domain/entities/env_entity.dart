import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';

class EnvEntity {
  final String pushUrl;
  final String ipfsUrl;
  final String ipfsGatewayUrl;
  final String? didResolverUrl;

  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;

  final String? stacktraceEncryptionKey;

  final String? cacheDir;
  final String? method;

  EnvEntity._({
    required this.pushUrl,
    required this.ipfsUrl,
    required this.ipfsGatewayUrl,
    this.didResolverUrl,
    this.chainConfigs = const {},
    this.didMethods = const [],
    this.stacktraceEncryptionKey,
    this.cacheDir,
    this.method,
  });

  EnvEntity({
    required this.pushUrl,
    required this.ipfsUrl,
    required this.ipfsGatewayUrl,
    this.didResolverUrl,
    required this.chainConfigs,
    required this.didMethods,
    this.stacktraceEncryptionKey,
    this.cacheDir,
    this.method,
  });

  factory EnvEntity.fromJson(Map<String, dynamic> json) {
    return EnvEntity(
      pushUrl: json['pushUrl'],
      ipfsUrl: json['ipfsUrl'],
      ipfsGatewayUrl: json['ipfsGatewayUrl'],
      didResolverUrl: json['didResolverUrl'],
      chainConfigs: (json['chainConfigs'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, ChainConfigEntity.fromJson(value)),
      ),
      didMethods: (json['didMethods'] as List<dynamic>)
          .map((e) => DidMethodEntity.fromJson(e))
          .toList(),
      stacktraceEncryptionKey: json['stacktraceEncryptionKey'],
      cacheDir: json['cacheDir'],
      method: json['method'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'pushUrl': pushUrl,
    'ipfsUrl': ipfsUrl,
    'didResolverUrl': didResolverUrl,
    'chainConfigs': chainConfigs.map(
      (key, value) => MapEntry(key, value.toJson()),
    ),
    'didMethods': didMethods.map((e) => e.toJson()).toList(),
    'stacktraceEncryptionKey': stacktraceEncryptionKey,
    'cacheDir': cacheDir,
    'method': method,
  };

  @override
  String toString() {
    return 'EnvEntity{pushUrl: $pushUrl, ipfsUrl: $ipfsUrl, chainConfig: $chainConfigs, didMethods: $didMethods, stacktraceEncryptionKey: $stacktraceEncryptionKey, cacheDir: $cacheDir}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          pushUrl == other.pushUrl &&
          ipfsUrl == other.ipfsUrl &&
          didResolverUrl == other.didResolverUrl &&
          mapEquals(chainConfigs, other.chainConfigs) &&
          listEquals(didMethods, other.didMethods) &&
          stacktraceEncryptionKey == other.stacktraceEncryptionKey &&
          cacheDir == other.cacheDir;

  @override
  int get hashCode => runtimeType.hashCode;

  EnvEntity copyWith({
    String? blockchain,
    String? network,
    String? rpcUrl,
    String? idStateContract,
    String? pushUrl,
    String? ipfsUrl,
    String? ipfsGatewayUrl,
    String? didResolverUrl,
    Map<String, ChainConfigEntity>? chainConfigs,
    List<DidMethodEntity>? didMethods,
    String? stacktraceEncryptionKey,
    String? cacheDir,
    String? method,
  }) {
    return EnvEntity._(
      pushUrl: pushUrl ?? this.pushUrl,
      ipfsUrl: ipfsUrl ?? this.ipfsUrl,
      ipfsGatewayUrl: ipfsGatewayUrl ?? this.ipfsGatewayUrl,
      didResolverUrl: didResolverUrl ?? this.didResolverUrl,
      chainConfigs: chainConfigs ?? this.chainConfigs,
      didMethods: didMethods ?? this.didMethods,
      stacktraceEncryptionKey:
          stacktraceEncryptionKey ?? this.stacktraceEncryptionKey,
      cacheDir: cacheDir ?? this.cacheDir,
      method: method ?? this.method,
    );
  }

  EnvConfigEntity get config {
    return EnvConfigEntity(
      ipfsNodeUrl: ipfsUrl,
      ipfsGatewayUrl: ipfsGatewayUrl,
      chainConfigs: chainConfigs,
      didMethods: didMethods,
      cacheDir: cacheDir,
      didResolverUrl: didResolverUrl,
    );
  }
}
