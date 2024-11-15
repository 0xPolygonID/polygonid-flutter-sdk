// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeEntity _$NodeEntityFromJson(Map<String, dynamic> json) => NodeEntity(
      children:
          (json['children'] as List<dynamic>).map(HashEntity.fromJson).toList(),
      hash: HashEntity.fromJson(json['hash']),
      type: $enumDecode(_$NodeTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$NodeEntityToJson(NodeEntity instance) =>
    <String, dynamic>{
      'hash': instance.hash.toJson(),
      'children': instance.children.map((e) => e.toJson()).toList(),
      'type': _$NodeTypeEnumMap[instance.type]!,
    };

const _$NodeTypeEnumMap = {
  NodeType.middle: 'middle',
  NodeType.leaf: 'leaf',
  NodeType.state: 'state',
  NodeType.empty: 'empty',
  NodeType.unknown: 'unknown',
};
