class DidMethodEntity {
  final String name;
  final String blockchain;
  final String network;
  final String networkFlag;
  final String methodByte;
  final String chainID;

  DidMethodEntity({
    required this.name,
    required this.blockchain,
    required this.network,
    required this.networkFlag,
    required this.methodByte,
    required this.chainID,
  });

  factory DidMethodEntity.fromJson(Map<String, dynamic> json) {
    return DidMethodEntity(
      name: json['name'],
      blockchain: json['blockchain'],
      network: json['network'],
      networkFlag: json['networkFlag'],
      methodByte: json['methodByte'],
      chainID: json['chainID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'blockchain': blockchain,
        'network': network,
        'networkFlag': networkFlag,
        'methodByte': methodByte,
        'chainID': chainID,
      };

  @override
  String toString() {
    return 'DidMethod(name: $name, blockchain: $blockchain, network: $network, networkFlag: $networkFlag, methodByte: $methodByte, chainID: $chainID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DidMethodEntity &&
        other.name == name &&
        other.blockchain == blockchain &&
        other.network == network &&
        other.networkFlag == networkFlag &&
        other.methodByte == methodByte &&
        other.chainID == chainID;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
