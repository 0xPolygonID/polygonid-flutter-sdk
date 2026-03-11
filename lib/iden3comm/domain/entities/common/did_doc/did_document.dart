import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document_service.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/context_parser.dart';

part 'did_document.g.dart';

typedef AuthBodyDidDocResponse = DIDDocument;

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DIDDocument with EquatableMixin {
  final String id;
  @JsonKey(name: '@context', fromJson: parseContext)
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

  factory DIDDocument.fromJson(Map<String, dynamic> json) =>
      _$DIDDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DIDDocumentToJson(this);

  @override
  List<Object?> get props => [
        id,
        context,
        service,
        alsoKnownAs,
        controller,
        verificationMethod,
        keyAgreement
      ];

  DIDDocument copyWith({
    String? id,
    List<String>? context,
    List<DIDDocumentService>? service,
    List<String>? alsoKnownAs,
    List<String>? controller,
    List<VerificationMethod>? verificationMethod,
    List<String>? keyAgreement,
  }) {
    return DIDDocument(
      id: id ?? this.id,
      context: context ?? this.context,
      service: service ?? this.service,
      alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
      controller: controller ?? this.controller,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      keyAgreement: keyAgreement ?? this.keyAgreement,
    );
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VerificationMethod with EquatableMixin {
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

  factory VerificationMethod.fromJson(Map<String, dynamic> json) =>
      _$VerificationMethodFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationMethodToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        controller,
        publicKeyBase58,
        publicKeyBase64,
        publicKeyHex,
        publicKeyMultibase,
        blockchainAccountId,
        ethereumAddress,
        publicKeyJwk
      ];
}
