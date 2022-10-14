// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhs_node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RhsNodeDTO _$RhsNodeDTOFromJson(Map<String, dynamic> json) => RhsNodeDTO(
      node: RhsNodeItemDTO.fromJson(json['node'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$RhsNodeDTOToJson(RhsNodeDTO instance) =>
    <String, dynamic>{
      'node': instance.node,
      'status': instance.status,
    };

RhsNodeItemDTO _$RhsNodeItemDTOFromJson(Map<String, dynamic> json) =>
    RhsNodeItemDTO(
      children:
          (json['children'] as List<dynamic>).map((e) => e as String).toList(),
      hash: json['hash'] as String,
    );

Map<String, dynamic> _$RhsNodeItemDTOToJson(RhsNodeItemDTO instance) =>
    <String, dynamic>{
      'children': instance.children,
      'hash': instance.hash,
    };
