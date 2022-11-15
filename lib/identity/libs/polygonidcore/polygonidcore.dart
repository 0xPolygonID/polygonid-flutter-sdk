import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'native_polygonidcore.dart';

@injectable
class PolygonIdCoreLib {
  static NativePolygonIdCoreLib get _nativePolygonIdCoreLib {
    return Platform.isAndroid
        ? NativePolygonIdCoreLib(ffi.DynamicLibrary.open("libpolygonid.so"))
        : NativePolygonIdCoreLib(ffi.DynamicLibrary.process());
  }

  PolygonIdCoreLib();

  String calculateGenesisId(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();
    int res =
        _nativePolygonIdCoreLib.PLGNCalculateGenesisID(response, in1, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    String result = "";
    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    return result;
  }

  String getAuthInputs(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();
    int res =
        _nativePolygonIdCoreLib.PLGNAuthV2InputsMarshal(response, in1, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    String result = "";
    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    return result;
  }

  String createClaim(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();
    int res = _nativePolygonIdCoreLib.PLGNCreateClaim(response, in1, status);
    if (res == 0) {
      _consumeStatus(status, "");
    }
    String result = "";
    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    return result;
  }

  bool _consumeStatus(ffi.Pointer<ffi.Pointer<PLGNStatus>> status, String msg) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      if (kDebugMode) {
        print("unable to allocate status\n");
      }
      return false;
    }
    bool result = true;

    if (status.value.ref.status >= 0) {
      result = false;
      if (msg.isEmpty) {
        msg = "status is not OK";
      }
      if (kDebugMode) {
        print("Status: ${status.value.ref.status.toString()}");
      }
      if (status.value.ref.error_msg == ffi.nullptr) {
        if (kDebugMode) {
          print("$msg: ${status.value.ref.status.toString()}");
        }
      } else {
        ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        try {
          String errormsg = jsonString.toDartString();
          if (kDebugMode) {
            print(
                "$msg: ${status.value.ref.status.toString()}. Error: $errormsg");
          }
        } catch (e) {
          if (kDebugMode) {
            print("$msg: ${status.value.ref.status.toString()}");
          }
        }
      }
    }
    _nativePolygonIdCoreLib.PLGNFreeStatus(status.value);
    return result;
  }
}
