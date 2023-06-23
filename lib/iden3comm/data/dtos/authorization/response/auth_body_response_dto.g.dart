// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_body_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBodyResponseDTO _$AuthBodyResponseDTOFromJson(Map<String, dynamic> json) =>
    AuthBodyResponseDTO(
      did_doc: json['did_doc'] == null
          ? null
          : AuthBodyDidDocResponseDTO.fromJson(
              json['did_doc'] as Map<String, dynamic>),
      message: json['message'] as String?,
      proofs: (json['proofs'] as List<dynamic>?)
          ?.map((e) => Iden3commProofDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthBodyResponseDTOToJson(
        AuthBodyResponseDTO instance) =>
    <String, dynamic>{
      'did_doc': instance.did_doc,
      'message': instance.message,
      'proofs': instance.proofs,
    };
