import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_sm_dto.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ClaimProofSMDTO extends ClaimProofDTO {
  final ClaimProofMTPDTO mtp;

  ClaimProofSMDTO(
    super.type,
    ClaimProofIssuerSMDTO super.issuer,
    super.coreClaim,
    this.mtp,
  );

  factory ClaimProofSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerSMDTO extends ClaimProofIssuerDTO {
  ClaimProofIssuerSMDTO(super.id, ClaimProofIssuerStateSMDTO super.state);

  factory ClaimProofIssuerSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerStateSMDTO extends ClaimProofIssuerStateDTO {
  @JsonKey(name: 'blockNumber')
  final int? blockNumber;
  @JsonKey(name: 'blockTimestamp')
  final int? blockTimestamp;
  @JsonKey(name: 'txId')
  final String? txId;

  ClaimProofIssuerStateSMDTO(
    super.claimsTreeRoot,
    String super.revocationTreeRoot,
    String super.rootOfRoots,
    super.value,
    this.blockNumber,
    this.blockTimestamp,
    this.txId,
  );

  factory ClaimProofIssuerStateSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerStateSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerStateSMDTOToJson(this);
}
