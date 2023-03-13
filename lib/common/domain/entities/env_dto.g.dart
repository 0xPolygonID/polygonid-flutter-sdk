// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvDTO _$EnvDTOFromJson(Map<String, dynamic> json) => EnvDTO(
      blockchain: json['blockchain'] as String,
      network: json['network'] as String,
      url: json['url'] as String,
      rdpUrl: json['rdpUrl'] as String,
      rhsUrl: json['rhsUrl'] as String,
      apiKey: json['apiKey'] as String,
      idStateContract: json['idStateContract'] as String,
    );

Map<String, dynamic> _$EnvDTOToJson(EnvDTO instance) => <String, dynamic>{
      'blockchain': instance.blockchain,
      'network': instance.network,
      'url': instance.url,
      'rdpUrl': instance.rdpUrl,
      'rhsUrl': instance.rhsUrl,
      'apiKey': instance.apiKey,
      'idStateContract': instance.idStateContract,
    };
