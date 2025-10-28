// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_service_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDDocumentServiceMetadata _$DIDDocumentServiceMetadataFromJson(
  Map<String, dynamic> json,
) => DIDDocumentServiceMetadata(
  devices: (json['devices'] as List<dynamic>?)
      ?.map(
        (e) => DIDDocumentServiceMetadataDevices.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$DIDDocumentServiceMetadataToJson(
  DIDDocumentServiceMetadata instance,
) => <String, dynamic>{
  'devices': instance.devices?.map((e) => e.toJson()).toList(),
};
