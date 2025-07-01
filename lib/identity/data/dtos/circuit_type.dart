import 'package:polygonid_flutter_sdk/identity/data/dtos/proof_type.dart';

enum CircuitType {
  auth("authV2"),
  mtp("credentialAtomicQueryMTPV2"),
  sig("credentialAtomicQuerySigV2"),
  mtponchain("credentialAtomicQueryMTPV2OnChain"),
  sigonchain("credentialAtomicQuerySigV2OnChain"),
  circuitsV3("credentialAtomicQueryV3$currentCircuitBetaPostfix"),
  circuitsV3onchain("credentialAtomicQueryV3OnChain$currentCircuitBetaPostfix"),
  linkedMultyQuery10("linkedMultiQuery10$currentCircuitBetaPostfix"),
  unknown("");

  static const v3CircuitPrefix = "credentialAtomicQueryV3";
  static const currentCircuitBetaPostfix = "-beta.1";

  final String name;

  const CircuitType(this.name);

  static CircuitType fromString(String value) {
    for (var e in CircuitType.values) {
      if (e.name == value) {
        return e;
      }
    }
    return CircuitType.unknown;
  }

  bool isAnyProofTypeSupported(List<String> proofTypes) {
    switch (this) {
      case CircuitType.mtp:
      case CircuitType.mtponchain:
        bool success = [
          ProofType.Iden3SparseMerkleProof.name,
          ProofType.Iden3SparseMerkleTreeProof.name,
        ].any((element) => proofTypes.contains(element));
        return success;
      case CircuitType.sig:
      case CircuitType.sigonchain:
        bool success = proofTypes.contains(ProofType.BJJSignature2021.name);
        return success;
      case CircuitType.circuitsV3:
      case CircuitType.circuitsV3onchain:
      case CircuitType.linkedMultyQuery10:
        bool success = [
          ProofType.Iden3SparseMerkleProof.name,
          ProofType.Iden3SparseMerkleTreeProof.name,
          ProofType.BJJSignature2021.name,
        ].any((element) => proofTypes.contains(element));
        return success;
      case CircuitType.auth:
      case CircuitType.unknown:
        break;
    }
    return false;
  }
}
