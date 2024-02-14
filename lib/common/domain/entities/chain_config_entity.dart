class ChainConfigEntity {
  final String name;
  final String blockchain;
  final String network;

  final String rpcUrl;
  final String stateContractAddr;

  ChainConfigEntity({
    required this.name,
    required this.blockchain,
    required this.network,
    required this.rpcUrl,
    required this.stateContractAddr,
  });

  factory ChainConfigEntity.fromJson(Map<String, dynamic> json) {
    return ChainConfigEntity(
      name: json['name'],
      blockchain: json['blockchain'],
      network: json['network'],
      rpcUrl: json['rpcUrl'],
      stateContractAddr: json['stateContractAddr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'blockchain': blockchain,
        'network': network,
        'rpcUrl': rpcUrl,
        'stateContractAddr': stateContractAddr,
      };

  @override
  String toString() {
    return 'ChainConfigEntity{name: $name, blockchain: $blockchain, network: $network, rpcUrl: $rpcUrl, stateContractAddr: $stateContractAddr}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainConfigEntity &&
        other.name == name &&
        other.blockchain == blockchain &&
        other.network == network &&
        other.rpcUrl == rpcUrl &&
        other.stateContractAddr == stateContractAddr;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
