class AuthInputsParser {
  static UniversalResolverParam toUniversalResolverParam(
    String circuitId,
    List<String> inputs,
  ) {
    final result = <String, dynamic>{};
    switch (circuitId) {
      case "credentialAtomicQueryMTPV2OnChain":
        result["userID"] = BigInt.parse(inputs[1]);
        result["gistRoot"] = BigInt.parse(inputs[5]);
        result["issuerID"] = BigInt.parse(inputs[6]);
        result["issuerState"] = BigInt.parse(inputs[7]);
        result["issuerClaimNonRevState"] = BigInt.parse(inputs[9]);
      case "credentialAtomicQuerySigV2OnChain":
        result["userID"] = BigInt.parse(inputs[1]);
        result["gistRoot"] = BigInt.parse(inputs[6]);
        result["issuerID"] = BigInt.parse(inputs[7]);
        result["issuerState"] = BigInt.parse(inputs[3]);
        result["issuerClaimNonRevState"] = BigInt.parse(inputs[9]);
    }
    if (circuitId.startsWith("credentialAtomicQueryV3OnChain")) {
      result["userID"] = BigInt.parse(inputs[0]);
      result["gistRoot"] = BigInt.parse(inputs[9]);
      result["issuerID"] = BigInt.parse(inputs[10]);
      result["issuerState"] = BigInt.parse(inputs[2]);
      result["issuerClaimNonRevState"] = BigInt.parse(inputs[11]);
    }

    return UniversalResolverParam(
      userID: result["userID"],
      gistRoot: result["gistRoot"],
      issuerID: result["issuerID"],
      issuerState: result["issuerState"],
      issuerClaimNonRevState: result["issuerClaimNonRevState"],
    );
  }
}

class UniversalResolverParam {
  final BigInt userID;
  final BigInt gistRoot;
  final BigInt issuerID;
  final BigInt issuerState;
  final BigInt issuerClaimNonRevState;

  UniversalResolverParam({
    required this.userID,
    required this.gistRoot,
    required this.issuerID,
    required this.issuerState,
    required this.issuerClaimNonRevState,
  });
}
