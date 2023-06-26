import '../../../identity/domain/entities/hash_entity.dart';
import 'node_aux_entity.dart';

class MTProofEntity {
  final bool existence;
  final List<HashEntity> siblings;
  final NodeAuxEntity? nodeAux;

  MTProofEntity(
      {required this.existence, required this.siblings, this.nodeAux});

  @override
  String toString() =>
      "[MTProofEntity] {existence: $existence, siblings: $siblings, nodeAux: $nodeAux}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MTProofEntity &&
          runtimeType == other.runtimeType &&
          existence.toString() == other.existence.toString() &&
          siblings.toString() == other.siblings.toString() &&
          nodeAux.toString() == other.nodeAux.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
