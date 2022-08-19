// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDTO _$ClaimDTOFromJson(Map<String, dynamic> json) => ClaimDTO(
      id: json['id'] as String,
      issuer: json['issuer'] as String,
      identifier: json['identifier'] as String,
      type: json['type'] as String,
      state: json['state'] as String? ?? '',
      expiration: json['expiration'] as String?,
      credential:
          CredentialDTO.fromJson(json['credential'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimDTOToJson(ClaimDTO instance) => <String, dynamic>{
      'id': instance.id,
      'issuer': instance.issuer,
      'identifier': instance.identifier,
      'state': instance.state,
      'credential': instance.credential.toJson(),
      'expiration': instance.expiration,
      'type': instance.type,
    };
