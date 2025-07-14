enum ProofType {
  Iden3SparseMerkleProof("Iden3SparseMerkleProof"),
  Iden3SparseMerkleTreeProof("Iden3SparseMerkleTreeProof"),
  BJJSignature2021("BJJSignature2021");

  final String name;

  const ProofType(this.name);

  static ProofType fromString(String value) {
    for (var e in ProofType.values) {
      if (e.name == value) {
        return e;
      }
    }
    return ProofType.Iden3SparseMerkleProof; // Default case
  }
}
