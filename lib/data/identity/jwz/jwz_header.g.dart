// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwz_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWZHeader _$JWZHeaderFromJson(Map<String, dynamic> json) => JWZHeader(
      alg: json['alg'] as String,
      circuitId: json['circuitId'] as String,
      crit: (json['crit'] as List<dynamic>).map((e) => e as String).toList(),
      typ: json['typ'] as String,
    );

Map<String, dynamic> _$JWZHeaderToJson(JWZHeader instance) => <String, dynamic>{
      'alg': instance.alg,
      'circuitId': instance.circuitId,
      'crit': instance.crit,
      'typ': instance.typ,
    };
