import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../identity/data/dtos/hash_dto.dart';
import 'node_aux_dto.dart';

part 'proof_dto.g.dart';

/*
"proof": {
          "existence": false,
          "siblings": [],
          "node_aux": {
            "key":
                "24846663430375341177084327381366271031641225773947711007341346118923321345",
            "value":
                "6317996369756476782464660619835940615734517981889733696047139451453239145426"
          }
    }
*/
/// Represents a proof DTO.
@JsonSerializable(explicitToJson: true)
class ProofDTO extends Equatable {
  final bool existence;
  final List<HashDTO> siblings;
  @JsonKey(name: 'node_aux')
  final NodeAuxDTO? nodeAux;

  const ProofDTO(
      {required this.existence, required this.siblings, this.nodeAux});

  factory ProofDTO.fromJson(Map<String, dynamic> json) =>
      _$ProofDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProofDTOToJson(this);

  @override
  List<Object?> get props => [existence, siblings, nodeAux];
}
