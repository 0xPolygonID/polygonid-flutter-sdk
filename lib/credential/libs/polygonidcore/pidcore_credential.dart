import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';

import '../../../common/libs/polygonidcore/native_polygonidcore.dart';
import '../../../common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreCredential extends PolygonIdCore {
  String createClaim(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();
    int res = PolygonIdCore.nativePolygonIdCoreLib
        .PLGNCreateClaim(response, in1, status);
    if (res == 0) {
      consumeStatus(status, "");
    }
    String result = "";
    ffi.Pointer<ffi.Char> jsonResponse = response.value;
    ffi.Pointer<Utf8> jsonString = jsonResponse.cast<Utf8>();
    if (jsonString != ffi.nullptr) {
      result = jsonString.toDartString();
    }

    return result;
  }
}
