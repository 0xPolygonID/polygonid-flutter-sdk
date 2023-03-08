import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_bjj_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimProofBJJDTO extends ClaimProofDTO {
  final String signature;

  const ClaimProofBJJDTO(
      String type, ClaimProofIssuerDTO issuer, String coreClaim, this.signature)
      : super(type, issuer, coreClaim);

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

  ClaimProofIssuerBJJDTO(String id, ClaimProofIssuerStateDTO state,
      this.authCoreClaim, this.mtp, this.credentialStatus)
      : super(id, state);

  factory ClaimProofIssuerBJJDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerBJJDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerBJJDTOToJson(this);
}
