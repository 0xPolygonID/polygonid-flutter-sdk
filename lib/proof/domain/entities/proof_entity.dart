import 'node_aux_entity.dart';

class ProofEntity {
  final bool existence;
  final List<String> siblings;
  final NodeAuxEntity? node_aux;

  ProofEntity({required this.existence, required this.siblings, this.node_aux});

  @override
  String toString() =>
      "[ProofEntity] {existence: $existence, siblings: $siblings, node_aux: $node_aux}";

  @override
  Map<String, dynamic> toJson() => {
        'existence': existence,
        'siblings': siblings,
        'node_aux': node_aux?.toJson(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofEntity &&
          runtimeType == other.runtimeType &&
          existence.toString() == other.existence.toString() &&
          siblings.toString() == other.siblings.toString() &&
          node_aux.toString() == other.node_aux.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
