import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'did_document_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class DIDDocumentMetadata with EquatableMixin {
  final String created;
  final String updated;
  final bool deactivated;
  final String versionId;
  final String nextUpdate;
  final String nextVersionId;
  final String equivalentId;
  final String canonicalId;

  DIDDocumentMetadata({
    required this.created,
    required this.updated,
    required this.deactivated,
    required this.versionId,
    required this.nextUpdate,
    required this.nextVersionId,
    required this.equivalentId,
    required this.canonicalId,
  });

  factory DIDDocumentMetadata.fromJson(Map<String, dynamic> json) =>
      _$DIDDocumentMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$DIDDocumentMetadataToJson(this);

  @override
  List<Object?> get props => [
        created,
        updated,
        deactivated,
        versionId,
        nextUpdate,
        nextVersionId,
        equivalentId,
        canonicalId,
      ];
}
