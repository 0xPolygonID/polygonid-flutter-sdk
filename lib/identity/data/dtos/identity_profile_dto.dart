import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity_profile_dto.g.dart';

@JsonSerializable()
class IdentityProfileDTO extends Equatable {
  final String did;
  final String nonce;

  const IdentityProfileDTO({required this.did, required this.nonce});

  factory IdentityProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$IdentityProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityProfileDTOToJson(this);

  @override
  List<Object?> get props => [did, nonce];
}
