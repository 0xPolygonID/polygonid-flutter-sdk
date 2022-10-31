// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_proof_bjj_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimProofBJJDTO _$ClaimProofBJJDTOFromJson(Map<String, dynamic> json) =>
    ClaimProofBJJDTO(
      $enumDecode(_$ClaimProofTypeEnumMap, json['@type']),
      ClaimProofIssuerDTO.fromJson(json['issuer_data'] as Map<String, dynamic>),
      json['signature'] as String,
    );

Map<String, dynamic> _$ClaimProofBJJDTOToJson(ClaimProofBJJDTO instance) =>
    <String, dynamic>{
      '@type': _$ClaimProofTypeEnumMap[instance.type]!,
      'issuer_data': instance.issuer.toJson(),
      'signature': instance.signature,
    };

const _$ClaimProofTypeEnumMap = {
  ClaimProofType.bjj: 'BJJSignature2021',
  ClaimProofType.sparseMerkle: 'Iden3SparseMerkleProof',
};

ClaimProofIssuerBJJDTO _$ClaimProofIssuerBJJDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerBJJDTO(
      json['id'] as String,
      ClaimProofIssuerStateDTO.fromJson(json['state'] as Map<String, dynamic>),
      (json['auth_claim'] as List<dynamic>).map((e) => e as String).toList(),
      ClaimProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
      json['revocation_status'] as String,
    );

Map<String, dynamic> _$ClaimProofIssuerBJJDTOToJson(
        ClaimProofIssuerBJJDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
      'auth_claim': instance.authClaim,
      'mtp': instance.mtp.toJson(),
      'revocation_status': instance.revocationStatus,
    };
