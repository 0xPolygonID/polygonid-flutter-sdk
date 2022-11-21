/// Represents an identity.
class IdentityEntity {
  final String identifier;
  final List<String> publicKey;

  const IdentityEntity({
    required this.identifier,
    required this.publicKey,
  });

  @override
  String toString() =>
      "[IdentityEntity] {identifier: $identifier, publicKey: $publicKey}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          publicKey == other.publicKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
