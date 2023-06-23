// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gist_mtproof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GistMTProofDTO _$GistMTProofDTOFromJson(Map<String, dynamic> json) =>
    GistMTProofDTO(
      root: json['root'] as String,
      proof: MTProofDTO.fromJson(json['proof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GistMTProofDTOToJson(GistMTProofDTO instance) =>
    <String, dynamic>{
      'root': instance.root,
      'proof': instance.proof.toJson(),
    };
