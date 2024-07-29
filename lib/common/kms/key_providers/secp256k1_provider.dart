import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:polygonid_flutter_sdk/common/kms/kms.dart';
import 'package:polygonid_flutter_sdk/common/kms/provider-helpers.dart';
import 'package:polygonid_flutter_sdk/common/kms/store/abstract_key_store.dart';
import 'package:polygonid_flutter_sdk/common/kms/store/types.dart';
import 'package:web3dart/crypto.dart';
import 'package:secp256k1/secp256k1.dart' as secp256k1;

/// Provider for Secp256k1
/// @public
/// @class Secp256k1Provider
/// @implements implements IKeyProvider interface
class Sec256k1Provider implements IKeyProvider {
  /// key type that is handled by BJJ Provider
  /// @type {KmsKeyType}
  final KmsKeyType keyType;
  final AbstractPrivateKeyStore _keyStore;

  /// Creates an instance of Sec256k1Provider.
  /// @param {KmsKeyType} keyType - kms key type
  /// @param {AbstractPrivateKeyStore} keyStore - key store for kms
  Sec256k1Provider(this.keyType, this._keyStore) {
    if (keyType != KmsKeyType.Secp256k1) {
      throw Exception('Key type must be Secp256k1');
    }
  }

  /// generates a baby jub jub key from a seed phrase
  /// @param {Uint8List} seed - byte array seed
  /// @returns kms key identifier
  @override
  Future<KmsKeyId> newPrivateKeyFromSeed(Uint8List seed) async {
    if (seed.length != 32) {
      throw Exception('Seed should be 32 bytes');
    }
    final privateKey = secp256k1.PrivateKey.fromHex(bytesToHex(seed));
    final publicKey = privateKey.publicKey;

    final kmsId = KmsKeyId(
      type: keyType,
      id: keyPath(keyType, publicKey.toHex()),
    );

    await _keyStore.importKey(
      alias: kmsId.id,
      key: bytesToHex(seed).padLeft(64, '0'),
    );

    return kmsId;
  }

  /// Gets public key by kmsKeyId
  ///
  /// @param {KmsKeyId} keyId - key identifier
  @override
  Future<String> publicKey(KmsKeyId keyId) async {
    final privateKeyHex = await _privateKey(keyId);
    final privateKey = secp256k1.PrivateKey.fromHex(privateKeyHex);
    final publicKey = privateKey.publicKey;
    return publicKey.toHex(); // 04 + x + y (uncompressed key)
  }

  /// Signs the given data using the private key associated with the specified key identifier.
  /// @param keyId - The key identifier to use for signing.
  /// @param data - The data to sign.
  /// @param opts - Signing options, such as the algorithm to use.
  /// @returns A Future that resolves to the signature as a Uint8List.
  @override
  Future<Uint8List> sign(
    KmsKeyId keyId,
    Uint8List data, [
    Map<String, dynamic>? opts,
  ]) async {
    final privateKeyHex = await _privateKey(keyId);
    final privateKey = secp256k1.PrivateKey.fromHex(privateKeyHex);

    final signature = privateKey.signature(bytesToHex(data));

    final signatureBytes = Uint8List(64);
    final rBytes = hexToBytes(signature.R.toRadixString(16).padLeft(32, '0'));
    signatureBytes.setRange(0, 32, rBytes);
    final sBytes = hexToBytes(signature.S.toRadixString(16).padLeft(32, '0'));
    signatureBytes.setRange(32, 64, sBytes);

    // final signatureBase64 = await ES256KSigner(
    //     hexToBytes(privateKeyHex), opts?["alg"] == 'ES256K-R')(data);
    //
    // if (signatureBase64.runtimeType != String) {
    //   throw Exception('signatureBase64 must be a String');
    // }

    return signatureBytes;
  }

  /// Verifies a signature for the given message and key identifier.
  /// @param message - The message to verify the signature against.
  /// @param signatureHex - The signature to verify, as a hexadecimal String.
  /// @param keyId - The key identifier to use for verification.
  /// @returns A Future that resolves to a boolean indicating whether the signature is valid.
  @override
  Future<bool> verify(
    Uint8List message,
    String signatureHex,
    KmsKeyId keyId,
  ) async {
    final publicKeyHex = await this.publicKey(keyId);

    final publicKey = secp256k1.PublicKey.fromHex(publicKeyHex);

    final signature = secp256k1.Signature.fromHexes(
      signatureHex.substring(0, signatureHex.length ~/ 2),
      signatureHex.substring(signatureHex.length ~/ 2, signatureHex.length),
    );

    return signature.verify(
      publicKey,
      bytesToHex(message),
    );
  }

  Future<String> _privateKey(KmsKeyId keyId) async {
    return _keyStore.get(alias: keyId.id);
  }
}
