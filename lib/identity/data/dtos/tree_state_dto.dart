import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_state_dto.g.dart';

/// Represents a tree state DTO.
@JsonSerializable()
class TreeStateDTO extends Equatable {
  final String state;
  final String rootOfRoots;
  final String claimsTreeRoot;
  final String revocationTreeRoot;

  const TreeStateDTO({
    required this.state,
    required this.rootOfRoots,
    required this.claimsTreeRoot,
    required this.revocationTreeRoot,
  });

  factory TreeStateDTO.fromJson(Map<String, dynamic> json) =>
      _$TreeStateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TreeStateDTOToJson(this);

  @override
  List<Object?> get props =>
      [state, rootOfRoots, claimsTreeRoot, revocationTreeRoot, rootOfRoots];
}
