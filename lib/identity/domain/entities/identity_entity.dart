import 'package:flutter/foundation.dart';

/// Represents an identity.
class IdentityEntity {
  final String did;
  final List<String> publicKey;
  final Map<BigInt, String> profiles;

  const IdentityEntity({
    required this.did,
    required this.publicKey,
    required this.profiles,
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
          listEquals(publicKey, other.publicKey) &&
          mapEquals(profiles, other.profiles);

  @override
  int get hashCode => runtimeType.hashCode;
}
