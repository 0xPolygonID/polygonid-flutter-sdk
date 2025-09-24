// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_resolution_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDResolutionMetadata _$DIDResolutionMetadataFromJson(
        Map<String, dynamic> json) =>
    DIDResolutionMetadata(
      contentType: json['contentType'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$DIDResolutionMetadataToJson(
        DIDResolutionMetadata instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'error': instance.error,
    };
