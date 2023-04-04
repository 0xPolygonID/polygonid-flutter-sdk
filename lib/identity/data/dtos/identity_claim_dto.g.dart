// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityClaimDTO _$IdentityClaimDTOFromJson(Map<String, dynamic> json) =>
    IdentityClaimDTO(
      children: (json['children'] as List<dynamic>)
          .map((e) => HashDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      hashIndex: HashDTO.fromJson(json['hashIndex'] as Map<String, dynamic>),
      hashValue: HashDTO.fromJson(json['hashValue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdentityClaimDTOToJson(IdentityClaimDTO instance) =>
    <String, dynamic>{
      'hashIndex': instance.hashIndex,
      'hashValue': instance.hashValue,
      'children': instance.children,
    };
