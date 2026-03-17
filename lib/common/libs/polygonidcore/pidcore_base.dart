import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

import 'native_polygonidcore.dart';

typedef ConsumedStatusResult = ({PLGNStatusCode statusCode, String message});

typedef GenericPolygonIdFunction =
    int Function(
      ffi.Pointer<ffi.Pointer<ffi.Char>> response,
      ffi.Pointer<ffi.Char> input,
      ffi.Pointer<ffi.Char> config,
      ffi.Pointer<ffi.Pointer<PLGNStatus>> status,
    );

const _kLibraryName = 'libpolygonid';

@injectable
class PolygonIdCore {
  static late String _envConfigJson;

  static NativePolygonIdCoreLib? _nativePolygonIdCoreLib;

  static NativePolygonIdCoreLib get nativePolygonIdCoreLib =>
      _nativePolygonIdCoreLib ??= _loadNativeLib();

  static NativePolygonIdCoreLib _loadNativeLib() {
    final lib = Platform.isAndroid
        ? ffi.DynamicLibrary.open('$_kLibraryName.so')
        : ffi.DynamicLibrary.process();
    return NativePolygonIdCoreLib(lib);
  }

  static void setEnvConfig(EnvConfigEntity envConfig) {
    _envConfigJson = jsonEncode(envConfig.toJson());
  }

  /// Expose env config for isolate usage.
  static String get envConfigJson => _envConfigJson;

  PolygonIdCore();

  /// Calls a native core [function], handles errors, and returns the parsed
  /// result of type [T].
  ///
  /// If [onError] is provided it is called with the error message just before
  /// the [CoreLibraryException] is thrown (useful for logging/tracking).
  T callGenericCoreFunction<T>({
    required String Function() input,
    String? config,
    required GenericPolygonIdFunction function,
    required String methodName,
    void Function(String errorMessage)? onError,
    required T Function(String) parse,
  }) {
    final response = malloc<ffi.Pointer<ffi.Char>>();
    final status = malloc<ffi.Pointer<PLGNStatus>>();

    try {
      final resultCode = _invokeNative(
        response: response,
        status: status,
        input: input(),
        config: config ?? _envConfigJson,
        function: function,
      );

      _handleStatusCode(
        resultCode: resultCode,
        status: status,
        methodName: methodName,
        onError: onError,
      );

      return _parseResponse(response, methodName, parse);
    } finally {
      malloc.free(response);
      malloc.free(status);
    }
  }

