// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_claim_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityClaimDTO _$IdentityClaimDTOFromJson(Map<String, dynamic> json) =>
    IdentityClaimDTO(
      children: (json['children'] as List<dynamic>)
          .map((e) => HashEntity.fromJson(e as String))
          .toList(),
      hashIndex: HashEntity.fromJson(json['hashIndex'] as String),
      hashValue: HashEntity.fromJson(json['hashValue'] as String),
    );

Map<String, dynamic> _$IdentityClaimDTOToJson(IdentityClaimDTO instance) =>
    <String, dynamic>{
      'hashIndex': instance.hashIndex,
      'hashValue': instance.hashValue,
      'children': instance.children,
    };
