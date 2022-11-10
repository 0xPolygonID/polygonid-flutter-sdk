import 'identity_entity.dart';

/// Represents an private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;
  final String authClaim;

  const PrivateIdentityEntity({
    required String identifier,
    required List<String> publicKey,
    required String state,
    required this.privateKey,
    required this.authClaim,
  }) : super(identifier: identifier, publicKey: publicKey, state: state);

  @override
  String toString() =>
      "[PrivateIdentityEntity] {identifier: $identifier, publicKey: $publicKey, state: $state, privateKey: $privateKey, authClaim: $authClaim}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateIdentityEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          state == other.state &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey &&
          authClaim == other.authClaim;

  @override
  int get hashCode => runtimeType.hashCode;
}
