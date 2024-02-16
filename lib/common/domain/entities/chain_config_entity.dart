class ChainConfigEntity {
  final String blockchain;
  final String network;

  final String rpcUrl;
  final String stateContractAddr;

  ChainConfigEntity({
    required this.blockchain,
    required this.network,
    required this.rpcUrl,
    required this.stateContractAddr,
  });

  factory ChainConfigEntity.fromJson(Map<String, dynamic> json) {
    return ChainConfigEntity(
      blockchain: json['blockchain'],
      network: json['network'],
      rpcUrl: json['rpcUrl'],
      stateContractAddr: json['stateContractAddr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'blockchain': blockchain,
        'network': network,
        'rpcUrl': rpcUrl,
        'stateContractAddr': stateContractAddr,
      };

  @override
  String toString() {
    return 'ChainConfigEntity{blockchain: $blockchain, network: $network, rpcUrl: $rpcUrl, stateContractAddr: $stateContractAddr}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainConfigEntity &&
        other.blockchain == blockchain &&
        other.network == network &&
        other.rpcUrl == rpcUrl &&
        other.stateContractAddr == stateContractAddr;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
