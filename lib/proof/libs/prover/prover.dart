import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

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
    final StacktraceStreamManager _stacktraceStreamManager =
        getItSdk<StacktraceStreamManager>();
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

    DateTime start = DateTime.now();

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

    DateTime end = DateTime.now();

    int time = end.difference(start).inMicroseconds;
    _stacktraceStreamManager.addTrace(
        "[proverLib] groth16_prover: $time in microseconds, time in seconds: ${time / 1000000}");

    if (result == PRPOVER_OK) {
      ffi.Pointer<Utf8> jsonString = proofBuffer.cast<Utf8>();
      String proofmsg = jsonString.toDartString();

      ffi.Pointer<Utf8> jsonString2 = publicBuffer.cast<Utf8>();
      String publicmsg = jsonString2.toDartString();

      _stacktraceStreamManager.addTrace(
          "[proverLib] groth16_prover: result OK, proof: $proofmsg, public: $publicmsg");
      if (kDebugMode) {
        print("Proof: $proofmsg");
        print("Public: $publicmsg");
        print("Time: $time");
      }
      map['circuitId'] = circuitId;
      map['proof'] = json.decode(proofmsg);
      (map['proof'] as Map<String, dynamic>)
          .putIfAbsent("curve", () => "bn128");
      map['pub_signals'] = json.decode(publicmsg).cast<String>();
      return map;
    } else if (result == PPROVER_ERROR) {
      ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      String errormsg = jsonString.toDartString();
      _stacktraceStreamManager.addTrace(
          "[proverLib] groth16_prover: result ERROR, error: $errormsg");
      if (kDebugMode) {
        print("$result: ${result.toString()}. Error: $errormsg");
      }
    } else if (result == PPROVER_ERROR_SHORT_BUFFER) {
      _stacktraceStreamManager.addTrace(
          "[proverLib] groth16_prover: result ERROR, error: Short buffer for proof or public");
      if (kDebugMode) {
        print(
            "$result: ${result.toString()}. Error: Short buffer for proof or public");
      }
    }

    return null;
  }
}
