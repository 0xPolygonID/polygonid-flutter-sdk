// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_proof_sm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimProofSMDTO _$ClaimProofSMDTOFromJson(Map<String, dynamic> json) =>
    ClaimProofSMDTO(
      $enumDecode(_$ClaimProofTypeEnumMap, json['@type']),
      ClaimProofIssuerSMDTO.fromJson(
          json['issuer_data'] as Map<String, dynamic>),
      ClaimProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofSMDTOToJson(ClaimProofSMDTO instance) =>
    <String, dynamic>{
      '@type': _$ClaimProofTypeEnumMap[instance.type]!,
      'issuer_data': instance.issuer.toJson(),
      'mtp': instance.mtp.toJson(),
    };

const _$ClaimProofTypeEnumMap = {
  ClaimProofType.bjj: 'BJJSignature2021',
  ClaimProofType.sparseMerkle: 'Iden3SparseMerkleProof',
};

ClaimProofIssuerSMDTO _$ClaimProofIssuerSMDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerSMDTO(
      json['id'] as String,
      ClaimProofIssuerStateSMDTO.fromJson(
          json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofIssuerSMDTOToJson(
        ClaimProofIssuerSMDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
    };

ClaimProofIssuerStateSMDTO _$ClaimProofIssuerStateSMDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerStateSMDTO(
      json['claims_tree_root'] as String,
      json['value'] as String,
      json['block_number'] as int,
      json['block_timestamp'] as int,
      json['revocation_tree_root'] as String,
      json['root_of_roots'] as String,
      json['tx_id'] as String,
    );

Map<String, dynamic> _$ClaimProofIssuerStateSMDTOToJson(
        ClaimProofIssuerStateSMDTO instance) =>
    <String, dynamic>{
      'claims_tree_root': instance.treeRoot,
      'value': instance.value,
      'block_number': instance.number,
      'block_timestamp': instance.timestamp,
      'revocation_tree_root': instance.revocationTree,
      'root_of_roots': instance.root,
      'tx_id': instance.tx,
    };
