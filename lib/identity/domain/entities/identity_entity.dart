/// Represents an identity.
class IdentityEntity {
  final String did;
  final List<String> publicKey;
  final List<int>? profiles;

  const IdentityEntity({
    required this.did,
    required this.publicKey,
    this.profiles,
  });

  @override
  String toString() =>
      "[IdentityEntity] {did: $did, publicKey: $publicKey, profiles: $profiles}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          publicKey == other.publicKey &&
          profiles == other.profiles;

  @override
  int get hashCode => runtimeType.hashCode;
}
