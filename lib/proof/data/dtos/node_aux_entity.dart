import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_aux_entity.g.dart';

/*
 "node_aux": {
   "key": "24846663430375341177084327381366271031641225773947711007341346118923321345",
   "value": "6317996369756476782464660619835940615734517981889733696047139451453239145426"
 }
*/

/// Represents an node aux DTO.
@JsonSerializable()
class NodeAuxEntity extends Equatable {
  final String key;
  final String value;

  const NodeAuxEntity({
    required this.key,
    required this.value,
  });

  factory NodeAuxEntity.fromJson(Map<String, dynamic> json) =>
      _$NodeAuxEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NodeAuxEntityToJson(this);

  @override
  List<Object?> get props => [key, value];
}
