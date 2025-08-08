// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

W3CCredential _$W3CCredentialFromJson(Map<String, dynamic> json) =>
    W3CCredential(
      json['id'] as String,
      (json['@context'] as List<dynamic>).map((e) => e as String).toList(),
      (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      json['expirationDate'] as String?,
      json['issuanceDate'] as String?,
      CredentialSubject.fromJson(
          json['credentialSubject'] as Map<String, dynamic>),
      CredentialStatus.fromJson(
          json['credentialStatus'] as Map<String, dynamic>),
      json['issuer'] as String,
      CredentialSchema.fromJson(
          json['credentialSchema'] as Map<String, dynamic>),
      (json['proof'] as List<dynamic>?)
          ?.map((e) => ClaimProofDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['refreshService'] == null
          ? null
          : RefreshService.fromJson(
              json['refreshService'] as Map<String, dynamic>),
      json['displayMethod'] == null
          ? null
          : DisplayMethod.fromJson(
              json['displayMethod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$W3CCredentialToJson(W3CCredential instance) =>
    <String, dynamic>{
      'id': instance.id,
      '@context': instance.context,
      'type': instance.type,
      'expirationDate': instance.expirationDate,
      'refreshService': instance.refreshService?.toJson(),
      'displayMethod': instance.displayMethod?.toJson(),
      'issuanceDate': instance.issuanceDate,
      'credentialSubject': instance.credentialSubject.toJson(),
      'credentialStatus': instance.credentialStatus.toJson(),
      'issuer': instance.issuer,
      'credentialSchema': instance.credentialSchema.toJson(),
      'proof': instance.proof?.map((e) => e.toJson()).toList(),
    };

CredentialStatus _$CredentialStatusFromJson(Map<String, dynamic> json) =>
    CredentialStatus(
      json['id'] as String,
      (json['revocationNonce'] as num?)?.toInt(),
      $enumDecode(_$CredentialStatusTypeEnumMap, json['type']),
      json['statusIssuer'] == null
          ? null
          : CredentialStatus.fromJson(
              json['statusIssuer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredentialStatusToJson(CredentialStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'revocationNonce': instance.revocationNonce,
      'type': _$CredentialStatusTypeEnumMap[instance.type]!,
      'statusIssuer': instance.statusIssuer?.toJson(),
    };

const _$CredentialStatusTypeEnumMap = {
  CredentialStatusType.sparseMerkleTreeProof: 'SparseMerkleTreeProof',
  CredentialStatusType.reverseSparseMerkleTreeProof:
      'Iden3ReverseSparseMerkleTreeProof',
  CredentialStatusType.iden3commRevocationStatusV1:
      'Iden3commRevocationStatusV1.0',
  CredentialStatusType.iden3OnchainSparseMerkleTreeProof2023:
      'Iden3OnchainSparseMerkleTreeProof2023',
};

CredentialSchema _$CredentialSchemaFromJson(Map<String, dynamic> json) =>
    CredentialSchema(
      json['id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$CredentialSchemaToJson(CredentialSchema instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

DisplayMethod _$DisplayMethodFromJson(Map<String, dynamic> json) =>
    DisplayMethod(
      json['id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$DisplayMethodToJson(DisplayMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
