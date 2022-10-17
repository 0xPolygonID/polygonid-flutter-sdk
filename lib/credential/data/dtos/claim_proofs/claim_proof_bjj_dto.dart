import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_bjj_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimProofBJJDTO extends ClaimProofDTO {
  final String signature;

  const ClaimProofBJJDTO(
      ClaimProofType type, ClaimProofIssuerDTO issuer, this.signature)
      : super(type, issuer);

  factory ClaimProofBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofBJJDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerBJJDTO extends ClaimProofIssuerDTO {
  @JsonKey(name: 'auth_claim')
  final List<String> authClaim;
  final ClaimProofMTPDTO mtp;
  @JsonKey(name: 'revocation_status')
  final String revocationStatus;

  ClaimProofIssuerBJJDTO(String id, ClaimProofIssuerStateDTO state,
      this.authClaim, this.mtp, this.revocationStatus)
      : super(id, state);

  factory ClaimProofIssuerBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerBJJDTOToJson(this);
}
