// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDTO _$ClaimDTOFromJson(Map<String, dynamic> json) => ClaimDTO(
      id: json['id'] as String,
      issuer: json['issuer'] as String,
      did: json['did'] as String,
      type: json['type'] as String,
      state: json['state'] as String? ?? '',
      expiration: json['expiration'] as String?,
      info: ClaimInfoDTO.fromJson(json['credential'] as Map<String, dynamic>),
      schema: json['schema'] as Map<String, dynamic>?,
      displayType: json['displayType'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ClaimDTOToJson(ClaimDTO instance) => <String, dynamic>{
      'id': instance.id,
      'issuer': instance.issuer,
      'did': instance.did,
      'state': instance.state,
      'credential': instance.info.toJson(),
      'expiration': instance.expiration,
      'type': instance.type,
      'schema': instance.schema,
      'displayType': instance.displayType,
    };
