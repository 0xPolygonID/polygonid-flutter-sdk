// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CredentialProofDTOToJson(CredentialProofDTO instance) =>
    <String, dynamic>{
      'stringify': instance.stringify,
      'hashCode': instance.hashCode,
      '@type': _$CredentialProofTypeEnumMap[instance.type]!,
      'issuer_data': instance.issuer.toJson(),
      'props': instance.props,
    };

const _$CredentialProofTypeEnumMap = {
  CredentialProofType.bjj: 'BJJSignature2021',
  CredentialProofType.sparseMerkle: 'Iden3SparseMerkleProof',
};

CredentialProofMTPDTO _$CredentialProofMTPDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofMTPDTO(
      json['existence'] as bool,
      (json['siblings'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CredentialProofMTPDTOToJson(
        CredentialProofMTPDTO instance) =>
    <String, dynamic>{
      'existence': instance.existence,
      'siblings': instance.siblings,
    };

CredentialProofIssuerStateDTO _$CredentialProofIssuerStateDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofIssuerStateDTO(
      json['claims_tree_root'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$CredentialProofIssuerStateDTOToJson(
        CredentialProofIssuerStateDTO instance) =>
    <String, dynamic>{
      'claims_tree_root': instance.treeRoot,
      'value': instance.value,
    };

CredentialProofIssuerDTO _$CredentialProofIssuerDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofIssuerDTO(
      json['id'] as String,
      CredentialProofIssuerStateDTO.fromJson(
          json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredentialProofIssuerDTOToJson(
        CredentialProofIssuerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
    };
