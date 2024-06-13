// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtproof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MTProofDTO _$MTProofDTOFromJson(Map<String, dynamic> json) => MTProofDTO(
      existence: json['existence'] as bool,
      siblings: (json['siblings'] as List<dynamic>)
          .map((e) => HashDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      nodeAux: json['node_aux'] == null
          ? null
          : NodeAuxEntity.fromJson(json['node_aux'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MTProofDTOToJson(MTProofDTO instance) =>
    <String, dynamic>{
      'existence': instance.existence,
      'siblings': instance.siblings.map((e) => e.toJson()).toList(),
      'node_aux': instance.nodeAux?.toJson(),
    };
