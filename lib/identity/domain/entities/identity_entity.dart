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

  factory IdentityEntity.fromJson(Map<String, dynamic> json) {
    return IdentityEntity(
      did: json['did'],
      publicKey: List<String>.from(json['publicKey']),
      profiles: Map<int, String>.from(json['profiles']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'did': did,
        'publicKey': publicKey,
        'profiles': profiles,
      };

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
