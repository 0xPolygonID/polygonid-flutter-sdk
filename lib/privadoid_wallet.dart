import 'dart:typed_data';

import 'package:privadoid_sdk/utils/hex_utils.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

import 'eddsa_babyjub.dart' as eddsaBabyJub;

/// @class
/// Manage Babyjubjub keys
/// Perform standard wallet actions
class PrivadoIdWallet {
  late dynamic privateKey;
  dynamic publicKey;
  dynamic publicKeyHex;
  String? publicKeyCompressed;
  String? publicKeyCompressedHex;
  String? publicKeyBase64;

  /// Initialize Babyjubjub wallet from private key
  ///
  /// @param [Uint8List] privateKey - 32 bytes buffer
  PrivadoIdWallet(this.privateKey) {
    if (privateKey.length != 32) {
      throw ArgumentError('buf must be 32 bytes');
    }

    final priv = eddsaBabyJub.PrivateKey(privateKey);
    final eddsaBabyJub.PublicKey publicKey = priv.public();
    this.publicKey = [publicKey.p[0].toString(), publicKey.p[1].toString()];
    publicKeyHex = [
      publicKey.p[0].toRadixString(16),
      publicKey.p[1].toRadixString(16)
    ];
    final compressedPublicKey =
        Uint8ArrayUtils.leBuff2int(publicKey.compress());
    publicKeyCompressed = compressedPublicKey.toString();
    publicKeyCompressedHex =
        compressedPublicKey.toRadixString(16).padLeft(64, '0');
    publicKeyBase64 = HexUtils.hexToBase64BJJ(publicKeyCompressedHex!);
  }

  /// Creates a PrivadoIdWallet
  ///
  /// This creates a wallet
  /// Random wallet is created if no private key is provided
  ///
  /// @param [Uint8List] privateKey - 32 bytes buffer
  /// @returns [PrivadoIdWallet] privadoIdWallet - PrivadoIdWallet instance
  static Future<PrivadoIdWallet> createPrivadoIdWallet(
      Uint8List? privateKey) async {
    Uint8List privateBjjKey = privateKey ?? Uint8List(32);
    if (privateKey == null) {
      privateBjjKey.fillRange(0, 32, 1);
    }
    final privadoIdWallet = PrivadoIdWallet(privateBjjKey);
    return privadoIdWallet;
  }

  /// Signs message with private key
  /// @param [String] messageStr - message to sign
  /// @returns [String] - Babyjubjub signature packed and encoded as an hex string
  String signMessage(String messageStr) {
    final messBuff = HexUtils.hexToBuffer(messageStr);
    final messHash = HexUtils.hashBuffer(messBuff);
    final privateKey = eddsaBabyJub.PrivateKey(this.privateKey);
    final signature = privateKey.sign(messHash);
    return signature;
  }
}
