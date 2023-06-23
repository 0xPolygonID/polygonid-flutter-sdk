import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../identity/data/dtos/hash_dto.dart';
import 'node_aux_dto.dart';

part 'mtproof_dto.g.dart';

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
/// Represents a merkle tree proof DTO.
@JsonSerializable(explicitToJson: true)
class MTProofDTO extends Equatable {
  final bool existence;
  final List<HashDTO> siblings;
  @JsonKey(name: 'node_aux')
  final NodeAuxDTO? nodeAux;

  const MTProofDTO(
      {required this.existence, required this.siblings, this.nodeAux});

  factory MTProofDTO.fromJson(Map<String, dynamic> json) =>
      _$MTProofDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MTProofDTOToJson(this);

  @override
  List<Object?> get props => [existence, siblings, nodeAux];
}
