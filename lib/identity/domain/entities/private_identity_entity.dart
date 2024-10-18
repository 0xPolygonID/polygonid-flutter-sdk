import 'package:polygonid_flutter_sdk/common/kms/key_providers/ed25519_provider.dart';
import 'package:polygonid_flutter_sdk/common/kms/keys/private_key.dart';
import 'package:polygonid_flutter_sdk/common/kms/keys/public_key.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/eddsa_babyjub.dart';

import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;

  const PrivateIdentityEntity({
    required super.did,
    required super.publicKey,
    required super.type,
    required super.profiles,
    required this.privateKey,
  });

  factory PrivateIdentityEntity.fromJson(Map<String, dynamic> json) {
    final identity = IdentityEntity.fromJson(json);

    return PrivateIdentityEntity(
      did: identity.did,
      publicKey: identity.publicKey,
      type: identity.type,
      profiles: identity.profiles,
      privateKey: json['privateKey'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = super.toJson();
    result['privateKey'] = privateKey;

    return result;
  }

  @override
  String toString() =>
      "[PrivateIdentityEntity] {privateKey: $privateKey, ${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is PrivateIdentityEntity &&
      privateKey == other.privateKey;

  @override
  int get hashCode => runtimeType.hashCode;
}
