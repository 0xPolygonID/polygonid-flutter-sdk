import 'dart:typed_data';

import 'package:privadoid_sdk/utils/hex_utils.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

import 'libs/circomlib.dart';
import 'utils/structs.dart' as structs;

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
    CircomLib circomLib = CircomLib();
    final signature =
        circomLib.unpackSignature(Uint8ArrayUtils.uint8ListToString(buf));
    final bufSignature = Uint8ArrayUtils.uint8ListfromString(signature);
    final xList = bufSignature.sublist(0, 16);
    final yList = bufSignature.sublist(16, 32);
    final rSList = bufSignature.sublist(32, 64);
    final xPtr = Uint8ArrayUtils.toPointer(xList);
    final yPtr = Uint8ArrayUtils.toPointer(yList);
    final sPtr = Uint8ArrayUtils.toPointer(rSList);
    final structs.Point point = structs.Point.allocate(xPtr, yPtr);

    final pointPtr = point.address;
    final structs.Signature sig = structs.Signature.allocate(pointPtr, sPtr);
    if (sig.r_b8 == null) {
      throw ArgumentError('unpackSignature failed');
    }
    BigInt x = Uint8ArrayUtils.leBuff2int(xList);
    BigInt y = Uint8ArrayUtils.leBuff2int(yList);
    List<BigInt> r8 = [];
    r8.add(x);
    r8.add(y);

    BigInt s =
        Uint8ArrayUtils.leBuff2int(Uint8ArrayUtils.fromPointer(sig.s!, 32));
    //calloc.free(pointPtr);
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
    CircomLib circomLib = CircomLib();
    final p = circomLib
        .unpackPoint(Uint8ArrayUtils.uint8ListToString(compressedBuffLE));
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
    CircomLib circomLib = CircomLib();
    /*Uint8List xList = Uint8ArrayUtils.bigIntToBytes(p[0]);
    Uint8List yList = Uint8ArrayUtils.bigIntToBytes(p[1]);
    List<int> pointList = xList.toList();
    pointList.addAll(yList.toList());
    BigInt result = Uint8ArrayUtils.leBuff2int(Uint8List.fromList(pointList));*/
    return HexUtils.hexToBytes(
        circomLib.packPoint(p[0].toString(), p[1].toString()));
    /*return Uint8ArrayUtils.uint8ListfromString(
        circomLib.packPoint(p[0].toString(), p[1].toString()));*/
  }

  bool verify(String messageHash, Signature signature) {
    CircomLib circomLib = CircomLib();
    List<int> pointList = [];
    pointList.add(p[0].toInt());
    pointList.add(p[1].toInt());
    List<int> sigList = [];
    sigList.add(signature.r8[0].toInt());
    sigList.add(signature.r8[1].toInt());
    sigList.add(signature.s.toInt());
    return circomLib.verifyPoseidon(
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
    CircomLib circomLib = CircomLib();
    String resultString = circomLib.prv2pub(HexUtils.bytesToHex(sk));
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
    CircomLib circomLib = CircomLib();
    String signature =
        circomLib.signPoseidon(HexUtils.bytesToHex(sk), messageHash.toString());
    return signature;
  }
}

String packSignature(Uint8List signature) {
  CircomLib circomLib = CircomLib();
  final sigString = Uint8ArrayUtils.uint8ListToString(signature);
  return circomLib.packSignature(sigString);
}

/*Point poseidon(Uint8List input) {
  final ptr = Uint8ArrayUtils.toPointer(input);
  final resultPtr = hashPoseidon(ptr);
  return resultPtr.ref;
}*/
