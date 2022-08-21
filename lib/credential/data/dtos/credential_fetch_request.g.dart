// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_fetch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialFetchRequest _$CredentialFetchRequestFromJson(
        Map<String, dynamic> json) =>
    CredentialFetchRequest(
      id: json['id'] as String,
      typ: json['typ'] as String,
      type: json['type'] as String,
      thid: json['thid'] as String,
      body: CredentialFetchRequestBody.fromJson(
          json['body'] as Map<String, dynamic>),
      from: json['from'] as String,
      to: json['to'] as String,
    );

Map<String, dynamic> _$CredentialFetchRequestToJson(
        CredentialFetchRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typ': instance.typ,
      'type': instance.type,
      'thid': instance.thid,
      'body': instance.body.toJson(),
      'from': instance.from,
      'to': instance.to,
    };

CredentialFetchRequestBody _$CredentialFetchRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CredentialFetchRequestBody(
      id: json['id'] as String,
    );

Map<String, dynamic> _$CredentialFetchRequestBodyToJson(
        CredentialFetchRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
