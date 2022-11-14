import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:injectable/injectable.dart';

import 'native_polygonidcore.dart';

@injectable
class PolygonIdCoreLib {
  static NativePolygonIdCoreLib get _nativeIden3CoreLib {
    return Platform.isAndroid
        ? NativePolygonIdCoreLib(ffi.DynamicLibrary.open("libpolygonid.so"))
        : NativePolygonIdCoreLib(ffi.DynamicLibrary.process());
  }

  PolygonIdCoreLib();
}
