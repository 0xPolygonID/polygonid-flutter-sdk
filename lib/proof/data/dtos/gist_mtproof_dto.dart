import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';

part 'gist_mtproof_dto.g.dart';

/*
{
"root": "24846663430375341177084327381366271031641225773947711007341346118923321345",
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
}
*/
/// Represents a gist proof DTO.
@JsonSerializable(explicitToJson: true)
class GistMTProofDTO extends Equatable {
  @JsonKey(name: 'root')
  final String root;
  @JsonKey(name: 'proof')
  final MTProofDTO proof;

  const GistMTProofDTO({required this.root, required this.proof});

  factory GistMTProofDTO.fromJson(Map<String, dynamic> json) =>
      _$GistMTProofDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GistMTProofDTOToJson(this);

  @override
  List<Object?> get props => [root, proof];
}
