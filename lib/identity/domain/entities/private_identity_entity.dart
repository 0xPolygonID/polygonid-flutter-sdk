import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;

  const PrivateIdentityEntity({
    required String identifier,
    required List<String> publicKey,
    required this.privateKey,
  }) : super(identifier: identifier, publicKey: publicKey);

  @override
  String toString() =>
      "[PrivateIdentityEntity] {identifier: $identifier, publicKey: $publicKey, privateKey: $privateKey}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateIdentityEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
