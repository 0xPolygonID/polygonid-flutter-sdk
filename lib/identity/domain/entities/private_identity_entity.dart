import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;
  //final Map<int, String> profiles;

  const PrivateIdentityEntity({
    required String did,
    required List<String> publicKey,
    required this.privateKey,
  }) : super(did: did, publicKey: publicKey);

  @override
  String toString() =>
      "[PrivateIdentityEntity] {did: $did, publicKey: $publicKey, privateKey: $privateKey}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateIdentityEntity &&
          runtimeType == other.runtimeType &&
          did == other.did &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
