// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDTO _$IdentityDTOFromJson(Map<String, dynamic> json) => IdentityDTO(
      privateKey: json['privateKey'] as String,
      identifier: json['identifier'] as String,
      authClaim: json['authClaim'] as String,
    );

Map<String, dynamic> _$IdentityDTOToJson(IdentityDTO instance) =>
    <String, dynamic>{
      'privateKey': instance.privateKey,
      'identifier': instance.identifier,
      'authClaim': instance.authClaim,
    };
