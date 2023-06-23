// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zkproof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZKProofBaseDTO _$ZKProofBaseDTOFromJson(Map<String, dynamic> json) =>
    ZKProofBaseDTO(
      piA: (json['pi_a'] as List<dynamic>).map((e) => e as String).toList(),
      piB: (json['pi_b'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      piC: (json['pi_c'] as List<dynamic>).map((e) => e as String).toList(),
      protocol: json['protocol'] as String,
      curve: json['curve'] as String,
    );

Map<String, dynamic> _$ZKProofBaseDTOToJson(ZKProofBaseDTO instance) =>
    <String, dynamic>{
      'pi_a': instance.piA,
      'pi_b': instance.piB,
      'pi_c': instance.piC,
      'protocol': instance.protocol,
      'curve': instance.curve,
    };

ZKProofDTO _$ZKProofDTOFromJson(Map<String, dynamic> json) => ZKProofDTO(
      proof: ZKProofBaseDTO.fromJson(json['proof'] as Map<String, dynamic>),
      pubSignals: (json['pubSignals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ZKProofDTOToJson(ZKProofDTO instance) =>
    <String, dynamic>{
      'proof': instance.proof.toJson(),
      'pubSignals': instance.pubSignals,
    };
