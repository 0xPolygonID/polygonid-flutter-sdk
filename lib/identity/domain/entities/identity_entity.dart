/// Represents an identity.
class IdentityEntity {
  final String did;
  final List<String> publicKey;

  const IdentityEntity({
    required this.did,
    required this.publicKey,
  });

  @override
  String toString() => "[IdentityEntity] {did: $did, publicKey: $publicKey}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          publicKey == other.publicKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
