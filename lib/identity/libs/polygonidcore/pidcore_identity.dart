import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';

import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';

@injectable
class PolygonIdCoreIdentity extends PolygonIdCore {
  String calculateGenesisId(String input, String config) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> cfg = config.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();

    freeAllocatedMemory() {
      malloc.free(response);
      malloc.free(status);
    }

    int res = PolygonIdCore.nativePolygonIdCoreLib
        .PLGNNewGenesisID(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");

      if (consumedStatus != null) {
        freeAllocatedMemory();
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNNewGenesisID",
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

  String calculateProfileId(String input) {
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
        .PLGNProfileID(response, in1, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");

      if (consumedStatus != null) {
        freeAllocatedMemory();
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNProfileID",
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

  /// PLGNIDToInt returns the ID as a big int string
  /// Input should be a valid JSON object: string enclosed by double quotes.
  /// Output is a valid JSON object too: string enclosed by double quotes.
  String convertIdToBigInt(String input) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();

    freeAllocatedMemory() {
      malloc.free(response);
      malloc.free(status);
    }

    int res =
        PolygonIdCore.nativePolygonIdCoreLib.PLGNIDToInt(response, in1, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      // ignore: unnecessary_null_comparison
      if (consumedStatus != null) {
        freeAllocatedMemory();
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNIDToInt",
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

  String describeId(String input, String? config) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> cfg = ffi.nullptr;
    if (config != null) {
      cfg = config.toNativeUtf8().cast<ffi.Char>();
    }
    ffi.Pointer<ffi.Pointer<ffi.Char>> response =
        malloc<ffi.Pointer<ffi.Char>>();
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();

    freeAllocatedMemory() {
      malloc.free(response);
      malloc.free(status);
    }

    int res = PolygonIdCore.nativePolygonIdCoreLib
        .PLGNDescribeID(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");

      if (consumedStatus != null) {
        freeAllocatedMemory();
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNDescribeID",
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
