import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_metadata.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_resolution_metadata.dart';

part 'did_resolution_result.g.dart';

@JsonSerializable(explicitToJson: true)
class DIDResolutionResult with EquatableMixin {
  @JsonKey(name: '@context', fromJson: _contextFromJson)
  final List<String> context;
  final DIDResolutionMetadata didResolutionMetadata;
  final DIDDocument? didDocument;
  final DIDDocumentMetadata didDocumentMetadata;

  DIDResolutionResult({
    required this.context,
    required this.didResolutionMetadata,
    this.didDocument,
    required this.didDocumentMetadata,
  });

  factory DIDResolutionResult.fromJson(Map<String, dynamic> json) =>
      _$DIDResolutionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DIDResolutionResultToJson(this);

  @override
  List<Object?> get props => [
        context,
        didResolutionMetadata,
        didDocument,
        didDocumentMetadata,
      ];
}

List<String> _contextFromJson(dynamic json) {
  if (json is String) {
    return [json];
  } else if (json is List) {
    return json.map((e) => e.toString()).toList();
  } else {
    throw Exception('Invalid @context format');
  }
}
