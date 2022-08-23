enum ClaimState { active, expired, pending, revoked }

class ClaimEntity {
  final String id;
  final String issuer;
  final String identifier;
  final ClaimState state;
  final String? expiration;
  final String type;
  final Map<String, dynamic> data;

  ClaimEntity(
      {required this.id,
      required this.issuer,
      required this.identifier,
      required this.state,
      this.expiration,
      required this.type,
      required this.data});

  @override
  String toString() => "[ClaimEntity] {id: $id, "
      "issuer: $issuer, identifier: $identifier, state: $state, "
      "expiration: $expiration, type: $type, data: $data}";

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
          type == other.type &&
          data.toString() == other.data.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
