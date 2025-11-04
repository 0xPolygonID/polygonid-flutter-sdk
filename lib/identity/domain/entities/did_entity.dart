class DidEntity {
  final String did;
  final String identifier;
  final String blockchain;
  final String network;
  final String? method;

  DidEntity({
    required this.did,
    required this.identifier,
    required this.blockchain,
    required this.network,
    this.method,
  });

  factory DidEntity.parse(String did) {
    List<String> splits = did.split(":");

    if (splits.length == 5 && splits[0] == "did") {
      return DidEntity(
        did: did,
        method: splits[1],
        blockchain: splits[2],
        network: splits[3],
        identifier: splits[4],
      );
    } else {
      throw FormatException("Invalid DID string representation");
    }
  }

  @override
  String toString() =>
      "[DidEntity] {did: $did, identifier: $identifier, blockchain: $blockchain, network: $network, method: $method}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DidEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          identifier == other.identifier &&
          blockchain == other.blockchain &&
          network == other.network &&
          method == other.method;

  @override
  int get hashCode => runtimeType.hashCode;

  Map<String, dynamic> toJson() => {
    'did': did,
    'identifier': identifier,
    'blockchain': blockchain,
    'network': network,
    'method': method,
  };

  factory DidEntity.fromJson(Map<String, dynamic> json) => DidEntity(
    did: json['did'],
    identifier: json['identifier'],
    blockchain: json['blockchain'],
    network: json['network'],
    method: json['method'],
  );
}
