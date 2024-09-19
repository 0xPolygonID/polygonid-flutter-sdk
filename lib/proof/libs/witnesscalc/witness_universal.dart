import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'native_witness_universal.dart';

@injectable
class WitnessUniversalLib {
  static NativeWitnessCalcLib get _nativeWitnessCalcLib {
    return Platform.isAndroid
        ? NativeWitnessCalcLib(ffi.DynamicLibrary.open("libwitnesscalc.so"))
        : NativeWitnessCalcLib(ffi.DynamicLibrary.process());
  }

  WitnessUniversalLib();

  Future<Uint8List?> calculateWitness(
    Uint8List inputsBytes,
    Uint8List graphBytes,
  ) async {
    int inputsSize = inputsBytes.length;
    ffi.Pointer<ffi.Char> inputsBuffer = malloc<ffi.Char>(inputsSize);
    final data2 = inputsBytes;
    for (int i = 0; i < inputsSize; i++) {
      inputsBuffer[i] = data2[i];
    }

    int graphSize = graphBytes.length;
    ffi.Pointer<ffi.Char> graphBuffer = malloc<ffi.Char>(graphSize);
    final data = graphBytes;
    for (int i = 0; i < graphSize; i++) {
      graphBuffer[i] = data[i];
    }

    ffi.Pointer<ffi.Pointer<ffi.Void>> wtnsBufferPointer =
        malloc<ffi.Pointer<ffi.Void>>();
    ffi.Pointer<ffi.UnsignedLong> wtnsSizePointer = malloc<ffi.UnsignedLong>();

    ffi.Pointer<GWStatus> statusPointer = malloc<GWStatus>();

    freeAllocatedMemory() {
      malloc.free(inputsBuffer);
      malloc.free(graphBuffer);
      malloc.free(wtnsBufferPointer);
      malloc.free(wtnsSizePointer);

      // _nativeWitnessCalcLib.gw_free_status(statusPointer);
    }

    int result = _nativeWitnessCalcLib.gw_calc_witness(
      inputsBuffer,
      graphBuffer,
      graphSize,
      wtnsBufferPointer,
      wtnsSizePointer,
      statusPointer,
    );

    if (result == GW_ERROR_CODE_OK) {
      final wtnsBuffer = wtnsBufferPointer.value.cast<Uint8>();

      Uint8List wtnsBytes = Uint8List(wtnsSizePointer.value);
      for (int i = 0; i < wtnsSizePointer.value; i++) {
        wtnsBytes[i] = wtnsBuffer[i];
      }
      freeAllocatedMemory();
      return wtnsBytes;
    } else if (result == GW_ERROR_CODE_ERROR) {
      ffi.Pointer<Utf8> error_msg = statusPointer.ref.error_msg.cast<Utf8>();
      String errorMessage = error_msg.toDartString();
      logger().e("Code: ${result.toString()}. Error: $errorMessage");
      freeAllocatedMemory();
      StacktraceManager _stacktraceManager = StacktraceManager();
      _stacktraceManager.addTrace("libwitnesscalc: $errorMessage");
      _stacktraceManager.addError("libwitnesscalc: $errorMessage");
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc",
        methodName: "witnesscalc",
        errorMessage: errorMessage,
      );
    }
    freeAllocatedMemory();
    return null;
  }
}
