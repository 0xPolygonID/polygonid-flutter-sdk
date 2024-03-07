import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/did_method_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';

class ConfigParam {
  final String ipfsNodeURL;
  final Map<String, ChainConfigEntity> chainConfigs;
  final List<DidMethodEntity> didMethods;

  ConfigParam({
    required this.ipfsNodeURL,
    this.chainConfigs = const {},
    this.didMethods = const [],
  });

  Map<String, dynamic> toJson() => {
        "IPFSNodeURL": ipfsNodeURL,
        "chainConfigs":
            chainConfigs.map((key, value) => MapEntry(key, value.toJson())),
        "didMethods": didMethods.map((value) => value.toJson()).toList(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  String toJsonString() => jsonEncode(toJson());

  factory ConfigParam.fromJson(Map<String, dynamic> json) {
    return ConfigParam(
      ipfsNodeURL: json['IPFSNodeURL'],
      chainConfigs: (json['chainConfigs'] as Map<dynamic, dynamic>).map(
          (key, value) => MapEntry(key, ChainConfigEntity.fromJson(value))),
      didMethods: (json['didMethods'] as List<dynamic>)
          .map((value) => DidMethodEntity.fromJson(value))
          .toList(),
    );
  }
}
