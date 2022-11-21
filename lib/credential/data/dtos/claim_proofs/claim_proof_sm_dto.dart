import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_dto.dart';

part 'claim_proof_sm_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClaimProofSMDTO extends ClaimProofDTO {
  final ClaimProofMTPDTO mtp;

  ClaimProofSMDTO(ClaimProofType type, ClaimProofIssuerSMDTO issuer, this.mtp)
      : super(type, issuer);

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
  @JsonKey(name: 'block_number')
  final int number;
  @JsonKey(name: 'block_timestamp')
  final int timestamp;
  @JsonKey(name: 'revocation_tree_root')
  final String revocationTree;
  @JsonKey(name: 'root_of_roots')
  final String root;
  @JsonKey(name: 'tx_id')
  final String tx;

  ClaimProofIssuerStateSMDTO(String treeRoot, String value, this.number,
      this.timestamp, this.revocationTree, this.root, this.tx)
      : super(treeRoot, value);

  factory ClaimProofIssuerStateSMDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerStateSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimProofIssuerStateSMDTOToJson(this);
}
