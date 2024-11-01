import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import '../../../common/libs/polygonidcore/native_polygonidcore.dart';
import '../../../common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreCredential extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreCredential(this._stacktraceManager);

  String createClaim(String input) {
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
        .PLGNCreateClaim(response, in1, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager
            .addTrace("libpolygonid - PLGNCreateClaim: $consumedStatus");
        _stacktraceManager
            .addError("libpolygonid - PLGNCreateClaim: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNCreateClaim",
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

  String? cacheCredentials(String input, String? config) {
    ffi.Pointer<ffi.Char> in1 = input.toNativeUtf8().cast<ffi.Char>();
    ffi.Pointer<ffi.Char> cfg = ffi.nullptr;
    if (config != null) {
      cfg = config.toNativeUtf8().cast<ffi.Char>();
    }
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status =
        malloc<ffi.Pointer<PLGNStatus>>();
    int res = PolygonIdCore.nativePolygonIdCoreLib
        .PLGNCacheCredentials(in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        malloc.free(status);
        _stacktraceManager
            .addTrace("libpolygonid: PLGNCacheCredentials: $consumedStatus");
        _stacktraceManager
            .addError("libpolygonid: PLGNCacheCredentials: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNCacheCredentials",
          errorMessage: consumedStatus,
        );
      }
    }

    malloc.free(status);
    return "";
  }

  String w3cCredentialsFromOnchainHex(String input, String? config) {
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
        .PLGNW3CCredentialFromOnchainHex(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid: PLGNW3CCredentialFromOnchainHex: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid: PLGNW3CCredentialFromOnchainHex: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNW3CCredentialFromOnchainHex",
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
