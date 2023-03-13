class EnvEntity {
  final String blockchain;
  final String network;
  final String url;
  final String rdpUrl;
  final String rhsUrl;
  final String apiKey;
  final String idStateContract;

  EnvEntity({
    required this.blockchain,
    required this.network,
    required this.url,
    required this.rdpUrl,
    required this.rhsUrl,
    required this.apiKey,
    required this.idStateContract,
  });

  @override
  String toString() =>
      "[EnvEntity] {blockchain: $blockchain, network: $network, url: $url, rdpUrl: $rdpUrl, rhsUrl: $rhsUrl, apiKey: $apiKey, idStateContract: $idStateContract}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          blockchain == other.blockchain &&
          network == other.network &&
          url == other.url &&
          rdpUrl == other.rdpUrl &&
          rhsUrl == other.rhsUrl &&
          apiKey == other.apiKey &&
          idStateContract == other.idStateContract;

  @override
  int get hashCode => runtimeType.hashCode;
}
