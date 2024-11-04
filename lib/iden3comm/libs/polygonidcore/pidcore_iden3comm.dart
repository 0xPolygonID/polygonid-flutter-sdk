import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

@injectable
class PolygonIdCoreIden3comm extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreIden3comm(this._stacktraceManager);

  String getAuthInputs(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();

    freeAllocatedMemory() {
      malloc.free(response);
      malloc.free(status);
    }

    int res = PolygonIdCore.nativePolygonIdCoreLib
        .PLGNAuthV2InputsMarshal(response, in1, status);

    // res 0 means error
    if (res == 0) {
      final ConsumedStatusResult consumedStatus = consumeStatus(status);
      freeAllocatedMemory();
      _trackError(consumedStatus);
      throw CoreLibraryException(
        coreLibraryName: "libpolygonid",
        methodName: "PLGNAuthV2InputsMarshal",
        errorMessage: consumedStatus.message,
        statusCode: consumedStatus.statusCode,
      );
    }

    String result = "";
    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    freeAllocatedMemory();

    return result;
  }

  void _trackError(ConsumedStatusResult consumedStatus) {
    _stacktraceManager.addTrace(
        "libpolygonid - PLGNAuthV2InputsMarshal: [${consumedStatus.statusCode}] - ${consumedStatus.message}");
    _stacktraceManager.addError(
        "libpolygonid - PLGNAuthV2InputsMarshal: [${consumedStatus.statusCode}] - ${consumedStatus.message}");
  }
}
