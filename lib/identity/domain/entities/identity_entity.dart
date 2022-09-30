/// Represents an identity.
class IdentityEntity {
  final String privateKey;
  final String identifier;
  final String authClaim;
  final String smt;

  const IdentityEntity(
      {required this.privateKey,
      required this.identifier,
      required this.authClaim,
      required this.smt});

  @override
  String toString() =>
      "[IdentityEntity] {privateKey: $privateKey, identifier: $identifier, authClaim: $authClaim, smt: $smt}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityEntity &&
          runtimeType == other.runtimeType &&
          privateKey == other.privateKey &&
          identifier == other.identifier &&
          authClaim == other.authClaim &&
          smt == other.smt;

  @override
  int get hashCode => runtimeType.hashCode;
}
