// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwz_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWZScope _$JWZScopeFromJson(Map<String, dynamic> json) => JWZScope(
      id: json['id'] as int,
      circuitId: json['circuit_id'] as String,
      proof: JWZBaseProof.fromJson(json['proof'] as Map<String, dynamic>),
      pubSignals: (json['pub_signals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JWZScopeToJson(JWZScope instance) => <String, dynamic>{
      'id': instance.id,
      'circuit_id': instance.circuitId,
      'proof': instance.proof,
      'pub_signals': instance.pubSignals,
    };

JWZBody _$JWZBodyFromJson(Map<String, dynamic> json) => JWZBody(
      message: json['message'] as String,
      scope: (json['scope'] as List<dynamic>)
          .map((e) => JWZScope.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JWZBodyToJson(JWZBody instance) => <String, dynamic>{
      'message': instance.message,
      'scope': instance.scope,
    };

JWZPayload _$JWZPayloadFromJson(Map<String, dynamic> json) => JWZPayload(
      id: json['id'] as String,
      typ: json['typ'] as String,
      type: json['type'] as String,
      thid: json['thid'] as String,
      body: JWZBody.fromJson(json['body'] as Map<String, dynamic>),
      from: json['from'] as String,
      to: json['to'] as String,
    );

Map<String, dynamic> _$JWZPayloadToJson(JWZPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typ': instance.typ,
      'type': instance.type,
      'thid': instance.thid,
      'body': instance.body,
      'from': instance.from,
      'to': instance.to,
    };
