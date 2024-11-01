import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';
import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/pidcore_base.dart';

@injectable
class PolygonIdCoreProof extends PolygonIdCore {
  final StacktraceManager _stacktraceManager;

  PolygonIdCoreProof(this._stacktraceManager);

  String proofFromSmartContract(String input) {
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
        .PLGNProofFromSmartContract(response, in1, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNProofFromSmartContract: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNProofFromSmartContract: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNProofFromSmartContract",
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

  String getSigProofInputs(String input, String? config) {
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
        .PLGNAtomicQuerySigV2Inputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQuerySigV2Inputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQuerySigV2Inputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQuerySigV2Inputs",
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

  String getSigOnchainProofInputs(String input, String? config) {
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
        .PLGNAtomicQuerySigV2OnChainInputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQuerySigV2OnChainInputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQuerySigV2OnChainInputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQuerySigV2OnChainInputs",
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

  String getMTProofInputs(String input, String? config) {
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
        .PLGNAtomicQueryMtpV2Inputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQueryMtpV2Inputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQueryMtpV2Inputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQueryMtpV2Inputs",
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

  String getMTPOnchainProofInputs(String input, String? config) {
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
        .PLGNAtomicQueryMtpV2OnChainInputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQueryMtpV2OnChainInputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQueryMtpV2OnChainInputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQueryMtpV2OnChainInputs",
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

  String getV3ProofInputs(String input, String? config) {
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
        .PLGNAtomicQueryV3Inputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQueryV3Inputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQueryV3Inputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQueryV3Inputs",
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

  String getV3OnchainProofInputs(String input, String? config) {
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
        .PLGNAtomicQueryV3OnChainInputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNAtomicQueryV3OnChainInputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNAtomicQueryV3OnChainInputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNAtomicQueryV3OnChainInputs",
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

  String getLinkedMultiQueryInputs(String input, String? config) {
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
        .PLGNALinkedMultiQueryInputs(response, in1, cfg, status);
    if (res == 0) {
      String? consumedStatus = consumeStatus(status, "");
      if (consumedStatus != null) {
        freeAllocatedMemory();
        _stacktraceManager.addTrace(
            "libpolygonid - PLGNALinkedMultiQueryInputs: $consumedStatus");
        _stacktraceManager.addError(
            "libpolygonid - PLGNALinkedMultiQueryInputs: $consumedStatus");
        throw CoreLibraryException(
          coreLibraryName: "libpolygonid",
          methodName: "PLGNALinkedMultiQueryInputs",
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
