// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_proof_sm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialProofSMDTO _$CredentialProofSMDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofSMDTO(
      $enumDecode(_$CredentialProofTypeEnumMap, json['@type']),
      CredentialProofIssuerSMDTO.fromJson(
          json['issuer_data'] as Map<String, dynamic>),
      CredentialProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredentialProofSMDTOToJson(
        CredentialProofSMDTO instance) =>
    <String, dynamic>{
      '@type': _$CredentialProofTypeEnumMap[instance.type]!,
      'issuer_data': instance.issuer.toJson(),
      'mtp': instance.mtp.toJson(),
    };

const _$CredentialProofTypeEnumMap = {
  CredentialProofType.bjj: 'BJJSignature2021',
  CredentialProofType.sparseMerkle: 'Iden3SparseMerkleProof',
};

CredentialProofIssuerSMDTO _$CredentialProofIssuerSMDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofIssuerSMDTO(
      json['id'] as String,
      CredentialProofIssuerStateSMDTO.fromJson(
          json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredentialProofIssuerSMDTOToJson(
        CredentialProofIssuerSMDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
    };

CredentialProofIssuerStateSMDTO _$CredentialProofIssuerStateSMDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofIssuerStateSMDTO(
      json['claims_tree_root'] as String,
      json['value'] as String,
      json['block_number'] as int,
      json['block_timestamp'] as int,
      json['revocation_tree_root'] as String,
      json['root_of_roots'] as String,
      json['tx_id'] as String,
    );

Map<String, dynamic> _$CredentialProofIssuerStateSMDTOToJson(
        CredentialProofIssuerStateSMDTO instance) =>
    <String, dynamic>{
      'claims_tree_root': instance.treeRoot,
      'value': instance.value,
      'block_number': instance.number,
      'block_timestamp': instance.timestamp,
      'revocation_tree_root': instance.revocationTree,
      'root_of_roots': instance.root,
      'tx_id': instance.tx,
    };
