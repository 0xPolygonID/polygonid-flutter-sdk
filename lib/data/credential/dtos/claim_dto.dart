import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/credential_dto.dart';

part 'claim_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimDTO extends Equatable {
  final String issuer;
  final String identifier;
  @JsonKey(defaultValue: '')
  final String state;
  final CredentialDTO credential;

  String get id => credential.id;

  String? get expiration => credential.expiration;

  String get type => credential.credentialSubject.type;

  const ClaimDTO(
      {required this.issuer,
      required this.identifier,
      this.state = '',
      required this.credential});

  factory ClaimDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimDTOToJson(this);

  @override
  List<Object?> get props => [issuer, identifier, state, credential];
}
