// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeStateDTO _$TreeStateDTOFromJson(Map<String, dynamic> json) => TreeStateDTO(
      state: json['state'] as String,
      rootOfRoots: json['rootOfRoots'] as String,
      claimsTreeRoot: json['claimsTreeRoot'] as String,
      revocationTreeRoot: json['revocationTreeRoot'] as String,
    );

Map<String, dynamic> _$TreeStateDTOToJson(TreeStateDTO instance) =>
    <String, dynamic>{
      'state': instance.state,
      'rootOfRoots': instance.rootOfRoots,
      'claimsTreeRoot': instance.claimsTreeRoot,
      'revocationTreeRoot': instance.revocationTreeRoot,
    };
