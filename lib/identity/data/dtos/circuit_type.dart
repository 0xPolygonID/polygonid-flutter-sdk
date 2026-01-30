// Base sealed class for circuit types
sealed class CircuitId {
  const CircuitId();

  String get id;

  @Deprecated('Use id field instead')
  String get name => id;

  String get displayName => id;

  String get category => "";

  // Constants for circuit naming
  static const v3CircuitPrefix = "credentialAtomicQueryV3";
  static const currentCircuitBetaPostfix = "-beta.1";

  // Abstract method that all circuit types must implement
  bool isAnyProofTypeSupported(List<String> proofTypes);

  // Helper method to check if circuit supports on-chain operations
  bool get isOnChain => false;

  // Helper method to check if circuit is custom
  bool get isCustom => false;

  @override
  bool operator ==(Object other) {
    return other is CircuitId && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CircuitType(id: $id)';
}

// Predefined circuit types
class AuthV2Circuit extends CircuitId {
  const AuthV2Circuit();

  @override
  String get id => "authV2";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) => false;
}

class AuthV3Circuit extends CircuitId {
  const AuthV3Circuit();

  @override
  String get id => "authV3";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) => false;
}

class AuthV3_8_32_Circuit extends CircuitId {
  const AuthV3_8_32_Circuit();

  @override
  String get id => "authV3-8-32";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) => false;
}

class MtpCircuit extends CircuitId {
  const MtpCircuit();

  @override
  String get id => "credentialAtomicQueryMTPV2";

  @override
  String get displayName => "Credential Atomic Query MTP V2";

  @override
  String get category => "MTP Query";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return [
      ProofType.Iden3SparseMerkleProof.name,
      ProofType.Iden3SparseMerkleTreeProof.name,
    ].any((element) => proofTypes.contains(element));
  }
}

class SigCircuit extends CircuitId {
  const SigCircuit();

  @override
  String get id => "credentialAtomicQuerySigV2";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return proofTypes.contains(ProofType.BJJSignature2021.name);
  }
}

class MtpOnChainCircuit extends CircuitId {
  const MtpOnChainCircuit();

  @override
  String get id => "credentialAtomicQueryMTPV2OnChain";

  @override
  bool get isOnChain => true;

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return [
      ProofType.Iden3SparseMerkleProof.name,
      ProofType.Iden3SparseMerkleTreeProof.name,
    ].any((element) => proofTypes.contains(element));
  }
}

class SigOnChainCircuit extends CircuitId {
  const SigOnChainCircuit();

  @override
  String get id => "credentialAtomicQuerySigV2OnChain";

  @override
  bool get isOnChain => true;

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return proofTypes.contains(ProofType.BJJSignature2021.name);
  }
}

class CircuitsV3Circuit extends CircuitId {
  const CircuitsV3Circuit();

  @override
  String get id =>
      "credentialAtomicQueryV3${CircuitId.currentCircuitBetaPostfix}";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return [
      ProofType.Iden3SparseMerkleProof.name,
      ProofType.Iden3SparseMerkleTreeProof.name,
      ProofType.BJJSignature2021.name,
    ].any((element) => proofTypes.contains(element));
  }
}

class CircuitsV3OnChainCircuit extends CircuitId {
  const CircuitsV3OnChainCircuit();

  @override
  String get id =>
      "credentialAtomicQueryV3OnChain${CircuitId.currentCircuitBetaPostfix}";

  @override
  bool get isOnChain => true;

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return [
      ProofType.Iden3SparseMerkleProof.name,
      ProofType.Iden3SparseMerkleTreeProof.name,
      ProofType.BJJSignature2021.name,
    ].any((element) => proofTypes.contains(element));
  }
}

class LinkedMultiQueryCircuit extends CircuitId {
  const LinkedMultiQueryCircuit();

  @override
  String get id => "linkedMultiQuery10${CircuitId.currentCircuitBetaPostfix}";

  @override
  String get displayName => "Linked Multi Query 10 (Beta)";

  @override
  String get category => "Multi Query";

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    return [
      ProofType.Iden3SparseMerkleProof.name,
      ProofType.Iden3SparseMerkleTreeProof.name,
      ProofType.BJJSignature2021.name,
    ].any((element) => proofTypes.contains(element));
  }
}

// Custom circuit type for user-defined circuits
class CustomCircuit extends CircuitId {
  final String _id;
  final List<ProofType> _supportedProofTypes;
  final bool _isOnchain;

  const CustomCircuit(
    this._id, {
    String? displayName,
    String? category,
    List<ProofType> supportedProofTypes = const [],
    bool supportsOnChain = false,
  }) : _supportedProofTypes = supportedProofTypes,
       _isOnchain = supportsOnChain;

  @override
  String get id => _id;

  @override
  bool get isCustom => true;

  @override
  bool get isOnChain => _isOnchain;

  @override
  bool isAnyProofTypeSupported(List<String> proofTypes) {
    if (_supportedProofTypes.isEmpty) return false;
    return _supportedProofTypes
        .map((pt) => pt.name)
        .any((element) => proofTypes.contains(element));
  }

  List<ProofType> get supportedProofTypes =>
      List.unmodifiable(_supportedProofTypes);
}

// Enhanced ProofType enum
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

  // Helper method to get all proof type names
  static List<String> get allNames =>
      ProofType.values.map((pt) => pt.name).toList();
}

// Utility class for creating and managing circuit types
class CircuitIds {
  // Predefined circuit type instances
  static const auth = AuthV2Circuit();
  static const mtp = MtpCircuit();
  static const sig = SigCircuit();
  static const mtpOnChain = MtpOnChainCircuit();
  static const sigOnChain = SigOnChainCircuit();
  static const circuitsV3 = CircuitsV3Circuit();
  static const circuitsV3OnChain = CircuitsV3OnChainCircuit();
  static const linkedMultiQuery = LinkedMultiQueryCircuit();

  // List of all predefined types
  static const List<CircuitId> predefined = [
    auth,
    mtp,
    sig,
    mtpOnChain,
    sigOnChain,
    circuitsV3,
    circuitsV3OnChain,
    linkedMultiQuery,
  ];

  // Factory method to create circuit type from ID (replaces fromString)
  static CircuitId fromId(String id) {
    for (final type in predefined) {
      if (type.id == id) {
        return type;
      }
    }
    // Return custom circuit if not found in predefined types
    return CustomCircuit(id);
  }

  // Legacy method for backward compatibility
  static CircuitId fromString(String value) => fromId(value);

  // Create custom circuit type with enhanced configuration
  static CustomCircuit custom(
    String id, {
    String? displayName,
    String? category,
    List<ProofType> supportedProofTypes = const [],
    bool supportsOnChain = false,
  }) {
    return CustomCircuit(
      id,
      displayName: displayName,
      category: category,
      supportedProofTypes: supportedProofTypes,
      supportsOnChain: supportsOnChain,
    );
  }
}
