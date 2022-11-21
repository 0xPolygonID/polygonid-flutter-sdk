// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofDTO _$ProofDTOFromJson(Map<String, dynamic> json) => ProofDTO(
      existence: json['existence'] as bool,
      siblings: (json['siblings'] as List<dynamic>)
          .map((e) => HashDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      nodeAux: json['node_aux'] == null
          ? null
          : NodeAuxDTO.fromJson(json['node_aux'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProofDTOToJson(ProofDTO instance) => <String, dynamic>{
      'existence': instance.existence,
      'siblings': instance.siblings,
      'node_aux': instance.nodeAux,
    };
