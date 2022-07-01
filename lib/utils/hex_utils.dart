import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:polygonid_flutter_sdk/utils/uint8_list_utils.dart';

class HexUtils {
  static Uint8List hexToBytes(String hexStr) {
    final bytes = HEX.decode(strip0x(hexStr));
    if (bytes is Uint8List) return bytes;

    return Uint8List.fromList(bytes);
  }

  static BigInt hexToInt(String hex) {
    return BigInt.parse(strip0x(hex), radix: 16);
  }

  static String bytesToHex(List<int> bytes,
      {bool include0x = false,
      int? forcePadLength,
      bool padToEvenLength = false}) {
    var encoded = HEX.encode(bytes);

    if (forcePadLength != null) {
      assert(forcePadLength >= encoded.length);

      final padding = forcePadLength - encoded.length;
      encoded = ('0' * padding) + encoded;
    }

    if (padToEvenLength && encoded.length % 2 != 0) {
      encoded = '0$encoded';
    }

    return (include0x ? '0x' : '') + encoded;
  }

  static String strip0x(String hex) {
    if (hex.startsWith('0x')) return hex.substring(2);
    return hex;
  }

  /// Get API bjj compressed data format
  ///
  /// @param [String] bjjCompressedHex - bjj compressed address encoded as hex string
  /// @returns [String] API adapted bjj compressed address
  static String hexToBase64BJJ(String bjjCompressedHex) {
    BigInt bjjScalar = hexToInt(bjjCompressedHex);
    Uint8List littleEndianBytes = Uint8ArrayUtils.bigIntToBytes(bjjScalar);
    String bjjSwap = bytesToHex(littleEndianBytes,
        forcePadLength: 64, padToEvenLength: false);
    Uint8List bjjSwapBuffer = hexToBytes(bjjSwap);

    var sum = 0;
    for (var i = 0; i < bjjSwapBuffer.length; i++) {
      sum += bjjSwapBuffer[i];
      sum = sum % (pow(2, 8) as int);
    }

    final BytesBuilder finalBuffBjj = BytesBuilder();
    finalBuffBjj.add(bjjSwapBuffer.toList());
    finalBuffBjj.addByte(sum);

    return 'hez:${base64Url.encode(finalBuffBjj.toBytes())}';
  }

  static Uint8List hexToBuffer(String source) {
    // Source
    print(source.length.toString() +
        ': "' +
        source +
        '" (' +
        source.runes.length.toString() +
        ')');

    // String (Dart uses UTF-16) to bytes
    List<int> list = [];
    for (var rune in source.runes) {
      if (rune >= 0x10000) {
        rune -= 0x10000;
        int firstWord = (rune >> 10) + 0xD800;
        list.add(firstWord >> 8);
        list.add(firstWord & 0xFF);
        int secondWord = (rune & 0x3FF) + 0xDC00;
        list.add(secondWord >> 8);
        list.add(secondWord & 0xFF);
      } else {
        list.add(rune >> 8);
        list.add(rune & 0xFF);
      }
    }
    Uint8List bytes = Uint8List.fromList(list);
    return bytes;
  }

  /// Converts a buffer to a hexadecimal representation
  ///
  /// @param {Uint8List} buf
  ///
  /// @returns {String}
  static String bufToHex(Uint8List buf) {
    return const Utf8Decoder().convert(buf);
  }

  /// Poseidon hash of a generic buffer
  /// @param {Uint8List} msgBuff
  /// @returns {BigInt} - final hash
  static BigInt hashBuffer(Uint8List msgBuff) {
    const n = 31;
    List<BigInt> msgArray = [];
    final fullParts = (msgBuff.length / n).floor();
    for (int i = 0; i < fullParts; i++) {
      final v = msgBuff.sublist(n * i, n * (i + 1));
      msgArray.add(Uint8ArrayUtils.bytesToBigInt(v));
    }
    if (msgBuff.length % n != 0) {
      final v = msgBuff.sublist(fullParts * n);
      msgArray.add(Uint8ArrayUtils.bytesToBigInt(v));
    }
    return multiHash(msgArray);
  }

  /// Chunks inputs in five elements and hash with Poseidon all them togheter
  /// @param {Array} arr - inputs hash
  /// @returns {BigInt} - final hash
  static BigInt multiHash(List<BigInt> arr) {
    BigInt r = BigInt.zero;
    for (int i = 0; i < arr.length; i += 5) {
      final fiveElems = [];
      for (int j = 0; j < 5; j++) {
        if (i + j < arr.length) {
          fiveElems.add(arr[i + j]);
        } else {
          fiveElems.add(BigInt.zero);
        }
      }
      //Pointer<Uint8> ptr =
      //    Uint8ArrayUtils.toPointer(Uint8List.fromList(fiveElems as List<int>));
      //final ph = eddsaBabyJub.hashPoseidon(ptr);
      //r = F.add(r, ph);
    }
    // TODO: fix this
    return BigInt.zero;
    //return F.normalize(r);
  }

  /// Mask and shift a BigInt
  ///
  /// @param {BigInt} num - Input number
  /// @param {int} origin - Initial bit
  /// @param {int} len - Bit length of the mask
  /// @returns {BigInt} Scalar
  static BigInt extract(BigInt num, int origin, int len) {
    BigInt mask = (BigInt.one << len) - BigInt.one;
    return (num >> origin) & mask;
  }
}
