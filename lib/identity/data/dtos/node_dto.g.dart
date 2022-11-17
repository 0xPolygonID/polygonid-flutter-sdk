// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeDTO _$NodeDTOFromJson(Map<String, dynamic> json) => NodeDTO(
      children: (json['children'] as List<dynamic>)
          .map((e) => HashDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NodeDTOToJson(NodeDTO instance) => <String, dynamic>{
      'children': instance.children,
    };
