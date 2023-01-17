// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genesis_id_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenesisIdInputDTO _$GenesisIdInputDTOFromJson(Map<String, dynamic> json) =>
    GenesisIdInputDTO(
      claimsTreeRoot: json['claimsTreeRoot'] as String,
      blockchain: json['blockchain'] as String,
      network: json['network'] as String,
    );

Map<String, dynamic> _$GenesisIdInputDTOToJson(GenesisIdInputDTO instance) =>
    <String, dynamic>{
      'claimsTreeRoot': instance.claimsTreeRoot,
      'blockchain': instance.blockchain,
      'network': instance.network,
    };
