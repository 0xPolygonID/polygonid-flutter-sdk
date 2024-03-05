import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'env_dto.g.dart';

@JsonSerializable()
class EnvDTO extends Equatable {
  final String blockchain;
  final String network;
  final String web3Url;
  final String web3RdpUrl;
  final String web3ApiKey;
  final String idStateContract;
  final String pushUrl;
  final String ipfsUrl;

  final String? stacktraceEncryptionKey;
  final String? pinataGateway;
  final String? pinataGatewayToken;

  EnvDTO({
    required this.blockchain,
    required this.network,
    required this.web3Url,
    required this.web3RdpUrl,
    required this.web3ApiKey,
    required this.idStateContract,
    required this.pushUrl,
    required this.ipfsUrl,
    required this.stacktraceEncryptionKey,
    required this.pinataGateway,
    required this.pinataGatewayToken,
  });

  factory EnvDTO.fromJson(Map<String, dynamic> json) => _$EnvDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EnvDTOToJson(this);

  @override
  List<Object?> get props => [
        blockchain,
        network,
        web3Url,
        web3RdpUrl,
        web3ApiKey,
        idStateContract,
        pushUrl,
        ipfsUrl,
        stacktraceEncryptionKey,
        pinataGateway,
        pinataGatewayToken,
      ];
}
