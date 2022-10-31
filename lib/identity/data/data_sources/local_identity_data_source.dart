class LocalIdentityDataSource {
  String getDidIdentifier({
    required String identifier,
    required String networkName,
    required String networkEnv,
  }) {
    String network = networkName;
    String env = "main";
    switch (networkEnv) {
      case "mumbai":
        env = networkEnv;
        break;
      case "mainnet":
      default:
        env = "main";
    }
    return "did:iden3:$network:$env:$identifier";
  }
}
