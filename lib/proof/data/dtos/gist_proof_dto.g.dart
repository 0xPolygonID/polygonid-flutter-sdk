// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gist_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GistProofDTO _$GistProofDTOFromJson(Map<String, dynamic> json) => GistProofDTO(
      root: json['root'] as String,
      proof: ProofDTO.fromJson(json['proof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GistProofDTOToJson(GistProofDTO instance) =>
    <String, dynamic>{
      'root': instance.root,
      'proof': instance.proof,
    };
