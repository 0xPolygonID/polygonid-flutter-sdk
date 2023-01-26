// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeStateDTO _$TreeStateDTOFromJson(Map<String, dynamic> json) => TreeStateDTO(
      state: json['state'] as String,
      claimsRoot: json['claimsRoot'] as String,
      revocationRoot: json['revocationRoot'] as String,
      rootOfRoots: json['rootOfRoots'] as String,
    );

Map<String, dynamic> _$TreeStateDTOToJson(TreeStateDTO instance) =>
    <String, dynamic>{
      'state': instance.state,
      'claimsRoot': instance.claimsRoot,
      'revocationRoot': instance.revocationRoot,
      'rootOfRoots': instance.rootOfRoots,
    };
