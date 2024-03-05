// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvDTO _$EnvDTOFromJson(Map<String, dynamic> json) => EnvDTO(
      blockchain: json['blockchain'] as String,
      network: json['network'] as String,
      web3Url: json['web3Url'] as String,
      web3RdpUrl: json['web3RdpUrl'] as String,
      web3ApiKey: json['web3ApiKey'] as String,
      idStateContract: json['idStateContract'] as String,
      pushUrl: json['pushUrl'] as String,
      ipfsUrl: json['ipfsUrl'] as String,
      stacktraceEncryptionKey: json['stacktraceEncryptionKey'] as String?,
      pinataGateway: json['pinataGateway'] as String?,
      pinataGatewayToken: json['pinataGatewayToken'] as String?,
    );

Map<String, dynamic> _$EnvDTOToJson(EnvDTO instance) => <String, dynamic>{
      'blockchain': instance.blockchain,
      'network': instance.network,
      'web3Url': instance.web3Url,
      'web3RdpUrl': instance.web3RdpUrl,
      'web3ApiKey': instance.web3ApiKey,
      'idStateContract': instance.idStateContract,
      'pushUrl': instance.pushUrl,
      'ipfsUrl': instance.ipfsUrl,
      'stacktraceEncryptionKey': instance.stacktraceEncryptionKey,
      'pinataGateway': instance.pinataGateway,
      'pinataGatewayToken': instance.pinataGatewayToken,
    };
