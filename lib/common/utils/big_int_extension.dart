extension BigIntQ on BigInt {
  static BigInt Q = BigInt.parse(
      "21888242871839275222246405745257275088548364400416034343698204186575808495617");

  BigInt qNormalize() {
    if (this < Q) {
      return this;
    }

    return this % Q;
  }
}
