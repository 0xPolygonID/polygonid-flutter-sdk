import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service.dart';

typedef AuthBodyDidDocResponse = DIDDocument;

class DIDDocument {
  final String id;
  final List<String>? context;
  final List<String>? alsoKnownAs;
  final List<String>? controller;
  final List<DIDDocumentService>? service;
  final List<VerificationMethod>? verificationMethod;
  final List<String>? keyAgreement;

  DIDDocument({
    required this.id,
    this.context,
    this.service,
    this.alsoKnownAs,
    this.controller,
    this.verificationMethod,
    this.keyAgreement,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [DIDDocument]
  factory DIDDocument.fromJson(Map<String, dynamic> json) {
    List<String>? context = (json['@context'] as List?)
        ?.map((item) => item as String)
        .toList();

    List<DIDDocumentService>? service = (json['service'] as List?)
        ?.map((item) => DIDDocumentService.fromJson(item))
        .toList();

    List<String>? alsoKnownAs = (json['alsoKnownAs'] as List?)
        ?.map((item) => item as String)
        .toList();

    List<String>? controller = (json['controller'] as List?)
        ?.map((item) => item as String)
        .toList();

    List<VerificationMethod>? verificationMethod =
        (json['verificationMethod'] as List?)
            ?.map((item) => VerificationMethod.fromJson(item))
            .toList();

    List<String>? keyAgreement = (json['keyAgreement'] as List?)
        ?.map((item) => item as String)
        .toList();

    return DIDDocument(
      id: json['id'],
      context: context,
      service: service,
      alsoKnownAs: alsoKnownAs,
      controller: controller,
      verificationMethod: verificationMethod,
      keyAgreement: keyAgreement,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    '@context': context,
    if (service != null)
      'service': service?.map((item) => item.toJson()).toList(),
    if (alsoKnownAs != null) 'alsoKnownAs': alsoKnownAs,
    if (controller != null) 'controller': controller,
    if (verificationMethod != null)
      'verificationMethod': verificationMethod?.map((i) => i.toJson()).toList(),
    if (keyAgreement != null) 'keyAgreement': keyAgreement,
  };
}

class VerificationMethod {
  final String id;
  final String type;
  final String controller;
  final String? publicKeyBase58;
  final String? publicKeyBase64;
  final String? publicKeyHex;
  final String? publicKeyMultibase;
  final String? blockchainAccountId;
  final String? ethereumAddress;
  final Map<String, dynamic>? publicKeyJwk;

  VerificationMethod({
    required this.id,
    required this.type,
    required this.controller,
    this.publicKeyBase58,
    this.publicKeyBase64,
    this.publicKeyHex,
    this.publicKeyMultibase,
    this.blockchainAccountId,
    this.ethereumAddress,
    this.publicKeyJwk,
  });

  factory VerificationMethod.fromJson(Map<String, dynamic> json) {
    return VerificationMethod(
      id: json['id'],
      type: json['type'],
      controller: json['controller'],
      publicKeyBase58: json['publicKeyBase58'],
      publicKeyBase64: json['publicKeyBase64'],
      publicKeyHex: json['publicKeyHex'],
      publicKeyMultibase: json['publicKeyMultibase'],
      blockchainAccountId: json['blockchainAccountId'],
      ethereumAddress: json['ethereumAddress'],
      publicKeyJwk: json['publicKeyJwk'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'controller': controller,
      if (publicKeyBase58 != null) 'publicKeyBase58': publicKeyBase58,
      if (publicKeyBase64 != null) 'publicKeyBase64': publicKeyBase64,
      if (publicKeyHex != null) 'publicKeyHex': publicKeyHex,
      if (publicKeyMultibase != null) 'publicKeyMultibase': publicKeyMultibase,
      if (blockchainAccountId != null)
        'blockchainAccountId': blockchainAccountId,
      if (ethereumAddress != null) 'ethereumAddress': ethereumAddress,
      if (publicKeyJwk != null) 'publicKeyJwk': publicKeyJwk,
    };
  }
}
