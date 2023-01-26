// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeDTO _$NodeDTOFromJson(Map<String, dynamic> json) => NodeDTO(
      children: (json['children'] as List<dynamic>)
          .map((e) => HashDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      hash: HashDTO.fromJson(json['hash'] as Map<String, dynamic>),
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
