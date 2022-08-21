// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_proof_bjj_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialProofBJJDTO _$CredentialProofBJJDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofBJJDTO(
      $enumDecode(_$CredentialProofTypeEnumMap, json['@type']),
      CredentialProofIssuerDTO.fromJson(
          json['issuer_data'] as Map<String, dynamic>),
      json['signature'] as String,
    );

Map<String, dynamic> _$CredentialProofBJJDTOToJson(
        CredentialProofBJJDTO instance) =>
    <String, dynamic>{
      '@type': _$CredentialProofTypeEnumMap[instance.type]!,
      'issuer_data': instance.issuer.toJson(),
      'signature': instance.signature,
    };

const _$CredentialProofTypeEnumMap = {
  CredentialProofType.bjj: 'BJJSignature2021',
  CredentialProofType.sparseMerkle: 'Iden3SparseMerkleProof',
};

CredentialProofIssuerBJJDTO _$CredentialProofIssuerBJJDTOFromJson(
        Map<String, dynamic> json) =>
    CredentialProofIssuerBJJDTO(
      json['id'] as String,
      CredentialProofIssuerStateDTO.fromJson(
          json['state'] as Map<String, dynamic>),
      (json['auth_claim'] as List<dynamic>).map((e) => e as String).toList(),
      CredentialProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
      json['revocation_status'] as String,
    );

Map<String, dynamic> _$CredentialProofIssuerBJJDTOToJson(
        CredentialProofIssuerBJJDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
      'auth_claim': instance.authClaim,
      'mtp': instance.mtp.toJson(),
      'revocation_status': instance.revocationStatus,
    };
