// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwz_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWZBaseProof _$JWZBaseProofFromJson(Map<String, dynamic> json) => JWZBaseProof(
      piA: (json['pi_a'] as List<dynamic>).map((e) => e as String).toList(),
      piB: (json['pi_b'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      piC: (json['pi_c'] as List<dynamic>).map((e) => e as String).toList(),
      protocol: json['protocol'] as String,
      curve: json['curve'] as String,
    );

Map<String, dynamic> _$JWZBaseProofToJson(JWZBaseProof instance) =>
    <String, dynamic>{
      'pi_a': instance.piA,
      'pi_b': instance.piB,
      'pi_c': instance.piC,
      'protocol': instance.protocol,
      'curve': instance.curve,
    };

JWZProof _$JWZProofFromJson(Map<String, dynamic> json) => JWZProof(
      proof: JWZBaseProof.fromJson(json['proof'] as Map<String, dynamic>),
      pubSignals: (json['pub_signals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JWZProofToJson(JWZProof instance) => <String, dynamic>{
      'proof': instance.proof.toJson(),
      'pub_signals': instance.pubSignals,
    };
