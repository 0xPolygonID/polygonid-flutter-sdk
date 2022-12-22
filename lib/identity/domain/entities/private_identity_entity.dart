import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;

  const PrivateIdentityEntity({
    required String did,
    required List<String> publicKey,
    required Map<int, String> profiles,
    required this.privateKey,
  }) : super(did: did, publicKey: publicKey, profiles: profiles);

  @override
  String toString() =>
      "[PrivateIdentityEntity] {did: $did, publicKey: $publicKey, profiles: $profiles, privateKey: $privateKey}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateIdentityEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          publicKey == other.publicKey &&
          profiles == other.profiles &&
          privateKey == other.privateKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
