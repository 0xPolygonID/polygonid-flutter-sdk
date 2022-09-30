enum ClaimState { active, expired, pending, revoked }

class ClaimEntity {
  final String id;
  final String issuer;
  final String identifier;
  final ClaimState state;
  final String? expiration;
  final Map<String, dynamic>? schema;
  final Map<String, dynamic>? vocab;
  final String type;
  final Map<String, dynamic> credential;

  ClaimEntity(
      {required this.id,
      required this.issuer,
      required this.identifier,
      required this.state,
      this.expiration,
      this.schema,
      this.vocab,
      required this.type,
      required this.credential});

  @override
  String toString() => "[ClaimEntity] {id: $id, "
      "issuer: $issuer, identifier: $identifier, state: $state, "
      "expiration: $expiration, schema: $schema, vocab: $vocab, type: $type, credential: $credential}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClaimEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          issuer == other.issuer &&
          identifier == other.identifier &&
          state == other.state &&
          expiration == other.expiration &&
          schema == other.schema &&
          vocab == other.vocab &&
          type == other.type &&
          credential.toString() == other.credential.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
