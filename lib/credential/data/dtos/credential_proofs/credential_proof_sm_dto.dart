import 'package:json_annotation/json_annotation.dart';

import 'credential_proof_dto.dart';

part 'credential_proof_sm_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialProofSMDTO extends CredentialProofDTO {
  final CredentialProofMTPDTO mtp;

  CredentialProofSMDTO(
      CredentialProofType type, CredentialProofIssuerSMDTO issuer, this.mtp)
      : super(type, issuer);

  factory CredentialProofSMDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CredentialProofSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialProofIssuerSMDTO extends CredentialProofIssuerDTO {
  CredentialProofIssuerSMDTO(String id, CredentialProofIssuerStateSMDTO state)
      : super(id, state);

  factory CredentialProofIssuerSMDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofIssuerSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CredentialProofIssuerSMDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialProofIssuerStateSMDTO extends CredentialProofIssuerStateDTO {
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

  CredentialProofIssuerStateSMDTO(String treeRoot, String value, this.number,
      this.timestamp, this.revocationTree, this.root, this.tx)
      : super(treeRoot, value);

  factory CredentialProofIssuerStateSMDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofIssuerStateSMDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$CredentialProofIssuerStateSMDTOToJson(this);
}
