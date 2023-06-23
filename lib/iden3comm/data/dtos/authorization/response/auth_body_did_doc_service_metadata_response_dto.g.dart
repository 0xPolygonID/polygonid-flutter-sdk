// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_body_did_doc_service_metadata_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBodyDidDocServiceMetadataResponseDTO
    _$AuthBodyDidDocServiceMetadataResponseDTOFromJson(
            Map<String, dynamic> json) =>
        AuthBodyDidDocServiceMetadataResponseDTO(
          devices: (json['devices'] as List<dynamic>?)
              ?.map((e) =>
                  AuthBodyDidDocServiceMetadataDevicesResponseDTO.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$AuthBodyDidDocServiceMetadataResponseDTOToJson(
        AuthBodyDidDocServiceMetadataResponseDTO instance) =>
    <String, dynamic>{
      'devices': instance.devices,
    };
