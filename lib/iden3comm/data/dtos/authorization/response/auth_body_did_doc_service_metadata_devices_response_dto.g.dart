// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_body_did_doc_service_metadata_devices_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBodyDidDocServiceMetadataDevicesResponseDTO
    _$AuthBodyDidDocServiceMetadataDevicesResponseDTOFromJson(
            Map<String, dynamic> json) =>
        AuthBodyDidDocServiceMetadataDevicesResponseDTO(
          ciphertext: json['ciphertext'] as String?,
          alg: json['alg'] as String?,
        );

Map<String, dynamic> _$AuthBodyDidDocServiceMetadataDevicesResponseDTOToJson(
        AuthBodyDidDocServiceMetadataDevicesResponseDTO instance) =>
    <String, dynamic>{
      'ciphertext': instance.ciphertext,
      'alg': instance.alg,
    };
