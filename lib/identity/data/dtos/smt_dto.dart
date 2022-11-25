/*import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hash_dto.dart';

part 'smt_dto.g.dart';

/// Represents a smt DTO.
@JsonSerializable()
class MerkleTreeDTO extends Equatable {
  final HashDTO root;
  final bool writable;
  final int maxLevels;

  const MerkleTreeDTO(
      {required this.root, required this.writable, required this.maxLevels});

  factory MerkleTreeDTO.fromJson(Map<String, dynamic> json) =>
      _$MerkleTreeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MerkleTreeDTOToJson(this);

  @override
  List<Object?> get props => [root, writable, maxLevels];
}*/
