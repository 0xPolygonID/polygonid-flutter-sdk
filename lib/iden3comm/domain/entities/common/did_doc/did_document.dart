import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service.dart';

typedef AuthBodyDidDocResponse = DIDDocument;

class DIDDocument {
  final List<String>? context;
  final String id;
  final List<String>? alsoKnownAs;
  final List<String>? controller;
  final List<DIDDocumentService>? service;
  final List<String>? verificationMethod;

  DIDDocument({
    this.context,
    required this.id,
    this.service,
    this.alsoKnownAs,
    this.controller,
    this.verificationMethod,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [DIDDocument]
  factory DIDDocument.fromJson(Map<String, dynamic> json) {
    List<String>? context =
        (json['@context'] as List?)?.map((item) => item as String).toList();

    List<DIDDocumentService>? service = (json['service'] as List?)
        ?.map((item) => DIDDocumentService.fromJson(item))
        .toList();

    List<String>? alsoKnownAs =
        (json['alsoKnownAs'] as List?)?.map((item) => item as String).toList();

    List<String>? controller =
        (json['controller'] as List?)?.map((item) => item as String).toList();

    List<String>? verificationMethod = (json['verificationMethod'] as List?)
        ?.map((item) => item as String)
        .toList();

    return DIDDocument(
      context: context,
      id: json['id'],
      service: service,
      alsoKnownAs: alsoKnownAs,
      controller: controller,
      verificationMethod: verificationMethod,
    );
  }

  Map<String, dynamic> toJson() => {
        '@context': context,
        'id': id,
        'service': service?.map((item) => item.toJson()).toList(),
        'alsoKnownAs': alsoKnownAs,
        'controller': controller,
        'verificationMethod': verificationMethod,
      };
}
