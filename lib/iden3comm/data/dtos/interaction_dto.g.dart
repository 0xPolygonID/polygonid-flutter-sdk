// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InteractionDTO _$InteractionDTOFromJson(Map<String, dynamic> json) =>
    InteractionDTO(
      from: json['from'] as String,
      to: json['to'] as String,
      timestamp: json['timestamp'] as String,
      type: $enumDecode(_$InteractionTypeDTOEnumMap, json['type']),
      state: $enumDecode(_$InteractionStateDTOEnumMap, json['state']),
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$InteractionDTOToJson(InteractionDTO instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'timestamp': instance.timestamp,
      'type': _$InteractionTypeDTOEnumMap[instance.type]!,
      'state': _$InteractionStateDTOEnumMap[instance.state]!,
      'data': instance.data,
    };

const _$InteractionTypeDTOEnumMap = {
  InteractionTypeDTO.auth: 'auth',
  InteractionTypeDTO.offer: 'offer',
};

const _$InteractionStateDTOEnumMap = {
  InteractionStateDTO.unread: 'unread',
  InteractionStateDTO.read: 'read',
};
