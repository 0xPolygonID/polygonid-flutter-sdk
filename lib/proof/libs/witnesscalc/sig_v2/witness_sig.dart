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

import 'native_witness_sig_v2.dart';

@injectable
class WitnessSigV2Lib {
  static NativeWitnessSigV2Lib get _nativeWitnessSigV2Lib {
    return Platform.isAndroid
        ? NativeWitnessSigV2Lib(ffi.DynamicLibrary.open(
            "libwitnesscalc_credentialAtomicQuerySigV2.so"))
        : NativeWitnessSigV2Lib(ffi.DynamicLibrary.process());
  }

  WitnessSigV2Lib();

  Future<Uint8List?> calculateWitnessSig(
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

    int result = _nativeWitnessSigV2Lib.witnesscalc_credentialAtomicQuerySigV2(
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
          .addTrace("libwitnesscalc_credentialAtomicQuerySigV2: $errormsg");
      _stacktraceManager
          .addError("libwitnesscalc_credentialAtomicQuerySigV2: $errormsg");
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc_credentialAtomicQuerySigV2",
        methodName: "witnesscalc_credentialAtomicQuerySigV2",
        errorMessage: errormsg,
      );
    } else if (result == WITNESSCALC_ERROR_SHORT_BUFFER) {
      logger().e(
          "$result: ${result.toString()}. Error: Short buffer for proof or public");
      freeAllocatedMemory();
      StacktraceManager _stacktraceManager = getItSdk.get<StacktraceManager>();
      _stacktraceManager.addError(
          "libwitnesscalc_credentialAtomicQuerySigV2: witnesscalc_credentialAtomicQuerySigV2: Short buffer for proof or public");
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc_credentialAtomicQuerySigV2",
        methodName: "witnesscalc_credentialAtomicQuerySigV2",
        errorMessage: "Short buffer for proof or public",
      );
    }
    freeAllocatedMemory();
    return null;
  }
}
