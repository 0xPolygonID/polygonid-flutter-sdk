import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import 'native_polygonidcore.dart';

typedef ConsumedStatusResult = ({PLGNStatusCode statusCode, String message});

ConsumedStatusResult _createConsumedStatusResult(
    PLGNStatusCode statusCode, String message) {
  return (statusCode: statusCode, message: message);
}

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

  ConsumedStatusResult consumeStatus(
      ffi.Pointer<ffi.Pointer<PLGNStatus>> status) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      _logError("unable to allocate status");

      return _createConsumedStatusResult(
        PLGNStatusCode.PLGNSTATUSCODE_ERROR,
        "unable to allocate status",
      );
    }

    String errorMessage = status.value.ref.status.toString();
    PLGNStatusCode statusCode = status.value.ref.status;

    if (status.value.ref.error_msg == ffi.nullptr) {
      _logError(status.value.ref.status.toString());
    } else {
      ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
      ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
      try {
        errorMessage = jsonString.toDartString();
        _logError(
            "${status.value.ref.status.toString()} - Error: $errorMessage");
      } catch (e) {
        _logError(status.value.ref.status.toString());
      }
    }
    _freeStatus(status);
    return _createConsumedStatusResult(statusCode, errorMessage);
  }

  void _freeStatus(ffi.Pointer<ffi.Pointer<PLGNStatus>> status) {
    nativePolygonIdCoreLib.PLGNFreeStatus(status.value);
  }

  void _logError(String message) {
    if (kDebugMode) {
      logger().e(message);
    }
  }
}
