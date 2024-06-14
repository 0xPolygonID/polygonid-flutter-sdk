// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gist_mtproof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GistMTProofEntity _$GistMTProofEntityFromJson(Map<String, dynamic> json) =>
    GistMTProofEntity(
      root: json['root'] as String,
      proof: MTProofEntity.fromJson(json['proof'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GistMTProofEntityToJson(GistMTProofEntity instance) =>
    <String, dynamic>{
      'root': instance.root,
      'proof': instance.proof.toJson(),
    };
