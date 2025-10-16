// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDDocumentService _$DIDDocumentServiceFromJson(Map<String, dynamic> json) =>
    DIDDocumentService(
      id: json['id'] as String,
      type: json['type'] as String,
      serviceEndpoint: json['serviceEndpoint'] as String?,
      metadata: json['metadata'] == null
          ? null
          : DIDDocumentServiceMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DIDDocumentServiceToJson(DIDDocumentService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'serviceEndpoint': instance.serviceEndpoint,
      'metadata': instance.metadata?.toJson(),
    };
