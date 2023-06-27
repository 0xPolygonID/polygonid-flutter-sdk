// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iden3comm_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iden3commProofDTO _$Iden3commProofDTOFromJson(Map<String, dynamic> json) =>
    Iden3commProofDTO(
      id: json['id'] as int,
      circuitId: json['circuitId'] as String,
      proof: ZKProofBaseDTO.fromJson(json['proof'] as Map<String, dynamic>),
      pubSignals: (json['pub_signals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$Iden3commProofDTOToJson(Iden3commProofDTO instance) =>
    <String, dynamic>{
      'proof': instance.proof,
      'pub_signals': instance.pubSignals,
      'id': instance.id,
      'circuitId': instance.circuitId,
    };
