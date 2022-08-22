import 'dart:typed_data';

import 'package:hex/hex.dart';

import '../../../common/utils/hex_utils.dart';
import '../../../common/utils/uint8_list_utils.dart';
import 'bjj.dart';

/// Class representing EdDSA Baby Jub signature
class Signature {
  late List<BigInt> r8;
  late BigInt s;

  /// Create a Signature with the R8 point and S scalar
  /// @param {List[BigInt]} r8 - R8 point
  /// @param {BigInt} s - BigInt
  Signature(this.r8, this.s);

  /// Create a Signature from a compressed Signature Buffer
  /// @param {Uint8List} buf - Buffer containing a signature
  /// @returns {Signature} Object signature
  static Signature newFromCompressed(Uint8List buf) {
    if (buf.length != 64) {
      throw ArgumentError('buf must be 64 bytes');
    }
    BabyjubjubLib bjjLib = BabyjubjubLib();

    final XYSublist = buf.sublist(0, 32);
    // unpackPoint is used to unpack R8 X and Y
    final List<String>? unpackedPoint =
        bjjLib.unpackPoint(HEX.encode(XYSublist.toList()));

    BigInt? x = BigInt.tryParse(unpackedPoint![0], radix: 10);
    BigInt? y = BigInt.tryParse(unpackedPoint[1], radix: 10);
    List<BigInt> r8 = [];
    r8.add(x!);
    r8.add(y!);

    // S is decoded manually
    BigInt s = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(buf.sublist(32, 64).reversed.toList()));
    return Signature(r8, s);
  }
}

/// Class representing a EdDSA Baby Jub public key
class PublicKey {
  late List<BigInt> p;

  /// Create a PublicKey from a curve point p
  /// @param {List[BigInt]} p - curve point
  PublicKey(this.p);

  /// Create a PublicKey from a bigInt compressed pubKey
  ///
  /// @param {BigInt} compressedBigInt - compressed public key in a bigInt
  ///
  /// @returns {PublicKey} public key class
  static PublicKey newFromCompressed(BigInt compressedBigInt) {
    final Uint8List compressedBuffLE =
        Uint8ArrayUtils.leInt2Buff(compressedBigInt, 32);
    if (compressedBuffLE.length != 32) {
      throw ArgumentError('buf must be 32 bytes');
    }
    BabyjubjubLib bjjLib = BabyjubjubLib();
    final p =
        bjjLib.unpackPoint(Uint8ArrayUtils.uint8ListToString(compressedBuffLE));
    if (p == null) {
      throw ArgumentError('unpackPoint failed');
    }
    BigInt x = BigInt.parse(p[0]);
    BigInt y = BigInt.parse(p[1]);
    List<BigInt> point = [];
    point.add(x);
    point.add(y);
    return PublicKey(point);
  }

  /// Compress the PublicKey
  /// @returns {Uint8List} - point compressed into a buffer
  Uint8List compress() {
    BabyjubjubLib bjjLib = BabyjubjubLib();
    return HexUtils.hexToBytes(
        bjjLib.packPoint(p[0].toString(), p[1].toString()));
  }

  bool verify(String messageHash, Signature signature) {
    BabyjubjubLib bjjLib = BabyjubjubLib();
    List<int> pointList = [];
    pointList.add(p[0].toInt());
    pointList.add(p[1].toInt());
    List<int> sigList = [];
    sigList.add(signature.r8[0].toInt());
    sigList.add(signature.r8[1].toInt());
    sigList.add(signature.s.toInt());
    return bjjLib.verifyPoseidon(
        Uint8ArrayUtils.uint8ListToString(Uint8List.fromList(pointList)),
        Uint8ArrayUtils.uint8ListToString(Uint8List.fromList(sigList)),
        messageHash);
  }
}

/// Class representing EdDSA Baby Jub private key
class PrivateKey {
  late Uint8List sk;

  /// Create a PrivateKey from a 32 byte Buffer
  /// @param {Uint8List} buf - private key
  PrivateKey(Uint8List buf) {
    if (buf.length != 32) {
      throw ArgumentError('buf must be 32 bytes');
    }
    sk = buf;
  }

  /// Retrieve PublicKey of the PrivateKey
  /// @returns {PublicKey} PublicKey derived from PrivateKey
  PublicKey public() {
    BabyjubjubLib bjjLib = BabyjubjubLib();
    String resultString = bjjLib.prv2pub(HexUtils.bytesToHex(sk));
    final stringList = resultString.split(",");
    stringList[0] = stringList[0].replaceAll("Fr(", "");
    stringList[0] = stringList[0].replaceAll(")", "");
    stringList[1] = stringList[1].replaceAll("Fr(", "");
    stringList[1] = stringList[1].replaceAll(")", "");
    BigInt x = HexUtils.hexToInt(stringList[0]);
    BigInt y = HexUtils.hexToInt(stringList[1]);
    List<BigInt> p = [];
    p.add(x);
    p.add(y);
    return PublicKey(p);
  }

  String sign(BigInt messageHash) {
    BabyjubjubLib bjjLib = BabyjubjubLib();
    String signature =
        bjjLib.signPoseidon(HexUtils.bytesToHex(sk), messageHash.toString());
    return signature;
  }
}

String packSignature(Uint8List signature) {
  BabyjubjubLib bjjLib = BabyjubjubLib();
  final sigString = Uint8ArrayUtils.uint8ListToString(signature);
  return bjjLib.packSignature(sigString);
}

String hashPoseidon(
    String claimsTreeRoot, String revocationTree, String rootsTreeRoot) {
  BabyjubjubLib bjjLib = BabyjubjubLib();
  return bjjLib.hashPoseidon(claimsTreeRoot, revocationTree, rootsTreeRoot);
}
