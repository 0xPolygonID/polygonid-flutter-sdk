// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionDTO _$ConnectionDTOFromJson(Map<String, dynamic> json) =>
    ConnectionDTO(
      from: json['from'] as String,
      to: json['to'] as String,
      interactions: json['interactions'] as List<dynamic>,
    );

Map<String, dynamic> _$ConnectionDTOToJson(ConnectionDTO instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'interactions': instance.interactions,
    };
