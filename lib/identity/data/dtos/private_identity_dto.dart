import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';

part 'private_identity_dto.g.dart';

/// Represents a private identity DTO.
@JsonSerializable()
class PrivateIdentityDTO extends IdentityDTO {
  final String privateKey;
  // TODO: add List<String> profiles?

  const PrivateIdentityDTO({
    required String identifier,
    required List<String> publicKey,
    required this.privateKey,
  }) : super(
          identifier: identifier,
          publicKey: publicKey,
        );

  factory PrivateIdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$PrivateIdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateIdentityDTOToJson(this);

  @override
  List<Object?> get props => [
        identifier,
        publicKey,
        privateKey,
      ];
}
