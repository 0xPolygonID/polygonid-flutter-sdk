/// Represents an identity.
class IdentityEntity {
  final String identifier;
  final List<String> publicKey;
  final String state;

  const IdentityEntity({
    required this.identifier,
    required this.publicKey,
    required this.state,
  });

  @override
  String toString() =>
      "[IdentityEntity] {identifier: $identifier, publicKey: $publicKey, state: $state}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          publicKey == other.publicKey &&
          state == other.state;

  @override
  int get hashCode => runtimeType.hashCode;
}
