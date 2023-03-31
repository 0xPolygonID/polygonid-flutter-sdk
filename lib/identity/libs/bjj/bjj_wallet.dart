import 'dart:math';
import 'dart:typed_data';

import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/common/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';

import 'eddsa_babyjub.dart' as eddsaBabyJub;
import 'package:bip32/bip32.dart' as bip32;

// TODO: move impl to a DS and transform this class to an entity
/// @class
/// Manage Babyjubjub keys
/// Perform standard wallet actions
class BjjWallet {
  late Uint8List privateKey;
  late List<String> publicKey;
  dynamic publicKeyHex;
  String? publicKeyCompressed;
  String? publicKeyCompressedHex;
  String? publicKeyBase64;

  /// Initialize Babyjubjub wallet from private key
  ///
  /// @param [Uint8List] privateKey - 32 bytes buffer
  BjjWallet(this.privateKey) {
    if (privateKey.length != 32) {
      throw ArgumentError('buf must be 32 bytes');
    }

    final priv = eddsaBabyJub.PrivateKey(privateKey);
    final eddsaBabyJub.PublicKey publicKey = priv.public();
    this.publicKey = [publicKey.p[0].toString(), publicKey.p[1].toString()];
    publicKeyHex = [
      publicKey.p[0].toRadixString(16).padLeft(64, '0'),
      publicKey.p[1].toRadixString(16).padLeft(64, '0')
    ];
    final compressedPublicKey =
        Uint8ArrayUtils.leBuff2int(publicKey.compress());
    publicKeyCompressed = compressedPublicKey.toString();
    publicKeyCompressedHex =
        compressedPublicKey.toRadixString(16).padLeft(64, '0');
    publicKeyBase64 = HexUtils.hexToBase64BJJ(publicKeyCompressedHex!);
  }

  /// Creates a BjjWallet
  ///
  /// This creates a wallet
  /// Random wallet is created if no private key is provided
  ///
  /// @param [Uint8List] secret - 32 bytes buffer
  /// @returns [PrivadoIdWallet] privadoIdWallet - PrivadoIdWallet instance
  static Future<BjjWallet> createBjjWallet({Uint8List? secret}) async {
    EthPrivateKey prvKey;
    if (secret == null) {
      prvKey = EthPrivateKey.createRandom(Random.secure());
    } else {
      prvKey = EthPrivateKey(secret);
    }
    // Convert the master private key to a BIP32 instance
    final master = bip32.BIP32.fromBase58(Base58Encode(prvKey.privateKey));

    // Derive the path m/44'/60'/0'/0
    const path = "m/44'/60'/0'/0";
    final child = master.derivePath(path);

    // Get the private key
    final privateBjjKey = child.privateKey;

    final bjjWallet = BjjWallet(privateBjjKey!);
    return bjjWallet;
  }

  /// Hash message with poseidon
  /// @param [String] messageStr - message to hash
  /// @returns [String] - hash poseidon
  String hashMessage(
      String claimsTreeRoot, String revocationTree, String rootsTreeRoot) {
    final hash = eddsaBabyJub.hashPoseidon(
        claimsTreeRoot, revocationTree, rootsTreeRoot);
    return hash;
  }
}
