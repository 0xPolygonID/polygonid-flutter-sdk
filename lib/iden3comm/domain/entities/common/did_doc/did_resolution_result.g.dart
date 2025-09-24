// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_resolution_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDResolutionResult _$DIDResolutionResultFromJson(Map<String, dynamic> json) =>
    DIDResolutionResult(
      context: parseContext(json['@context']),
      didResolutionMetadata: DIDResolutionMetadata.fromJson(
          json['didResolutionMetadata'] as Map<String, dynamic>),
      didDocument: json['didDocument'] == null
          ? null
          : DIDDocument.fromJson(json['didDocument'] as Map<String, dynamic>),
      didDocumentMetadata: DIDDocumentMetadata.fromJson(
          json['didDocumentMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DIDResolutionResultToJson(
        DIDResolutionResult instance) =>
    <String, dynamic>{
      '@context': instance.context,
      'didResolutionMetadata': instance.didResolutionMetadata.toJson(),
      'didDocument': instance.didDocument?.toJson(),
      'didDocumentMetadata': instance.didDocumentMetadata.toJson(),
    };
