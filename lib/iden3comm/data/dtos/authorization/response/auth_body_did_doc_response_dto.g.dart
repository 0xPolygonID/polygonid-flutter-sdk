// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_body_did_doc_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBodyDidDocResponseDTO _$AuthBodyDidDocResponseDTOFromJson(
        Map<String, dynamic> json) =>
    AuthBodyDidDocResponseDTO(
      context:
          (json['context'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: json['id'] as String?,
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => AuthBodyDidDocServiceResponseDTO.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthBodyDidDocResponseDTOToJson(
        AuthBodyDidDocResponseDTO instance) =>
    <String, dynamic>{
      'context': instance.context,
      'id': instance.id,
      'service': instance.service,
    };
