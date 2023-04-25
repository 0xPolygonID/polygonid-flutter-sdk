import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_sm_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimProofSMDTO extends ClaimProofDTO {
  final ClaimProofMTPDTO mtp;

  ClaimProofSMDTO(
      String type, ClaimProofIssuerSMDTO issuer, String coreClaim, this.mtp)
      : super(type, issuer, coreClaim);

  factory ClaimProofSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerSMDTO extends ClaimProofIssuerDTO {
  ClaimProofIssuerSMDTO(String id, ClaimProofIssuerStateSMDTO state)
      : super(id, state);

  factory ClaimProofIssuerSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerStateSMDTO extends ClaimProofIssuerStateDTO {
  @JsonKey(name: 'blockNumber')
  final int blockNumber;
  @JsonKey(name: 'blockTimestamp')
  final int blockTimestamp;
  @JsonKey(name: 'txId')
  final String txId;

  ClaimProofIssuerStateSMDTO(
      String claimsTreeRoot,
      String revocationTreeRoot,
      String rootOfRoots,
      String value,
      this.blockNumber,
      this.blockTimestamp,
      this.txId)
      : super(claimsTreeRoot, revocationTreeRoot, rootOfRoots, value);

  factory ClaimProofIssuerStateSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerStateSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerStateSMDTOToJson(this);
}
