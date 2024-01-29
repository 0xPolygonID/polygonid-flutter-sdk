enum CircuitType {
  auth("authV2"),
  mtp("credentialAtomicQueryMTPV2"),
  sig("credentialAtomicQuerySigV2"),
  mtponchain("credentialAtomicQueryMTPV2OnChain"),
  sigonchain("credentialAtomicQuerySigV2OnChain"),
  circuitsV3("credentialAtomicQueryV3$currentCircuitBetaPostfix"),
  circuitsV3onchain("credentialAtomicQueryV3OnChain$currentCircuitBetaPostfix"),
  unknown("");

  static const v3CircuitPrefix = "credentialAtomicQueryV3";
  static const currentCircuitBetaPostfix = "-beta.0";

  final String name;

  const CircuitType(this.name);
}
