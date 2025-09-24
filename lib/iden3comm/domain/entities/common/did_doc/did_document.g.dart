// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDDocument _$DIDDocumentFromJson(Map<String, dynamic> json) => DIDDocument(
      id: json['id'] as String,
      context: parseContext(json['@context']),
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => DIDDocumentService.fromJson(e as Map<String, dynamic>))
          .toList(),
      alsoKnownAs: (json['alsoKnownAs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      controller: (json['controller'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      verificationMethod: (json['verificationMethod'] as List<dynamic>?)
          ?.map((e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyAgreement: (json['keyAgreement'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DIDDocumentToJson(DIDDocument instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@context', instance.context);
  writeNotNull('alsoKnownAs', instance.alsoKnownAs);
  writeNotNull('controller', instance.controller);
  writeNotNull('service', instance.service?.map((e) => e.toJson()).toList());
  writeNotNull('verificationMethod',
      instance.verificationMethod?.map((e) => e.toJson()).toList());
  writeNotNull('keyAgreement', instance.keyAgreement);
  return val;
}

VerificationMethod _$VerificationMethodFromJson(Map<String, dynamic> json) =>
    VerificationMethod(
      id: json['id'] as String,
      type: json['type'] as String,
      controller: json['controller'] as String,
      publicKeyBase58: json['publicKeyBase58'] as String?,
      publicKeyBase64: json['publicKeyBase64'] as String?,
      publicKeyHex: json['publicKeyHex'] as String?,
      publicKeyMultibase: json['publicKeyMultibase'] as String?,
      blockchainAccountId: json['blockchainAccountId'] as String?,
      ethereumAddress: json['ethereumAddress'] as String?,
      publicKeyJwk: json['publicKeyJwk'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$VerificationMethodToJson(VerificationMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'controller': instance.controller,
      'publicKeyBase58': instance.publicKeyBase58,
      'publicKeyBase64': instance.publicKeyBase64,
      'publicKeyHex': instance.publicKeyHex,
      'publicKeyMultibase': instance.publicKeyMultibase,
      'blockchainAccountId': instance.blockchainAccountId,
      'ethereumAddress': instance.ethereumAddress,
      'publicKeyJwk': instance.publicKeyJwk,
    };
