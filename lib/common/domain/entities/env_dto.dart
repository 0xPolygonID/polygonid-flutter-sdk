import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'env_dto.g.dart';

@JsonSerializable()
class EnvDTO extends Equatable {
  final String blockchain;
  final String network;
  final String url;
  final String rdpUrl;
  final String rhsUrl;
  final String apiKey;
  final String idStateContract;

  EnvDTO({
    required this.blockchain,
    required this.network,
    required this.url,
    required this.rdpUrl,
    required this.rhsUrl,
    required this.apiKey,
    required this.idStateContract,
  });

  factory EnvDTO.fromJson(Map<String, dynamic> json) => _$EnvDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EnvDTOToJson(this);

  @override
  List<Object?> get props => [
        blockchain,
        network,
        url,
        rdpUrl,
        rhsUrl,
        apiKey,
        idStateContract,
      ];
}
