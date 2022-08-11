// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDTO _$ClaimDTOFromJson(Map<String, dynamic> json) => ClaimDTO(
      issuer: json['issuer'] as String,
      identifier: json['identifier'] as String,
      state: json['state'] as String? ?? '',
      credential:
          CredentialDTO.fromJson(json['credential'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimDTOToJson(ClaimDTO instance) => <String, dynamic>{
      'issuer': instance.issuer,
      'identifier': instance.identifier,
      'state': instance.state,
      'credential': instance.credential.toJson(),
    };
