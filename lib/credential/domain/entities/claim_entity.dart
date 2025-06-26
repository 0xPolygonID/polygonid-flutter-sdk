import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';

enum ClaimState { active, expired, pending, revoked }

class ClaimEntity {
  final String id;
  final String issuer;
  final String did;
  final ClaimState state;
  final String? expiration;
  final String? issuanceDate;
  final Map<String, dynamic>? schema;
  final String type;
  final Map<String, dynamic> info;
  final DisplayType? displayType;

  final String credentialRawValue;

  ClaimEntity({
    required this.id,
    required this.issuer,
    required this.did,
    required this.state,
    this.expiration,
    this.issuanceDate,
    this.schema,
    required this.type,
    required this.info,
    this.displayType,
    required this.credentialRawValue,
  });

  factory ClaimEntity.fromJson(Map<String, dynamic> json) {
    return ClaimEntity(
      id: json['id'],
      issuer: json['issuer'],
      did: json['did'],
      state: ClaimState.values.firstWhere((e) => e.name == json['state']),
      expiration: json['expiration'],
      issuanceDate: json['issuanceDate'],
      schema: json['schema'],
      type: json['type'],
      info: json['info'],
      displayType: json['displayType'],
      credentialRawValue: json['credentialRawValue'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'issuer': issuer,
        'did': did,
        'state': state.name,
        'expiration': expiration,
        'issuanceDate': issuanceDate,
        'schema': schema,
        'type': type,
        'info': info,
        'displayType': displayType?.toJson(),
        'credentialRawValue': credentialRawValue,
      };

  @override
  String toString() => "[ClaimEntity] {id: $id, issuer: $issuer, did: $did, "
      "state: $state, expiration: $expiration, issuanceDate: $issuanceDate, "
      "schema: $schema, type: $type, info: $info, displayType: $displayType}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClaimEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          issuer == other.issuer &&
          did == other.did &&
          state == other.state &&
          expiration == other.expiration &&
          issuanceDate == other.issuanceDate &&
          schema == other.schema &&
          type == other.type &&
          info.toString() == other.info.toString() &&
          displayType == other.displayType;

  @override
  int get hashCode => runtimeType.hashCode;

  //copyWith method
  ClaimEntity copyWith({
    String? id,
    String? issuer,
    String? did,
    ClaimState? state,
    String? expiration,
    String? issuanceDate,
    Map<String, dynamic>? schema,
    String? type,
    Map<String, dynamic>? info,
    DisplayType? displayType,
    String? credentialRawValue,
  }) {
    return ClaimEntity(
      id: id ?? this.id,
      issuer: issuer ?? this.issuer,
      did: did ?? this.did,
      state: state ?? this.state,
      expiration: expiration ?? this.expiration,
      issuanceDate: issuanceDate ?? this.issuanceDate,
      schema: schema ?? this.schema,
      type: type ?? this.type,
      info: info ?? this.info,
      displayType: displayType ?? this.displayType,
      credentialRawValue: credentialRawValue ?? this.credentialRawValue,
    );
  }
}
