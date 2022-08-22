import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity_dto.g.dart';

/// Represents an identity DTO.
@JsonSerializable()
class IdentityDTO extends Equatable {
  final String privateKey;
  final String identifier;
  final String authClaim;

  const IdentityDTO(
      {required this.privateKey,
      required this.identifier,
      required this.authClaim});

  factory IdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$IdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityDTOToJson(this);

  @override
  List<Object?> get props => [privateKey, identifier, authClaim];
}
