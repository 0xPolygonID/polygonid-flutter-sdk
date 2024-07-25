// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhs_node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RhsNodeDTO _$RhsNodeDTOFromJson(Map<String, dynamic> json) => RhsNodeDTO(
      node: NodeEntity.fromJson(json['node'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$RhsNodeDTOToJson(RhsNodeDTO instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'status': instance.status,
    };
