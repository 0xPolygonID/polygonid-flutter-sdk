import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'claim_info_dto.dart';

class ClaimDTO extends Equatable {
  final String id;
  final String issuer;
  final String did;
  final String state;
  final String? expiration;
  Map<String, dynamic>? schema;
  final String type;
  final ClaimInfoDTO info;
  Map<String, dynamic>? displayType;

  final String credentialRawValue;

  ClaimDTO({
    required this.id,
    required this.issuer,
    required this.did,
    required this.type,
    this.state = '',
    this.expiration,
    required this.info,
    this.schema,
    this.displayType,
    required this.credentialRawValue,
  });

  factory ClaimDTO.fromJson(Map<String, dynamic> json) {
    return ClaimDTO(
      id: json['id'] as String,
      issuer: json['issuer'] as String,
      did: json['did'] as String,
      type: json['type'] as String,
      state: json['state'] as String? ?? '',
      expiration: json['expiration'] as String?,
      info: ClaimInfoDTO.fromJson(json['credential'] as Map<String, dynamic>),
      schema: json['schema'] as Map<String, dynamic>?,
      displayType: json['displayType'] as Map<String, dynamic>?,
      credentialRawValue: json['credentialRawValue'] ?? jsonEncode(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'issuer': issuer,
      'did': did,
      'state': state,
      'credential': info.toJson(),
      'expiration': expiration,
      'type': type,
      'schema': schema,
      'displayType': displayType,
      'credentialRawValue': credentialRawValue,
    };
  }

  @override
  List<Object?> get props => [
        id,
        issuer,
        did,
        state,
        info,
        expiration,
        type,
        schema,
        displayType,
        credentialRawValue
      ];

  @override
  String toString() {
    return 'ClaimDTO{id: $id, issuer: $issuer, did: $did, state: $state, info: $info, expiration: $expiration, type: $type, schema: $schema, displayType: $displayType, credentialRawValue: $credentialRawValue}';
  }
}
