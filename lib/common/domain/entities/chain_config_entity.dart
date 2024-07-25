class ChainConfigEntity {
  final String blockchain;
  final String network;

  final String rpcUrl;
  final String stateContractAddr;
  final String? method;

  ChainConfigEntity({
    required this.blockchain,
    required this.network,
    required this.rpcUrl,
    required this.stateContractAddr,
    this.method,
  });

  factory ChainConfigEntity.fromJson(Map<String, dynamic> json) {
    return ChainConfigEntity(
      blockchain: json['blockchain'],
      network: json['network'],
      rpcUrl: json['rpcUrl'],
      stateContractAddr: json['stateContractAddr'],
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() => {
        'blockchain': blockchain,
        'network': network,
        'rpcUrl': rpcUrl,
        'stateContractAddr': stateContractAddr,
        'method': method,
      };

  @override
  String toString() {
    return 'ChainConfigEntity{blockchain: $blockchain, network: $network, rpcUrl: $rpcUrl, stateContractAddr: $stateContractAddr, method: $method}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainConfigEntity &&
        other.blockchain == blockchain &&
        other.network == network &&
        other.rpcUrl == rpcUrl &&
        other.stateContractAddr == stateContractAddr &&
        other.method == method;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