  /// Calls a native core function that has no response pointer (void return
  /// semantics). Throws [CoreLibraryException] on error.
  ///
  /// [input] and [config] are optional Dart strings that are automatically
  /// converted to native pointers (or `nullptr` when `null`) and passed to
  /// the [function] callback so subclasses never need to import `dart:ffi`.
  void callVoidCoreFunction({
    String? input,
    String? config,
    required int Function(
      ffi.Pointer<ffi.Char> input,
      ffi.Pointer<ffi.Char> config,
      ffi.Pointer<ffi.Pointer<PLGNStatus>> status,
    )
    function,
    required String methodName,
    void Function(String errorMessage)? onError,
  }) {
    final status = malloc<ffi.Pointer<PLGNStatus>>();

    try {
      final resultCode = function(
        _toNativeChar(input),
        _toNativeChar(config),
        status,
      );

      _handleStatusCode(
        resultCode: resultCode,
        status: status,
        methodName: methodName,
        onError: onError,
      );
    } finally {
      malloc.free(status);
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Converts a nullable Dart [String] to a native `Pointer<Char>`.
  /// Returns `nullptr` when [value] is `null`.
  static ffi.Pointer<ffi.Char> _toNativeChar(String? value) =>
      value == null ? ffi.nullptr : value.toNativeUtf8().cast<ffi.Char>();

  /// Invokes the native FFI [function] and returns the raw integer status code.
  int _invokeNative({
    required ffi.Pointer<ffi.Pointer<ffi.Char>> response,
    required ffi.Pointer<ffi.Pointer<PLGNStatus>> status,
    required String input,
    required String config,
    required GenericPolygonIdFunction function,
  }) {
    final inputPointer = input.toNativeUtf8().cast<ffi.Char>();
    final cfgPointer = config.toNativeUtf8().cast<ffi.Char>();
    return function(response, inputPointer, cfgPointer, status);
  }

  /// Status codes that indicate a credential status resolve error.
  static const _credentialStatusResolveStatusCodes = {
    PLGNStatusCode.PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_EXTRACTION_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_RESOLVE_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_MT_BUILD_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_MT_STATE_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_USER_CREDENTIAL_STATUS_REVOKED_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_EXTRACTION_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_RESOLVE_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_MT_BUILD_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_MT_STATE_ERROR,
    PLGNStatusCode.PLGNSTATUSCODE_ISSUER_CREDENTIAL_STATUS_REVOKED_ERROR,
  };

  /// Checks the native [resultCode] and throws [CoreLibraryException] on
  /// failure.
  ///
  /// Native functions return `0` for error and non-zero for success.
  /// The detailed [PLGNStatusCode] is extracted from the [status] struct.
  ///
  /// Throws [CredentialStatusResolveException] for credential-status-related
  /// errors (codes 2–11), and [CoreLibraryException] for all other errors.
  void _handleStatusCode({
    required int resultCode,
    required ffi.Pointer<ffi.Pointer<PLGNStatus>> status,
    required String methodName,
    void Function(String errorMessage)? onError,
  }) {
    if (resultCode == PLGNStatusCode.PLGNSTATUSCODE_NIL_POINTER.value) {
      return; // success
    }

    final consumed = _consumeStatus(status);
    final errorMsg =
        '$_kLibraryName - $methodName: [${consumed.statusCode}] - ${consumed.message}';
    onError?.call(errorMsg);

    if (_credentialStatusResolveStatusCodes.contains(consumed.statusCode)) {
      throw CredentialStatusResolveException(
        coreLibraryName: _kLibraryName,
        methodName: methodName,
        errorMessage: consumed.message,
        statusCode: consumed.statusCode,
      );
    }

    throw CoreLibraryException(
      coreLibraryName: _kLibraryName,
      methodName: methodName,
      errorMessage: consumed.message,
      statusCode: consumed.statusCode,
    );
  }

  /// Decodes the native response pointer into a Dart string and passes it
  /// through [parse].
  T _parseResponse<T>(
    ffi.Pointer<ffi.Pointer<ffi.Char>> response,
    String methodName,
    T Function(String) parse,
  ) {
    final jsonString = response.value.cast<Utf8>();
    if (jsonString == ffi.nullptr) {
      throw CoreLibraryException(
        coreLibraryName: _kLibraryName,
        methodName: 'callCoreFunction.$methodName',
        errorMessage: 'Unable to parse response',
        statusCode: PLGNStatusCode.PLGNSTATUSCODE_ERROR,
      );
    }
    return parse(jsonString.toDartString());
  }

  /// Extracts and frees the native [PLGNStatus], returning a Dart-friendly
  /// result.
  ConsumedStatusResult _consumeStatus(
    ffi.Pointer<ffi.Pointer<PLGNStatus>> status,
  ) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      _logError('unable to allocate status');
      return (
        statusCode: PLGNStatusCode.PLGNSTATUSCODE_ERROR,
        message: 'unable to allocate status',
      );
    }

    final ref = status.value.ref;
    final statusCode = ref.status;
    final errorMessage = _extractErrorMessage(ref);

    _freeStatus(status);
    return (statusCode: statusCode, message: errorMessage);
  }

  /// Reads the error message from a [PLGNStatus] reference, falling back to
  /// the status code string representation.
  String _extractErrorMessage(PLGNStatus ref) {
    if (ref.error_msg == ffi.nullptr) {
      _logError(ref.status.toString());
      return ref.status.toString();
    }

    try {
      final message = ref.error_msg.cast<Utf8>().toDartString();
      _logError('${ref.status} - Error: $message');
      return message;
    } catch (_) {
      _logError(ref.status.toString());
      return ref.status.toString();
    }
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
