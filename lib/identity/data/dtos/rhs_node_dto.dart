import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

/* node JSON
{
   "node":{
      "children":[
         "a89423f2621d29b696a24735d9217e5143cecd95c3f793bcff04a24e6bc5100d",
         "0000000000000000000000000000000000000000000000000000000000000000",
         "a5cc9f57a671f2aa19c9f15caca63b5435478e65852a7bbe6c1008f8fccd890b"
      ],
      "hash":"c2cf7856100eaa0e5da6c167ecef46ed909d686901bb6807e0db13097c04f811"
   }
}
*/

part 'rhs_node_dto.g.dart';

/// Represents an Reverse Hash Service Node DTO.
@JsonSerializable(explicitToJson: true)
class RhsNodeDTO extends Equatable {
  final NodeEntity node;
  final String status;

  const RhsNodeDTO({
    required this.node,
    required this.status,
  });

  factory RhsNodeDTO.fromJson(Map<String, dynamic> json) =>
      _$RhsNodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RhsNodeDTOToJson(this);

  @override
  List<Object?> get props => [node, status];
}
