import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import 'native_prover.dart';

@injectable
class ProverLib {
  static NativeProverLib get _nativeProverLib {
    return Platform.isAndroid
        ? NativeProverLib(ffi.DynamicLibrary.open("librapidsnark.so"))
        : NativeProverLib(ffi.DynamicLibrary.process());
  }

  ProverLib();

  Future<Map<String, dynamic>?> prove(
      String circuitId, Uint8List zkeyBytes, Uint8List wtnsBytes) async {
    Map<String, dynamic> map = {};

    int zkeySize = zkeyBytes.length;
    ffi.Pointer<ffi.Char> zkeyBuffer = malloc<ffi.Char>(zkeySize);
    final data = zkeyBytes;
    for (int i = 0; i < zkeySize; i++) {
      zkeyBuffer[i] = data[i];
    }
    int wtnsSize = wtnsBytes.length;
    ffi.Pointer<ffi.Char> wtnsBuffer = malloc<ffi.Char>(wtnsSize);
    final data2 = wtnsBytes.buffer.asUint8List();
    for (int i = 0; i < wtnsSize; i++) {
      wtnsBuffer[i] = data2[i];
    }

    ffi.Pointer<ffi.UnsignedLong> proofSize = malloc<ffi.UnsignedLong>();
    proofSize.value = 16384;
    ffi.Pointer<ffi.Char> proofBuffer = malloc<ffi.Char>(proofSize.value);
    ffi.Pointer<ffi.UnsignedLong> publicSize = malloc<ffi.UnsignedLong>();
    publicSize.value = 16384;
    ffi.Pointer<ffi.Char> publicBuffer = malloc<ffi.Char>(publicSize.value);
    int errorMaxSize = 256;
    ffi.Pointer<ffi.Char> errorMsg = malloc<ffi.Char>(errorMaxSize);

    freeAllocatedMemory() {
      malloc.free(zkeyBuffer);
      malloc.free(wtnsBuffer);
      malloc.free(proofSize);
      malloc.free(proofBuffer);
      malloc.free(publicSize);
      malloc.free(publicBuffer);
      malloc.free(errorMsg);
    }

    int result = _nativeProverLib.groth16_prover(
        zkeyBuffer.cast(),
        zkeySize,
        wtnsBuffer.cast(),
        wtnsSize,
        proofBuffer,
        proofSize,
        publicBuffer,
        publicSize,
        errorMsg,
        errorMaxSize);

    if (result == PRPOVER_OK) {
      ffi.Pointer<Utf8> jsonString = proofBuffer.cast<Utf8>();
      String proofmsg = jsonString.toDartString();

      ffi.Pointer<Utf8> jsonString2 = publicBuffer.cast<Utf8>();
      String publicmsg = jsonString2.toDartString();
      map['circuitId'] = circuitId;
      map['proof'] = json.decode(proofmsg);
      (map['proof'] as Map<String, dynamic>)
          .putIfAbsent("curve", () => "bn128");
      map['pub_signals'] = json.decode(publicmsg).cast<String>();
      freeAllocatedMemory();
      return map;
    } else if (result == PPROVER_ERROR) {
      ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      String errormsg = jsonString.toDartString();

      logger().i("$result: ${result.toString()}. Error: $errormsg");
    } else if (result == PPROVER_ERROR_SHORT_BUFFER) {
      logger().i(
          "$result: ${result.toString()}. Error: Short buffer for proof or public");
    }
    freeAllocatedMemory();
    return null;
  }
}
