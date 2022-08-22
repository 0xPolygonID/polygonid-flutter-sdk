// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialDTO _$CredentialDTOFromJson(Map<String, dynamic> json) =>
    CredentialDTO(
      json['id'] as String,
      json['expiration'] as String?,
      json['updatable'] as bool?,
      json['version'] as int,
      json['rev_nonce'] as int,
      CredentialSubjectDTO.fromJson(
          json['credentialSubject'] as Map<String, dynamic>),
      CredentialStatusDTO.fromJson(
          json['credentialStatus'] as Map<String, dynamic>),
      CredentialSchemaDTO.fromJson(
          json['credentialSchema'] as Map<String, dynamic>),
      (json['proof'] as List<dynamic>)
          .map((e) => CredentialProofDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CredentialDTOToJson(CredentialDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiration': instance.expiration,
      'updatable': instance.updatable,
      'version': instance.version,
      'rev_nonce': instance.revNonce,
      'credentialSubject': instance.credentialSubject.toJson(),
      'credentialStatus': instance.credentialStatus.toJson(),
      'credentialSchema': instance.credentialSchema.toJson(),
      'proof': instance.proofs.map((e) => e.toJson()).toList(),
    };

CredentialStatusDTO _$CredentialStatusDTOFromJson(Map<String, dynamic> json) =>
    CredentialStatusDTO(
      json['id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$CredentialStatusDTOToJson(
        CredentialStatusDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

CredentialSchemaDTO _$CredentialSchemaDTOFromJson(Map<String, dynamic> json) =>
    CredentialSchemaDTO(
      json['@id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$CredentialSchemaDTOToJson(
        CredentialSchemaDTO instance) =>
    <String, dynamic>{
      '@id': instance.id,
      'type': instance.type,
    };
