import '../../../identity/domain/entities/hash_entity.dart';
import '../../../identity/domain/entities/node_entity.dart';

class ProofEntity {
  final bool existence;
  final List<HashEntity> siblings;
  final NodeEntity? nodeAux;

  ProofEntity({required this.existence, required this.siblings, this.nodeAux});

  @override
  String toString() =>
      "[ProofEntity] {existence: $existence, siblings: $siblings, nodeAux: $nodeAux}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofEntity &&
          runtimeType == other.runtimeType &&
          existence.toString() == other.existence.toString() &&
          siblings.toString() == other.siblings.toString() &&
          nodeAux.toString() == other.nodeAux.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
