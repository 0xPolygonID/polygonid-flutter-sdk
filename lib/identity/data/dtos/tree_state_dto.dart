import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_state_dto.g.dart';

/// Represents a tree state DTO.
@JsonSerializable()
class TreeStateDTO extends Equatable {
  final String state;
  final String claimsRoot;
  final String revocationRoot;
  final String rootOfRoots;

  const TreeStateDTO(
      {required this.state,
      required this.claimsRoot,
      required this.revocationRoot,
      required this.rootOfRoots});

  factory TreeStateDTO.fromJson(Map<String, dynamic> json) =>
      _$TreeStateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TreeStateDTOToJson(this);

  @override
  List<Object?> get props => [state, claimsRoot, revocationRoot, rootOfRoots];
}
