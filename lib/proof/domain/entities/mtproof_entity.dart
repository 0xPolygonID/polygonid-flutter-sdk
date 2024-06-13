import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';

class MTProofEntity {
  final bool existence;
  final List<HashEntity> siblings;
  final NodeAuxEntity? nodeAux;

  MTProofEntity({
    required this.existence,
    required this.siblings,
    this.nodeAux,
  });

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

  Map<String, dynamic> toJson() => {
        'existence': existence,
        'siblings': siblings.map((e) => e.toJson()).toList(),
        'nodeAux': nodeAux?.toJson(),
      };
}
