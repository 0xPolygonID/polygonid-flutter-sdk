import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';

class EnvEntity {
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String blockchain;
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String network;
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String rpcUrl;
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String idStateContract;

  final String pushUrl;
  final String ipfsUrl;

  final Map<String, ChainConfigEntity> chainConfig;
  final List<DidMethodEntity> didMethods;

  final String? stacktraceEncryptionKey;

  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  EnvEntity({
    required this.blockchain,
    required this.network,
    required String web3Url,
    required String web3ApiKey,
    required this.idStateContract,
    required this.pushUrl,
    required this.ipfsUrl,
    this.stacktraceEncryptionKey,
  })  : rpcUrl = web3Url + web3ApiKey,
        chainConfig = const {},
        didMethods = const [];

  EnvEntity.v1({
    required this.pushUrl,
    required this.ipfsUrl,
    required this.chainConfig,
    required this.didMethods,
    this.stacktraceEncryptionKey,
  })  : blockchain = '',
        network = '',
        rpcUrl = '',
        idStateContract = '';

  factory EnvEntity.fromJson(Map<String, dynamic> json) {
    return EnvEntity(
      blockchain: json['blockchain'],
      network: json['network'],
      web3Url: json['web3Url'],
      web3ApiKey: json['web3ApiKey'],
      idStateContract: json['idStateContract'],
      pushUrl: json['pushUrl'],
      ipfsUrl: json['ipfsUrl'],
      stacktraceEncryptionKey: json['stacktraceEncryptionKey'],
    );
  }

  factory EnvEntity.fromJsonV1(Map<String, dynamic> json) {
    return EnvEntity.v1(
      pushUrl: json['pushUrl'],
      ipfsUrl: json['ipfsUrl'],
      chainConfig: (json['chainConfig'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          ChainConfigEntity.fromJson(value),
        ),
      ),
      didMethods: (json['didMethods'] as List<dynamic>)
          .map((e) => DidMethodEntity.fromJson(e))
          .toList(),
      stacktraceEncryptionKey: json['stacktraceEncryptionKey'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'pushUrl': pushUrl,
        'ipfsUrl': ipfsUrl,
        'chainConfig': chainConfig.map(
          (key, value) => MapEntry(
            key,
            value.toJson(),
          ),
        ),
        'didMethods': didMethods.map((e) => e.toJson()).toList(),
        'stacktraceEncryptionKey': stacktraceEncryptionKey,
      };

  @override
  String toString() {
    return 'EnvEntity{blockchain: $blockchain, network: $network, rpcUrl: $rpcUrl, idStateContract: $idStateContract, pushUrl: $pushUrl, ipfsUrl: $ipfsUrl, chainConfig: $chainConfig, didMethods: $didMethods, stacktraceEncryptionKey: $stacktraceEncryptionKey}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          blockchain == other.blockchain &&
          network == other.network &&
          rpcUrl == other.rpcUrl &&
          idStateContract == other.idStateContract &&
          pushUrl == other.pushUrl &&
          ipfsUrl == other.ipfsUrl &&
          mapEquals(chainConfig, other.chainConfig) &&
          listEquals(didMethods, other.didMethods) &&
          stacktraceEncryptionKey == other.stacktraceEncryptionKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
