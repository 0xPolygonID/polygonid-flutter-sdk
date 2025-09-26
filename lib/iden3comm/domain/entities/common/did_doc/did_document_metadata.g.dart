// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDDocumentMetadata _$DIDDocumentMetadataFromJson(Map<String, dynamic> json) =>
    DIDDocumentMetadata(
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      deactivated: json['deactivated'] as bool?,
      versionId: json['versionId'] as String?,
      nextUpdate: json['nextUpdate'] as String?,
      nextVersionId: json['nextVersionId'] as String?,
      equivalentId: json['equivalentId'] as String?,
      canonicalId: json['canonicalId'] as String?,
    );

Map<String, dynamic> _$DIDDocumentMetadataToJson(
        DIDDocumentMetadata instance) =>
    <String, dynamic>{
      'created': instance.created,
      'updated': instance.updated,
      'deactivated': instance.deactivated,
      'versionId': instance.versionId,
      'nextUpdate': instance.nextUpdate,
      'nextVersionId': instance.nextVersionId,
      'equivalentId': instance.equivalentId,
      'canonicalId': instance.canonicalId,
    };
