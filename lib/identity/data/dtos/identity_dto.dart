import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity_dto.g.dart';

/// Represents an identity DTO.
@JsonSerializable()
class IdentityDTO extends Equatable {
  final String did;
  final List<String> publicKey;
  final Map<int, String> profiles;

  const IdentityDTO(
      {required this.did, required this.publicKey, required this.profiles});

  factory IdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$IdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityDTOToJson(this);

  @override
  List<Object?> get props => [did, publicKey, profiles];
}
