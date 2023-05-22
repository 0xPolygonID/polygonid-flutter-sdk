enum ClaimState { active, expired, pending, revoked }

class ClaimEntity {
  final String id;
  final String issuer;
  final String did;
  final ClaimState state;
  final String? expiration;
  final Map<String, dynamic>? schema;
  final String type;
  final Map<String, dynamic> info;

  ClaimEntity(
      {required this.id,
      required this.issuer,
      required this.did,
      required this.state,
      this.expiration,
      this.schema,
      required this.type,
      required this.info});

  factory ClaimEntity.fromJson(Map<String, dynamic> json) {
    return ClaimEntity(
      id: json['id'],
      issuer: json['issuer'],
      did: json['did'],
      state: ClaimState.values.firstWhere((e) => e.name == json['state']),
      expiration: json['expiration'],
      schema: json['schema'],
      type: json['type'],
      info: json['info'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'issuer': issuer,
        'did': did,
        'state': state.name,
        'expiration': expiration,
        'schema': schema,
        'type': type,
        'info': info,
      };

  @override
  String toString() => "[ClaimEntity] {id: $id, "
      "issuer: $issuer, did: $did, state: $state, "
      "expiration: $expiration, schema: $schema, type: $type, info: $info}";

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
          schema == other.schema &&
          type == other.type &&
          info.toString() == other.info.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
