import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';

part 'gist_mtproof_entity.g.dart';

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
class GistMTProofEntity extends Equatable {
  @JsonKey(name: 'root')
  final String root;
  @JsonKey(name: 'proof')
  final MTProofEntity proof;

  const GistMTProofEntity({required this.root, required this.proof});

  factory GistMTProofEntity.fromJson(Map<String, dynamic> json) =>
      _$GistMTProofEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GistMTProofEntityToJson(this);

  @override
  List<Object?> get props => [root, proof];
}
