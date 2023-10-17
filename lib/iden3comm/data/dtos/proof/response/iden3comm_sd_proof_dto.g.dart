// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iden3comm_sd_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iden3commSDProofDTO _$Iden3commSDProofDTOFromJson(Map<String, dynamic> json) =>
    Iden3commSDProofDTO(
      vp: Iden3commVPProofDTO.fromJson(json['vp'] as Map<String, dynamic>),
      id: json['id'] as int,
      circuitId: json['circuitId'] as String,
      proof: ZKProofBaseDTO.fromJson(json['proof'] as Map<String, dynamic>),
      pubSignals: (json['pub_signals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$Iden3commSDProofDTOToJson(
        Iden3commSDProofDTO instance) =>
    <String, dynamic>{
      'proof': instance.proof,
      'pub_signals': instance.pubSignals,
      'id': instance.id,
      'circuitId': instance.circuitId,
      'vp': instance.vp,
    };
