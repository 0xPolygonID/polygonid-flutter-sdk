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
      "[PrivateIdentityEntity] {privateKey: $privateKey, ${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateIdentityEntity &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey &&
          super == other;

  @override
  int get hashCode => runtimeType.hashCode;
}
