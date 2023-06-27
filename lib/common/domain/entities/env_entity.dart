class EnvEntity {
  final String blockchain;
  final String network;
  final String web3Url;
  final String web3RdpUrl;
  final String web3ApiKey;
  final String idStateContract;
  final String pushUrl;
  final String ipfsUrl;

  EnvEntity({
    required this.blockchain,
    required this.network,
    required this.web3Url,
    required this.web3RdpUrl,
    required this.web3ApiKey,
    required this.idStateContract,
    required this.pushUrl,
    required this.ipfsUrl,
  });

  factory EnvEntity.fromJson(Map<String, dynamic> json) {
    return EnvEntity(
      blockchain: json['blockchain'],
      network: json['network'],
      web3Url: json['web3Url'],
      web3RdpUrl: json['web3RdpUrl'],
      web3ApiKey: json['web3ApiKey'],
      idStateContract: json['idStateContract'],
      pushUrl: json['pushUrl'],
      ipfsUrl: json['ipfsUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'blockchain': blockchain,
        'network': network,
        'web3Url': web3Url,
        'web3RdpUrl': web3RdpUrl,
        'web3ApiKey': web3ApiKey,
        'idStateContract': idStateContract,
        'pushUrl': pushUrl,
        'ipfsUrl': ipfsUrl,
      };

  @override
  String toString() =>
      "[EnvEntity] {blockchain: $blockchain, network: $network, web3Url: $web3Url, web3RdpUrl: $web3RdpUrl, web3ApiKey: $web3ApiKey, idStateContract: $idStateContract, pushUrl: $pushUrl, ipfsUrl: $ipfsUrl}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvEntity &&
          blockchain == other.blockchain &&
          network == other.network &&
          web3Url == other.web3Url &&
          web3RdpUrl == other.web3RdpUrl &&
          web3ApiKey == other.web3ApiKey &&
          idStateContract == other.idStateContract &&
          pushUrl == other.pushUrl &&
          ipfsUrl == other.ipfsUrl;

  @override
  int get hashCode => runtimeType.hashCode;
}
