import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/common/kms/key_providers/ed25519_provider.dart';
import 'package:polygonid_flutter_sdk/common/kms/keys/public_key.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';

/// Represents an identity DTO.
class IdentityEntity {
  final String did;

  /// BJJ public key
  final List<String> publicKey;
  final IdentityType type;

  // nonce to DID
  final Map<BigInt, String> profiles;

  const IdentityEntity({
    required this.did,
    required this.publicKey,
    required this.type,
    required this.profiles,
  });

  factory IdentityEntity.fromJson(Map<String, dynamic> json) {
    final IdentityType type;
    if (json.containsKey('type')) {
      type = IdentityType.fromJson(json['type']);
    } else {
      type = IdentityType.bjj;
    }

    final Map<BigInt, String> profiles = Map.fromEntries(
      json['profiles'].map((k, v) => MapEntry(BigInt.parse(k), v)),
    );

    return IdentityEntity(
      did: json['did'],
      publicKey: json['publicKey'].map<String>((e) => e as String).toList(),
      type: type,
      profiles: profiles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'did': did,
      'publicKey': publicKey,
      'type': type.toJson(),
      'profiles': profiles.map((k, e) => MapEntry(k.toString(), e)),
    };
  }

  @override
  List<Object?> get props => [
        did,
        publicKey,
        type,
        profiles,
      ];
}

enum IdentityType {
  bjj,
  ethereum;

  static IdentityType fromJson(String json) {
    switch (json) {
      case 'bjj':
        return IdentityType.bjj;
      case 'ethereum':
        return IdentityType.ethereum;
      default:
        throw Exception("Unknown identity type $json");
    }
  }

  String toJson() {
    switch (this) {
      case IdentityType.bjj:
        return 'bjj';
      case IdentityType.ethereum:
        return 'ethereum';
    }
  }
}
