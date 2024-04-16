import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';

class EnvEntity {
  final String pushUrl;
  final String ipfsUrl;

  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;

  final String? stacktraceEncryptionKey;
  final String? pinataGateway;
  final String? pinataGatewayToken;

  EnvEntity._({
    required this.pushUrl,
    required this.ipfsUrl,
    this.chainConfigs = const {},
    this.didMethods = const [],
    this.stacktraceEncryptionKey,
    this.pinataGateway,
    this.pinataGatewayToken,
  });

  EnvEntity({
    required this.pushUrl,
    required this.ipfsUrl,
    required this.chainConfigs,
    required this.didMethods,
    this.stacktraceEncryptionKey,
    this.pinataGateway,
    this.pinataGatewayToken,
  });

  factory EnvEntity.fromJson(Map<String, dynamic> json) {
    return EnvEntity(
      pushUrl: json['pushUrl'],
      ipfsUrl: json['ipfsUrl'],
      chainConfigs: (json['chainConfigs'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          ChainConfigEntity.fromJson(value),
        ),
      ),
      didMethods: (json['didMethods'] as List<dynamic>)
          .map((e) => DidMethodEntity.fromJson(e))
          .toList(),
      stacktraceEncryptionKey: json['stacktraceEncryptionKey'],
      pinataGateway: json['pinataGateway'],
      pinataGatewayToken: json['pinataGatewayToken'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'pushUrl': pushUrl,
        'ipfsUrl': ipfsUrl,
        'chainConfigs': chainConfigs.map(
          (key, value) => MapEntry(
            key,
            value.toJson(),
          ),
        ),
        'didMethods': didMethods.map((e) => e.toJson()).toList(),
        'stacktraceEncryptionKey': stacktraceEncryptionKey,
        'pinataGateway': pinataGateway,
        'pinataGatewayToken': pinataGatewayToken,
      };

  @override
  String toString() {
    return 'EnvEntity{pushUrl: $pushUrl, ipfsUrl: $ipfsUrl, chainConfig: $chainConfigs, didMethods: $didMethods, stacktraceEncryptionKey: $stacktraceEncryptionKey, , pinataGateway: $pinataGateway, pinataGatewayToken: $pinataGatewayToken}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          pushUrl == other.pushUrl &&
          ipfsUrl == other.ipfsUrl &&
          mapEquals(chainConfigs, other.chainConfigs) &&
          listEquals(didMethods, other.didMethods) &&
          stacktraceEncryptionKey == other.stacktraceEncryptionKey &&
          pinataGateway == other.pinataGateway &&
          pinataGatewayToken == other.pinataGatewayToken;

  @override
  int get hashCode => runtimeType.hashCode;

  EnvEntity copyWith({
    String? blockchain,
    String? network,
    String? rpcUrl,
    String? idStateContract,
    String? pushUrl,
    String? ipfsUrl,
    Map<String, ChainConfigEntity>? chainConfigs,
    List<DidMethodEntity>? didMethods,
    String? stacktraceEncryptionKey,
    String? pinataGateway,
    String? pinataGatewayToken,
  }) {
    return EnvEntity._(
      pushUrl: pushUrl ?? this.pushUrl,
      ipfsUrl: ipfsUrl ?? this.ipfsUrl,
      chainConfigs: chainConfigs ?? this.chainConfigs,
      didMethods: didMethods ?? this.didMethods,
      stacktraceEncryptionKey:
          stacktraceEncryptionKey ?? this.stacktraceEncryptionKey,
      pinataGateway: pinataGateway ?? this.pinataGateway,
      pinataGatewayToken: pinataGatewayToken ?? this.pinataGatewayToken,
    );
  }
}

extension EnvEntityExtension on EnvEntity {
  EnvConfigEntity get config {
    return EnvConfigEntity(
      ipfsNodeUrl: ipfsUrl,
      chainConfigs: chainConfigs,
      didMethods: didMethods,
    );
  }
}
