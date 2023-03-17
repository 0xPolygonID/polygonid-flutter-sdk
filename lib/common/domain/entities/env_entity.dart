class EnvEntity {
  final String blockchain;
  final String network;
  final String web3Url;
  final String web3RdpUrl;
  final String rhsUrl;
  final String web3ApiKey;
  final String idStateContract;
  final String pushUrl;

  EnvEntity({
    required this.blockchain,
    required this.network,
    required this.web3Url,
    required this.web3RdpUrl,
    required this.rhsUrl,
    required this.web3ApiKey,
    required this.idStateContract,
    required this.pushUrl,
  });

  @override
  String toString() =>
      "[EnvEntity] {blockchain: $blockchain, network: $network, web3Url: $web3Url, web3RdpUrl: $web3RdpUrl, rhsUrl: $rhsUrl, web3ApiKey: $web3ApiKey, idStateContract: $idStateContract, pushUrl: $pushUrl}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          blockchain == other.blockchain &&
          network == other.network &&
          web3Url == other.web3Url &&
          web3RdpUrl == other.web3RdpUrl &&
          rhsUrl == other.rhsUrl &&
          web3ApiKey == other.web3ApiKey &&
          idStateContract == other.idStateContract &&
          pushUrl == other.pushUrl;

  @override
  int get hashCode => runtimeType.hashCode;
}
