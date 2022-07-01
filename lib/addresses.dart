import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/utils/hex_utils.dart';
import 'package:polygonid_flutter_sdk/utils/uint8_list_utils.dart';

const String hermezPrefix = 'hez:';
final ethereumAddressPattern = new RegExp('^0x[a-fA-F0-9]{40}\$');
final hezEthereumAddressPattern = new RegExp('^hez:0x[a-fA-F0-9]{40}\$'); //
final bjjAddressPattern = new RegExp('^hez:[A-Za-z0-9_-]{44}\$');
final accountIndexPattern = new RegExp('^hez:[a-zA-Z0-9]{2,6}:[0-9]{0,9}\$');

/// Get API bjj compressed data format
///
/// @param [String] bjjCompressedHex - bjj compressed address encoded as hex string
/// @returns [String] API adapted bjj compressed address
String hexToBase64BJJ(String bjjCompressedHex) {
  BigInt bjjScalar = HexUtils.hexToInt(bjjCompressedHex);
  Uint8List littleEndianBytes = Uint8ArrayUtils.bigIntToBytes(bjjScalar);
  String bjjSwap = HexUtils.bytesToHex(littleEndianBytes,
      forcePadLength: 64, padToEvenLength: false);
  Uint8List bjjSwapBuffer = HexUtils.hexToBytes(bjjSwap);

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

/// Gets the Babyjubjub hexadecimal from its base64 representation
///
/// @param {String} base64BJJ
/// @returns {String} babyjubjub address in hex string
String base64ToHexBJJ(String base64BJJ) {
  if (base64BJJ.startsWith('hez:')) {
    base64BJJ = base64BJJ.replaceFirst('hez:', '');
  }
  final bjjSwapBuffer = base64Url.decode(base64BJJ);
  final bjjSwapBuff = bjjSwapBuffer.toList();
  bjjSwapBuff.removeLast();
  String bjjSwap = HexUtils.bytesToHex(bjjSwapBuff,
      forcePadLength: 64, padToEvenLength: false);
  Uint8List littleEndianBytes = HexUtils.hexToBytes(bjjSwap);
  BigInt bjjScalar = Uint8ArrayUtils.bytesToBigInt(littleEndianBytes);
  String bjjCompressedHex = bjjScalar.toRadixString(16);
  return bjjCompressedHex;
}

/// Get Ay and Sign from Bjj compressed
/// @param {String} fromBjjCompressed - Bjj compressed encoded as hexadecimal string
/// @return {Object} Ay represented as hexadecimal string, Sign represented as BigInt
dynamic getAySignFromBJJ(String fromBjjCompressed) {
  BigInt bjjScalar = HexUtils.hexToInt(fromBjjCompressed);
  String ay = HexUtils.extract(bjjScalar, 0, 254).toRadixString(16);
  BigInt sign = HexUtils.extract(bjjScalar, 255, 1);

  return {"ay": ay, "sign": sign};
}
