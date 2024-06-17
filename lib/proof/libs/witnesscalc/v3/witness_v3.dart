import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'native_witness_v3.dart';

@injectable
class WitnessV3Lib {
  static NativeWitnessV3Lib get _nativeWitnessV3Lib {
    return Platform.isAndroid
        ? NativeWitnessV3Lib(ffi.DynamicLibrary.open(
            "libwitnesscalc_credentialAtomicQueryV3.so"))
        : NativeWitnessV3Lib(ffi.DynamicLibrary.process());
  }

  WitnessV3Lib();

  Future<Uint8List?> calculateWitness(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) async {
    int circuitSize = wasmBytes.length;
    ffi.Pointer<ffi.Char> circuitBuffer = malloc<ffi.Char>(circuitSize);
    final data = wasmBytes;
    for (int i = 0; i < circuitSize; i++) {
      circuitBuffer[i] = data[i];
    }

    int jsonSize = inputsJsonBytes.length;
    ffi.Pointer<ffi.Char> jsonBuffer = malloc<ffi.Char>(jsonSize);
    final data2 = inputsJsonBytes;
    for (int i = 0; i < jsonSize; i++) {
      jsonBuffer[i] = data2[i];
    }

    ffi.Pointer<ffi.UnsignedLong> wtnsSize = malloc<ffi.UnsignedLong>();
    wtnsSize.value = 4 * 1024 * 1024;
    ffi.Pointer<ffi.Char> wtnsBuffer = malloc<ffi.Char>(wtnsSize.value);

    int errorMaxSize = 256;
    ffi.Pointer<ffi.Char> errorMsg = malloc<ffi.Char>(errorMaxSize);

    freeAllocatedMemory() {
      malloc.free(circuitBuffer);
      malloc.free(jsonBuffer);
      malloc.free(wtnsSize);
      malloc.free(wtnsBuffer);
      malloc.free(errorMsg);
    }

    int result = _nativeWitnessV3Lib.witnesscalc_credentialAtomicQueryV3(
      circuitBuffer,
      circuitSize,
      jsonBuffer,
      jsonSize,
      wtnsBuffer,
      wtnsSize,
      errorMsg,
      errorMaxSize,
    );

    if (result == WITNESSCALC_OK) {
      Uint8List wtnsBytes = Uint8List(wtnsSize.value);
      for (int i = 0; i < wtnsSize.value; i++) {
        wtnsBytes[i] = wtnsBuffer[i];
      }
      freeAllocatedMemory();
      return wtnsBytes;
    } else if (result == WITNESSCALC_ERROR) {
      ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      String errormsg = jsonString.toDartString();

      logger().e("$result: ${result.toString()}. Error: $errormsg");
      freeAllocatedMemory();
      StacktraceManager _stacktraceManager = getItSdk.get<StacktraceManager>();
      _stacktraceManager
          .addTrace("libwitnesscalc_credentialAtomicQueryV3: $errormsg");
      _stacktraceManager
          .addError("libwitnesscalc_credentialAtomicQueryV3: $errormsg");
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc_credentialAtomicQueryV3",
        methodName: "witnesscalc_credentialAtomicQueryV3",
        errorMessage: errormsg,
      );
    } else if (result == WITNESSCALC_ERROR_SHORT_BUFFER) {
      logger().e(
          "$result: ${result.toString()}. Error: Short buffer for proof or public");
      freeAllocatedMemory();
      StacktraceManager _stacktraceManager = getItSdk.get<StacktraceManager>();
      _stacktraceManager.addTrace(
          "libwitnesscalc_credentialAtomicQueryV3: witnesscalc_credentialAtomicQueryV3: Short buffer for proof or public");
      _stacktraceManager.addError(
          "libwitnesscalc_credentialAtomicQueryV3: witnesscalc_credentialAtomicQueryV3: Short buffer for proof or public");
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc_credentialAtomicQueryV3",
        methodName: "witnesscalc_credentialAtomicQueryV3",
        errorMessage: "Short buffer for proof or public",
      );
    }
    freeAllocatedMemory();
    return null;
  }
}
