import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'native_witness_auth_v2.dart';

@injectable
class WitnessAuthV2Lib {
  static NativeWitnessAuthV2Lib get _nativeWitnessAuthV2Lib {
    return Platform.isAndroid
        ? NativeWitnessAuthV2Lib(
            ffi.DynamicLibrary.open("libwitnesscalc_authV2.so"))
        : NativeWitnessAuthV2Lib(ffi.DynamicLibrary.process());
  }

  WitnessAuthV2Lib();

  Future<Uint8List?> calculateWitnessAuth(
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

    int result = _nativeWitnessAuthV2Lib.witnesscalc_authV2(
        circuitBuffer,
        circuitSize,
        jsonBuffer,
        jsonSize,
        wtnsBuffer,
        wtnsSize,
        errorMsg,
        errorMaxSize);

    if (result == WITNESSCALC_OK) {
      Uint8List wtnsBytes = Uint8List(wtnsSize.value);
      for (int i = 0; i < wtnsSize.value; i++) {
        wtnsBytes[i] = wtnsBuffer[i];
      }
      return wtnsBytes;
    } else if (result == WITNESSCALC_ERROR) {
      ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      String errormsg = jsonString.toDartString();
      if (kDebugMode) {
        print("$result: ${result.toString()}. Error: $errormsg");
      }
    } else if (result == WITNESSCALC_ERROR_SHORT_BUFFER) {
      if (kDebugMode) {
        print(
            "$result: ${result.toString()}. Error: Short buffer for proof or public");
      }
    }
    return null;
  }

  /*Future<Uint8List?> calculateWitnessAuth(Uint8List wasmBytes, Uint8List inputsJsonBytes) async {
    print("calculateWitnessAuth ffi");
    int circuitSize = wasmBytes.length;
    ffi.Pointer<ffi.Char> circuitBuffer = calloc<ffi.Char>(circuitSize);
    print("circuitbuffer: $circuitBuffer");
    for (int i = 0; i < circuitSize; i++) {
      circuitBuffer[i] = wasmBytes[i];
    }

    int jsonSize = inputsJsonBytes.length;
    ffi.Pointer<ffi.Char> jsonBuffer = calloc<ffi.Char>(jsonSize);
    print("jsonBuffer: $jsonBuffer");
    for (int i = 0; i < jsonSize; i++) {
      jsonBuffer[i] = inputsJsonBytes[i];
    }

    ffi.Pointer<ffi.UnsignedLong> wtnsSize = calloc<ffi.UnsignedLong>();
    wtnsSize.value = 4 * 1024 * 1024;
    ffi.Pointer<ffi.Char> wtnsBuffer = calloc<ffi.Char>(wtnsSize.value);
    print("wtnsBuffer: $wtnsBuffer");

    int errorMaxSize = 256;
    ffi.Pointer<ffi.Char> errorMsg = calloc<ffi.Char>(errorMaxSize);
    print("errorMsg: $errorMsg");

    int result = _nativeWitnessAuthV2Lib.witnesscalc_authV2(
        circuitBuffer,
        circuitSize,
        jsonBuffer,
        jsonSize,
        wtnsBuffer,
        wtnsSize,
        errorMsg,
        errorMaxSize);
    print("result: $result");

    Uint8List? wtnsBytes;
    if (result == WITNESSCALC_OK) {
      print("WITNESSCALC_OK");
      wtnsBytes = Uint8List(wtnsSize.value);
      for (int i = 0; i < wtnsSize.value; i++) {
        wtnsBytes[i] = wtnsBuffer[i];
      }
    } else if (result == WITNESSCALC_ERROR) {
      print("WITNESSCALC_ERROR");
      ffi.Pointer<Utf8> jsonString = errorMsg.cast<Utf8>();
      String errormsg = jsonString.toDartString();
      if (kDebugMode) {
        print("$result: ${result.toString()}. Error: $errormsg");
      }
    } else if (result == WITNESSCALC_ERROR_SHORT_BUFFER) {
      print("WITNESSCALC_ERROR_SHORT_BUFFER");
      if (kDebugMode) {
        print("$result: ${result.toString()}. Error: Short buffer for proof or public");
      }
    }

    // Free the allocated memory
    calloc.free(circuitBuffer);
    calloc.free(jsonBuffer);
    calloc.free(wtnsBuffer);
    calloc.free(errorMsg);
    calloc.free(wtnsSize);

    return wtnsBytes;
  }*/
}
