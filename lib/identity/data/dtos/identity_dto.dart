import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'identity_dto.g.dart';

/// Represents an identity DTO.
@JsonSerializable()
class IdentityDTO extends Equatable {
  final String identifier;
  final List<String> publicKey;
  // TODO: add List<String> profiles?

  const IdentityDTO({required this.identifier, required this.publicKey});

  factory IdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$IdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityDTOToJson(this);

  @override
  List<Object?> get props => [identifier, publicKey];
}
