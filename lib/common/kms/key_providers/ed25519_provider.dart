import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/kms/kms.dart';
import 'package:polygonid_flutter_sdk/common/kms/provider-helpers.dart';
import 'package:polygonid_flutter_sdk/common/kms/store/abstract_key_store.dart';
import 'package:polygonid_flutter_sdk/common/kms/store/types.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;

/// Provider for Ed25519 keys
/// @public
/// @class Ed25519Provider
/// @implements IKeyProvider interface
class Ed25519Provider implements IKeyProvider {
  final KmsKeyType keyType;
  final AbstractPrivateKeyStore _keyStore;

  /// Creates an instance of Ed25519Provider.
  /// @param {KmsKeyType} keyType - kms key type
  /// @param {AbstractPrivateKeyStore} keyStore - key store for kms
  Ed25519Provider(this.keyType, this._keyStore);

  /// generates a ed25519 key from a seed phrase
  /// @param {Uint8List} seed - byte array seed
  /// @returns {Future<KmsKeyId>} kms key identifier
  @override
  Future<KmsKeyId> newPrivateKeyFromSeed(Uint8List seed) async {
    if (seed.length != 32) {
      throw Exception('Seed should be 32 bytes');
    }
    final publicKey = ed25519.PublicKey(seed);
    final kmsId = KmsKeyId(
      type: keyType,
      id: keyPath(keyType, bytesToHex(publicKey.bytes)),
    );

    await _keyStore.importKey(
      alias: kmsId.id,
      key: bytesToHex(seed),
    );

    return kmsId;
  }

  /// Gets public key by kmsKeyId
  /// @param {KmsKeyId} keyId - key identifier
  /// @returns {Future<String>} Public key as a hex String
  @override
  Future<String> publicKey(KmsKeyId keyId) async {
    final privateKeyHex = await _privateKey(keyId);
    final privateKey = ed25519.newKeyFromSeed(hexToBytes(privateKeyHex));
    final publicKey = ed25519.public(privateKey);
    return bytesToHex(publicKey.bytes);
  }

  /// signs prepared payload of size,
  /// with a key id
  /// @param {KmsKeyId} keyId  - key identifier
  /// @param {Uint8List} digest - data to sign (32 bytes)
  /// @returns {Future<Uint8List>} signature
  @override
  Future<Uint8List> sign(
    KmsKeyId keyId,
    Uint8List digest, [
    Map<String, dynamic>? opts,
  ]) async {
    final privateKeyHex = await _privateKey(keyId);
    final privateKey = ed25519.newKeyFromSeed(hexToBytes(privateKeyHex));

    return ed25519.sign(privateKey, digest);
  }

  /// Verifies a signature for the given message and key identifier.
  /// @param digest - The message to verify the signature against.
  /// @param signatureHex - The signature to verify, as a hexadecimal String.
  /// @param keyId - The key identifier to use for verification.
  /// @returns A Future that resolves to a boolean indicating whether the signature is valid.
  Future<bool> verify(
      Uint8List digest, String signatureHex, KmsKeyId keyId) async {
    final publicKeyHex = await this.publicKey(keyId);
    final publicKey = ed25519.PublicKey(hexToBytes(publicKeyHex));

    return ed25519.verify(
      publicKey,
      digest,
      hexToBytes(signatureHex),
    );
  }

  /// Retrieves the private key for a given keyId from the key store.
  /// @param {KmsKeyId} keyId - The identifier of the key to retrieve.
  /// @returns {Future<String>} The private key associated with the keyId.
  Future<String> _privateKey(KmsKeyId keyId) async {
    return _keyStore.get(alias: keyId.id);
  }
}
