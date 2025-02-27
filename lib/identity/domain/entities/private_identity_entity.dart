import 'identity_entity.dart';

/// Represents a private identity.
class PrivateIdentityEntity extends IdentityEntity {
  final String privateKey;

  const PrivateIdentityEntity({
    required super.did,
    required super.publicKey,
    required super.profiles,
    required this.privateKey,
  });

  factory PrivateIdentityEntity.fromJson(Map<String, dynamic> json) {
    return PrivateIdentityEntity(
      did: json['did'],
      publicKey: List<String>.from(json['publicKey']),
      profiles: json['profiles']
          .map((key, value) => MapEntry(BigInt.parse(key), value)),
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
