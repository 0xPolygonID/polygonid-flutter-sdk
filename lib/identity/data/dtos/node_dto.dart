import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hash_dto.dart';

part 'node_dto.g.dart';

enum NodeTypeDTO {
  middle,
  leaf,
  empty,
}

//"node": {
//"children": [
//"a89423f2621d29b696a24735d9217e5143cecd95c3f793bcff04a24e6bc5100d", // Claims tree root
//"0000000000000000000000000000000000000000000000000000000000000000", // Revocation tree root
//"a5cc9f57a671f2aa19c9f15caca63b5435478e65852a7bbe6c1008f8fccd890b"  // Roots tree root
//],
//"hash": "c2cf7856100eaa0e5da6c167ecef46ed909d686901bb6807e0db13097c04f811" // Identity state
//}

/// Represents an identity DTO.
@JsonSerializable()
class NodeDTO extends Equatable {
  //final NodeTypeDTO type;
  //final HashDTO childL; // left child of a middle node.
  //final HashDTO childR; // right child of a middle node.

  //final HashDTO hash;
  final List<HashDTO> children;

  NodeTypeDTO get type {
    return NodeTypeDTO.empty;
  }

  const NodeDTO({required this.children});
  //{required this.type, required this.childL, required this.childR});

  /*NodeDTO.leaf(HashDTO k, HashDTO v) : type = NodeTypeDTO.leaf {
    entry = List<HashDTO>.from([k, v]);
  }

  NodeDTO.middle(this.childL, this.childR) : type = NodeTypeDTO.middle;

  NodeDTO.empty() : type = NodeTypeDTO.empty;*/

  factory NodeDTO.fromJson(Map<String, dynamic> json) =>
      _$NodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NodeDTOToJson(this);

  @override
  List<Object?> get props => [type, children];
}
