import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';

@injectable
class PolygonIdCoreIden3comm extends PolygonIdCore {
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

    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAuthV2InputsMarshal",
          errorMessage: consumedStatus,
        );
      }
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
}
