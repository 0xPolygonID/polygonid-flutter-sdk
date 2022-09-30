import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credential_proof_bjj_dto.dart';
import 'credential_proof_sm_dto.dart';

part 'credential_proof_dto.g.dart';

@JsonEnum()
enum CredentialProofType {
  @JsonValue("BJJSignature2021")
  bjj,
  @JsonValue("Iden3SparseMerkleProof")
  sparseMerkle
}

@JsonSerializable(explicitToJson: true, createFactory: false)
class CredentialProofDTO extends Equatable {
  @JsonKey(name: '@type')
  final CredentialProofType type;
  @JsonKey(name: 'issuer_data')
  final CredentialProofIssuerDTO issuer;

  const CredentialProofDTO(this.type, this.issuer);

  factory CredentialProofDTO.fromJson(Map<String, dynamic> json) {
    CredentialProofType type =
        $enumDecode(_$CredentialProofTypeEnumMap, json['@type']);

    switch (type) {
      case CredentialProofType.bjj:
        return CredentialProofBJJDTO(
          type,
          CredentialProofIssuerBJJDTO.fromJson(
              json['issuer_data'] as Map<String, dynamic>),
          json['signature'] as String,
        );
      case CredentialProofType.sparseMerkle:
        return CredentialProofSMDTO(
          type,
          CredentialProofIssuerSMDTO.fromJson(
              json['issuer_data'] as Map<String, dynamic>),
          CredentialProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
        );
    }
  }

  Map<String, dynamic> toJson() => _$CredentialProofDTOToJson(this);

  @override
  List<Object?> get props =>
      [type]; // , issuer]; For UT but we could compare more thoroughly
}

@JsonSerializable()
class CredentialProofMTPDTO {
  final bool existence;
  final List<String> siblings;

  CredentialProofMTPDTO(this.existence, this.siblings);

  factory CredentialProofMTPDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofMTPDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialProofMTPDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialProofIssuerStateDTO {
  @JsonKey(name: 'claims_tree_root')
  final String treeRoot;
  final String value;

  CredentialProofIssuerStateDTO(this.treeRoot, this.value);

  factory CredentialProofIssuerStateDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofIssuerStateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialProofIssuerStateDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialProofIssuerDTO {
  final String id;
  final CredentialProofIssuerStateDTO state;

  CredentialProofIssuerDTO(this.id, this.state);

  factory CredentialProofIssuerDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialProofIssuerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialProofIssuerDTOToJson(this);
}
