import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'native_witness_universal.dart';

@injectable
class WitnessUniversalLib {
  static NativeWitnessUniversalLib get _nativeWitnessUniversalLib {
    return Platform.isAndroid
        ? NativeWitnessUniversalLib(ffi.DynamicLibrary.open("libwitness.so"))
        : NativeWitnessUniversalLib(ffi.DynamicLibrary.process());
  }

  WitnessUniversalLib();

  Future<Uint8List?> calculateWitness(
    Uint8List inputsJsonBytes,
    Uint8List graphBytes,
  ) async {
    int jsonSize = inputsJsonBytes.length;
    ffi.Pointer<ffi.Char> jsonBuffer = malloc<ffi.Char>(jsonSize);
    final data2 = inputsJsonBytes;
    for (int i = 0; i < jsonSize; i++) {
      jsonBuffer[i] = data2[i];
    }

    int graphSize = graphBytes.length;
    ffi.Pointer<ffi.Char> graphBuffer = malloc<ffi.Char>(graphSize);
    final data = graphBytes;
    for (int i = 0; i < graphSize; i++) {
      graphBuffer[i] = data[i];
    }

    ffi.Pointer<ffi.Pointer<ffi.Char>> wtns_data =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.UnsignedLong> wtns_length = malloc<ffi.UnsignedLong>();

    final ffi.Pointer<GWStatusT> status = calloc<GWStatusT>();

    freeAllocatedMemory() {
      malloc.free(jsonBuffer);
      malloc.free(graphBuffer);

      malloc.free(wtns_data);
      malloc.free(wtns_length);
      malloc.free(status);
    }

    int result = _nativeWitnessUniversalLib.gw_calc_witness(
      jsonBuffer,
      graphBuffer,
      graphSize,
      wtns_data,
      wtns_length,
      status,
    );

    if (result == WITNESSCALC_OK) {
      // Uint8List wtnsBytes = Uint8List(wtnsSize.value);
      // for (int i = 0; i < wtnsSize.value; i++) {
      //   wtnsBytes[i] = wtnsBuffer[i];
      // }
      freeAllocatedMemory();
      return Uint8List(0);
    } else if (result == WITNESSCALC_ERROR) {
      // ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      // String errormsg = jsonString.toDartString();
      // if (kDebugMode) {
      //   print("$result: ${result.toString()}. Error: $errormsg");
      // }
      // freeAllocatedMemory();
      throw CoreLibraryException(
        coreLibraryName: "libwitnesscalc_authV2",
        methodName: "witnesscalc_authV2",
        errorMessage: "",
      );
    }
    freeAllocatedMemory();
    return null;
  }
}
