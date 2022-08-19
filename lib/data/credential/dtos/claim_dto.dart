import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/credential_dto.dart';

part 'claim_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimDTO extends Equatable {
  final String id;
  final String issuer;
  final String identifier;
  @JsonKey(defaultValue: '')
  final String state;
  final CredentialDTO credential;
  final String? expiration;
  final String type;

  const ClaimDTO(
      {required this.id,
      required this.issuer,
      required this.identifier,
      required this.type,
      this.state = '',
      this.expiration,
      required this.credential});

  factory ClaimDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimDTOToJson(this);

  @override
  List<Object?> get props => [issuer, identifier, state, credential];
}
