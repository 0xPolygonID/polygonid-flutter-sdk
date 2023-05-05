import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

class GistProofEntity {
  final String root;
  final ProofEntity proof;

  GistProofEntity({required this.root, required this.proof});

  @override
  String toString() => "[GistProofEntity] {root: $root, proof: $proof}";

  @override
  Map<String, dynamic> toJson() => {
        'root': root,
        'proof': proof.toJson(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GistProofEntity &&
          runtimeType == other.runtimeType &&
          root.toString() == other.root.toString() &&
          proof.toString() == other.proof.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
