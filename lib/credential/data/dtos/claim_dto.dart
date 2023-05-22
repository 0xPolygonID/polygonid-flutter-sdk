import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'claim_info_dto.dart';

part 'claim_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimDTO extends Equatable {
  final String id;
  final String issuer;
  final String did;
  final String state;
  @JsonKey(name: "credential")
  final ClaimInfoDTO info;
  final String? expiration;
  final String type;
  Map<String, dynamic>? schema;

  ClaimDTO(
      {required this.id,
      required this.issuer,
      required this.did,
      required this.type,
      this.state = '',
      this.expiration,
      required this.info,
      this.schema});

  factory ClaimDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimDTOToJson(this);

  @override
  List<Object?> get props => [issuer, did, state, info];
}
