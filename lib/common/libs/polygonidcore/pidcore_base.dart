import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pid_result_model.dart';

import 'native_polygonidcore.dart';

@injectable
class PolygonIdCore {
  static NativePolygonIdCoreLib? _nativePolygonIdCoreLib;

  static NativePolygonIdCoreLib get nativePolygonIdCoreLib {
    final instance = _nativePolygonIdCoreLib;
    if (instance != null) {
      return instance;
    }

    _nativePolygonIdCoreLib = Platform.isAndroid
        ? NativePolygonIdCoreLib(ffi.DynamicLibrary.open("libpolygonid.so"))
        : NativePolygonIdCoreLib(ffi.DynamicLibrary.process());

    return _nativePolygonIdCoreLib!;
  }

  PolygonIdCore();

  NativePolygonIdCoreResult<String> consumeStatus(
      ffi.Pointer<ffi.Pointer<PLGNStatus>> status, String msg) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      if (kDebugMode) {
        logger().e("unable to allocate status\n");
      }
      return NativePolygonIdCoreResult.error(
        statusCode: PLGNStatusCode.PLGNSTATUSCODE_ERROR,
        message: "unable to allocate status",
      );
    }
    String? result;

    if (status.value.ref.statusAsInt < 0) {
      _freeStatus(status);
      return NativePolygonIdCoreResult.success(result);
    }

    String errorMessage = status.value.ref.status.toString();
    PLGNStatusCode statusCode = status.value.ref.status;

    if (status.value.ref.error_msg != ffi.nullptr) {
      try {
        ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        errorMessage = jsonString.toDartString();
      }catch(_){
        // we don't want to crash the app if we can't parse the error message
        if(kDebugMode){
          logger().e("Error parsing error message");
        }
      }
    }
    if (status.value.ref.error_msg == ffi.nullptr) {
      if (kDebugMode) {
        logger().e("$msg: ${status.value.ref.status.toString()}");
      }
    } else {
      ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      try {
        String errormsg = jsonString.toDartString();
        msg = "$msg: $errormsg";
        if (kDebugMode) {
          logger().e(
              "$msg: ${status.value.ref.status.toString()}. Error: $errormsg");
        }
      } catch (e) {
        if (kDebugMode) {
          logger().e("$msg: ${status.value.ref.status.toString()}");
        }
      }
    }
    result = msg;
  }

  void _freeStatus(ffi.Pointer<ffi.Pointer<PLGNStatus>> status) {
    nativePolygonIdCoreLib.PLGNFreeStatus(status.value);
  }
}
