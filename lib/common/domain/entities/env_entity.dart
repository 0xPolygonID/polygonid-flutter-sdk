import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';

class EnvEntity {
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String web3Url;
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String web3ApiKey;
  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  final String web3RdpUrl;
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

  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;

  final String? stacktraceEncryptionKey;
  final String? pinataGateway;
  final String? pinataGatewayToken;

  EnvEntity._({
    this.web3Url = '',
    this.web3ApiKey = '',
    this.web3RdpUrl = '',
    this.blockchain = '',
    this.network = '',
    this.idStateContract = '',
    this.rpcUrl = '',
    required this.pushUrl,
    required this.ipfsUrl,
    this.chainConfigs = const {},
    this.didMethods = const [],
    this.stacktraceEncryptionKey,
    this.pinataGateway,
    this.pinataGatewayToken,
  });

  @Deprecated("Use EnvEntity.v1 instead of EnvEntity")
  EnvEntity({
    required this.blockchain,
    required this.network,
    required this.web3Url,
    required this.web3ApiKey,
    this.web3RdpUrl = '',
    required this.idStateContract,
    required this.pushUrl,
    required this.ipfsUrl,
    this.stacktraceEncryptionKey,
    this.pinataGateway,
    this.pinataGatewayToken,
  })  : rpcUrl = web3Url + web3ApiKey,
        chainConfigs = const {},
        didMethods = const [] {}

  EnvEntity.v1({
    required this.pushUrl,
    required this.ipfsUrl,
    required this.chainConfigs,
    required this.didMethods,
    this.stacktraceEncryptionKey,
    this.pinataGateway,
    this.pinataGatewayToken,
    @Deprecated("Use chainConfig") this.blockchain = '',
    @Deprecated("Use chainConfig") this.network = '',
    @Deprecated("Use chainConfig") this.web3Url = '',
    @Deprecated("Use chainConfig") this.web3ApiKey = '',
    @Deprecated("Use chainConfig") this.idStateContract = '',
  })  : rpcUrl = '',
        web3RdpUrl = '';

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
      pinataGateway: json['pinataGateway'],
      pinataGatewayToken: json['pinataGatewayToken'],
    );
  }

  factory EnvEntity.fromJsonV1(Map<String, dynamic> json) {
    return EnvEntity.v1(
      blockchain: json['blockchain'] ?? '',
      network: json['network'] ?? '',
      web3Url: json['web3Url'] ?? '',
      web3ApiKey: json['web3ApiKey'] ?? '',
      idStateContract: json['idStateContract'] ?? '',
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
        // TODO: Remove these fields with new release
        'blockchain': blockchain,
        'network': network,
        'web3Url': web3Url,
        'web3ApiKey': web3ApiKey,
        'idStateContract': idStateContract,

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
    return 'EnvEntity{blockchain: $blockchain, network: $network, rpcUrl: $rpcUrl, idStateContract: $idStateContract, pushUrl: $pushUrl, ipfsUrl: $ipfsUrl, chainConfig: $chainConfigs, didMethods: $didMethods, stacktraceEncryptionKey: $stacktraceEncryptionKey, , pinataGateway: $pinataGateway, pinataGatewayToken: $pinataGatewayToken}';
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
      blockchain: blockchain ?? this.blockchain,
      network: network ?? this.network,
      web3Url: rpcUrl ?? this.rpcUrl,
      web3ApiKey: rpcUrl ?? this.rpcUrl,
      idStateContract: idStateContract ?? this.idStateContract,
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
