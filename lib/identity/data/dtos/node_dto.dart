import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/hash_entity.dart';

part 'node_dto.g.dart';

enum NodeTypeDTO {
  middle,
  leaf,
  state,
  empty,
  unknown,
}

//"node": {
//"children": [
//"a89423f2621d29b696a24735d9217e5143cecd95c3f793bcff04a24e6bc5100d", // Claims tree root
//"0000000000000000000000000000000000000000000000000000000000000000", // Revocation tree root
//"a5cc9f57a671f2aa19c9f15caca63b5435478e65852a7bbe6c1008f8fccd890b"  // Roots tree root
//],
//"hash": "c2cf7856100eaa0e5da6c167ecef46ed909d686901bb6807e0db13097c04f811" // Identity state
//}

/// 3 types of nodes:
///
/// - State node: [Claims Tree root, Revocation Tree root, Roots Tree root]
/// - Middle node: [leftNode, rightNode]
/// - Leaf node: [key, value, 1]

/// Represents a node DTO.
@JsonSerializable(explicitToJson: true)
class NodeDTO extends Equatable {
  final HashEntity hash;
  final List<HashEntity> children;
  final NodeTypeDTO type;

  const NodeDTO(
      {required this.children, required this.hash, required this.type});

  factory NodeDTO.fromJson(Map<String, dynamic> json) =>
      _$NodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NodeDTOToJson(this);

  @override
  List<Object?> get props => [hash, children, type];
}
