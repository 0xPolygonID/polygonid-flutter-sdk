// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityProfileDTO _$IdentityProfileDTOFromJson(Map<String, dynamic> json) =>
    IdentityProfileDTO(
      did: json['did'] as String,
      nonce: json['nonce'] as String,
    );

Map<String, dynamic> _$IdentityProfileDTOToJson(IdentityProfileDTO instance) =>
    <String, dynamic>{
      'did': instance.did,
      'nonce': instance.nonce,
    };
