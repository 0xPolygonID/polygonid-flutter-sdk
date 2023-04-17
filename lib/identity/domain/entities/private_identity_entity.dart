import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;

  const PrivateIdentityEntity({
    required String did,
    required List<String> publicKey,
    required Map<BigInt, String> profiles,
    required this.privateKey,
  }) : super(did: did, publicKey: publicKey, profiles: profiles);

  factory PrivateIdentityEntity.fromJson(Map<String, dynamic> json) {
    return PrivateIdentityEntity(
      did: json['did'],
      publicKey: List<String>.from(json['publicKey']),
      profiles: Map<int, String>.from(json['profiles']),
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
