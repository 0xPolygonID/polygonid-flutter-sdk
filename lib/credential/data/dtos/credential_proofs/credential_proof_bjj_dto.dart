import 'package:json_annotation/json_annotation.dart';

import 'credential_proof_dto.dart';

part 'credential_proof_bjj_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialProofBJJDTO extends CredentialProofDTO {
  final String signature;

  CredentialProofBJJDTO(
      CredentialProofType type, CredentialProofIssuerDTO issuer, this.signature)
      : super(type, issuer);

  factory CredentialProofBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CredentialProofBJJDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialProofIssuerBJJDTO extends CredentialProofIssuerDTO {
  @JsonKey(name: 'auth_claim')
  final List<String> authClaim;
  final CredentialProofMTPDTO mtp;
  @JsonKey(name: 'revocation_status')
  final String revocationStatus;

  CredentialProofIssuerBJJDTO(String id, CredentialProofIssuerStateDTO state,
      this.authClaim, this.mtp, this.revocationStatus)
      : super(id, state);

  factory CredentialProofIssuerBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofIssuerBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CredentialProofIssuerBJJDTOToJson(this);
}
