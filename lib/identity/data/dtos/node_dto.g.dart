// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeDTO _$NodeDTOFromJson(Map<String, dynamic> json) => NodeDTO(
      children: (json['children'] as List<dynamic>)
          .map((e) => HashEntity.fromJson(e as String))
          .toList(),
      hash: HashEntity.fromJson(json['hash'] as String),
      type: $enumDecode(_$NodeTypeDTOEnumMap, json['type']),
    );

Map<String, dynamic> _$NodeDTOToJson(NodeDTO instance) => <String, dynamic>{
      'hash': instance.hash.toJson(),
      'children': instance.children.map((e) => e.toJson()).toList(),
      'type': _$NodeTypeDTOEnumMap[instance.type]!,
    };

const _$NodeTypeDTOEnumMap = {
  NodeTypeDTO.middle: 'middle',
  NodeTypeDTO.leaf: 'leaf',
  NodeTypeDTO.state: 'state',
  NodeTypeDTO.empty: 'empty',
  NodeTypeDTO.unknown: 'unknown',
};
