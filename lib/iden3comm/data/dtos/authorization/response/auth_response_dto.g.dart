// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseDTO _$AuthResponseDTOFromJson(Map<String, dynamic> json) =>
    AuthResponseDTO(
      id: json['id'] as String?,
      typ: json['typ'] as String?,
      type: json['type'] as String?,
      thid: json['thid'] as String?,
      body: json['body'] == null
          ? null
          : AuthBodyResponseDTO.fromJson(json['body'] as Map<String, dynamic>),
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$AuthResponseDTOToJson(AuthResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typ': instance.typ,
      'type': instance.type,
      'thid': instance.thid,
      'body': instance.body,
      'from': instance.from,
      'to': instance.to,
    };
