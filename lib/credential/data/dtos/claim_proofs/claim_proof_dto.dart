import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'claim_proof_bjj_dto.dart';
import 'claim_proof_sm_dto.dart';

part 'claim_proof_dto.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false)
class ClaimProofDTO extends Equatable {
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'issuerData')
  final ClaimProofIssuerDTO issuer;
  final String coreClaim;

  const ClaimProofDTO(this.type, this.issuer, this.coreClaim);

  factory ClaimProofDTO.fromJson(Map<String, dynamic> json) {
    String type = json['type'];

    switch (type) {
      case "BJJSignature2021":
        return ClaimProofBJJDTO(
          type,
          ClaimProofIssuerBJJDTO.fromJson(
              json['issuerData'] as Map<String, dynamic>),
          json['coreClaim'] as String,
          json['signature'] as String,
        );
      case "Iden3SparseMerkleProof":
      case "Iden3SparseMerkleTreeProof":
        return ClaimProofSMDTO(
          type,
          ClaimProofIssuerSMDTO.fromJson(
              json['issuerData'] as Map<String, dynamic>),
          json['coreClaim'] as String,
          ClaimProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
        );
      default:
        return ClaimProofDTO(
          type,
          ClaimProofIssuerSMDTO.fromJson(
              json['issuerData'] as Map<String, dynamic>),
          json['coreClaim'] as String,
        );
    }
  }

  Map<String, dynamic> toJson() => _$ClaimProofDTOToJson(this)
    ..removeWhere((dynamic key, dynamic value) => key == null || value == null);

  @override
  List<Object?> get props => [
        type,
      ]; // , issuer]; For UT but we could compare more thoroughly
}

@JsonSerializable()
class ClaimProofMTPDTO {
  final bool existence;
  final List<String> siblings;

  ClaimProofMTPDTO(this.existence, this.siblings);

  factory ClaimProofMTPDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofMTPDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimProofMTPDTOToJson(this);
}

@JsonEnum()
enum ClaimProofIssuerCredStatusType {
  @JsonValue("Iden3ReverseSparseMerkleTreeProof")
  reverseSparseMerkleTreeProof,
  @JsonValue("SparseMerkleTreeProof")
  sparseMerkleTreeProof,
  @JsonValue("Iden3OnchainSparseMerkleTreeProof2023")
  iden3OnchainSparseMerkleTreeProof2023
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerCredStatusDTO {
  final String id;
  final int? revocationNonce;
  @JsonKey(name: 'type')
  final ClaimProofIssuerCredStatusType type;
  final ClaimProofIssuerCredStatusDTO? statusIssuer;

  ClaimProofIssuerCredStatusDTO(
      this.id, this.revocationNonce, this.type, this.statusIssuer);

  factory ClaimProofIssuerCredStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerCredStatusDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimProofIssuerCredStatusDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerStateDTO {
  @JsonKey(name: 'claimsTreeRoot')
  final String claimsTreeRoot;
  @JsonKey(name: 'revocationTreeRoot', includeIfNull: false)
  final String? revocationTreeRoot;
  @JsonKey(name: 'rootOfRoots', includeIfNull: false)
  final String? rootOfRoots;
  @JsonKey(name: 'value')
  final String value;

  ClaimProofIssuerStateDTO(this.claimsTreeRoot, this.revocationTreeRoot,
      this.rootOfRoots, this.value);

  factory ClaimProofIssuerStateDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerStateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimProofIssuerStateDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClaimProofIssuerDTO {
  final String id;
  final ClaimProofIssuerStateDTO state;

  ClaimProofIssuerDTO(this.id, this.state);

  factory ClaimProofIssuerDTO.fromJson(Map<String, dynamic> json) =>
      _$ClaimProofIssuerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimProofIssuerDTOToJson(this);
}
