// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtproof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MTProofEntity _$MTProofEntityFromJson(Map<String, dynamic> json) =>
    MTProofEntity(
      existence: json['existence'] as bool,
      siblings: (json['siblings'] as List<dynamic>)
          .map((e) => HashEntity.fromJson(e as String))
          .toList(),
      nodeAux: json['node_aux'] == null
          ? null
          : NodeAuxEntity.fromJson(json['node_aux'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MTProofEntityToJson(MTProofEntity instance) =>
    <String, dynamic>{
      'existence': instance.existence,
      'siblings': instance.siblings.map((e) => e.toJson()).toList(),
      'node_aux': instance.nodeAux?.toJson(),
    };
