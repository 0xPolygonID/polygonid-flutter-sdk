import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genesis_id_input_dto.g.dart';

/// Represents a genesis id input DTO.
@JsonSerializable()
class GenesisIdInputDTO extends Equatable {
  final String claimsTreeRoot;
  final String blockchain;
  final String network;

  const GenesisIdInputDTO(
      {required this.claimsTreeRoot,
      required this.blockchain,
      required this.network});

  factory GenesisIdInputDTO.fromJson(Map<String, dynamic> json) =>
      _$GenesisIdInputDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GenesisIdInputDTOToJson(this);

  @override
  List<Object?> get props => [claimsTreeRoot, blockchain, network];
}
