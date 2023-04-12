// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDTO _$IdentityDTOFromJson(Map<String, dynamic> json) => IdentityDTO(
      did: json['did'] as String,
      publicKey:
          (json['publicKey'] as List<dynamic>).map((e) => e as String).toList(),
      profiles: (json['profiles'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(BigInt.parse(k), e as String),
      ),
    );

Map<String, dynamic> _$IdentityDTOToJson(IdentityDTO instance) =>
    <String, dynamic>{
      'did': instance.did,
      'publicKey': instance.publicKey,
      'profiles': instance.profiles.map((k, e) => MapEntry(k.toString(), e)),
    };
