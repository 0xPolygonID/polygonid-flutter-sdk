import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_bjj_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimProofBJJDTO extends ClaimProofDTO {
  final String signature;

  const ClaimProofBJJDTO(
    super.type,
    super.issuer,
    super.coreClaim,
    this.signature,
  );

  factory ClaimProofBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofBJJDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerBJJDTO extends ClaimProofIssuerDTO {
  final String authCoreClaim;
  final ClaimProofMTPDTO mtp;
  final ClaimProofIssuerCredStatusDTO credentialStatus;

  ClaimProofIssuerBJJDTO(super.id, super.state, this.authCoreClaim, this.mtp,
      this.credentialStatus);

  factory ClaimProofIssuerBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerBJJDTOToJson(this);
}
