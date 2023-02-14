class DidEntity {
  final String did;
  final String identifier;
  final String blockchain;
  final String network;

  DidEntity({
    required this.did,
    required this.identifier,
    required this.blockchain,
    required this.network,
  });

  @override
  String toString() =>
      "[DidEntity] {did: $did, identifier: $identifier, blockchain: $blockchain, network: $network}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DidEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          identifier == other.identifier &&
          blockchain == other.blockchain &&
          network == other.network;

  @override
  int get hashCode => runtimeType.hashCode;
}
