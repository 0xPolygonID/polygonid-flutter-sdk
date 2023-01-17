import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hash_dto.dart';

part 'identity_claim_dto.g.dart';

@JsonSerializable()
class IdentityClaimDTO extends Equatable {
  final HashDTO hashIndex;
  final HashDTO hashValue;
  final List<HashDTO> children; // big ints

  const IdentityClaimDTO(
      {required this.children,
      required this.hashIndex,
      required this.hashValue});

  factory IdentityClaimDTO.fromJson(Map<String, dynamic> json) =>
      _$IdentityClaimDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityClaimDTOToJson(this);

  @override
  List<Object?> get props => [hashIndex, hashValue, children];
}
