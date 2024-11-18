import "dart:typed_data";

import "package:encrypt/encrypt.dart";
import "package:polygonid_flutter_sdk/common/kms/index.dart";
import "package:polygonid_flutter_sdk/common/utils/big_int_extension.dart";
import "package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart";
import "package:web3dart/crypto.dart";

import "../../../identity/libs/bjj/eddsa_babyjub.dart";

/// Provider for Baby Jub Jub keys
/// @public
/// @class BjjProvider
/// @implements implements IKeyProvider interface
class BjjProvider implements IKeyProvider {
  /// key type that is handled by BJJ Provider
  /// @type {KmsKeyType}
  KmsKeyType get keyType => KmsKeyType.BabyJubJub;

  AbstractPrivateKeyStore keyStore;

  /// Creates an instance of BjjProvider.
  /// @param {KmsKeyType} keyType - kms key type
  /// @param {AbstractPrivateKeyStore} keyStore - key store for kms
  BjjProvider(KmsKeyType keyType, this.keyStore) {
    if (keyType != KmsKeyType.BabyJubJub) {
      throw Exception('Key type must be BabyJubJub');
    }
  }

  /// generates a baby jub jub key from a seed phrase
  /// @param {Uint8List} seed - byte array seed
  /// @returns kms key identifier
  @override
  Future<KmsKeyId> newPrivateKeyFromSeed(Uint8List seed) async {
    final privateKey = PrivateKey(seed);

    final publicKey = privateKey.public();

    final kmsId = KmsKeyId(
      type: keyType,
      id: keyPath(keyType, publicKey.hex),
    );
    await keyStore.importKey(alias: kmsId.id, key: privateKey.hex());

    return kmsId;
  }

  /// Gets public key by kmsKeyId
  ///
  /// @param {KmsKeyId} keyId - key identifier
  @override
  Future<String> publicKey(KmsKeyId keyId) async {
    final privateKey = await _privateKey(keyId);
    return privateKey.public().hex;
  }

  /// signs prepared payload of size,
  /// with a key id
  ///
  /// @param {KmsKeyId} keyId  - key identifier
  /// @param {Uint8List} data - data to sign (32 bytes)
  /// @returns Uint8List signature
  @override
  Future<Uint8List> sign(
    KmsKeyId keyId,
    Uint8List data, [
    Map<String, dynamic>? opts,
  ]) async {
    if (data.length != 32) {
      throw Exception('data to sign is too large');
    }

    final i = bytesToUnsignedInt(data);
    if (!i.checkBigIntInField()) {
      throw Exception('data to sign is too large');
    }
    final privateKey = await _privateKey(keyId);

    final signature = privateKey.sign(i);

    return Uint8ArrayUtils.uint8ListfromString(signature);
  }

  @override
  Future<bool> verify(
      Uint8List message, String signatureHex, KmsKeyId keyId) async {
    final publicKey = await this.publicKey(keyId);

    final pbkey = PublicKey.hex(publicKey);

    return pbkey.verify(
      Uint8ArrayUtils.uint8ListToString(message),
      Signature.newFromCompressed(hexToBytes(signatureHex)),
    );
  }

  Future<PrivateKey> _privateKey(KmsKeyId keyId) async {
    final privateKeyHex = await keyStore.get(alias: keyId.id);

    return PrivateKey(decodeHexString(privateKeyHex));
  }
}
