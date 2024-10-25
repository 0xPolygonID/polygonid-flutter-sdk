import 'package:polygonid_flutter_sdk/common/libs/polygonidcore/native_polygonidcore.dart';

class ErrorInfo {
  final PLGNStatusCode statusCode;
  final String message;

  ErrorInfo({
    required this.statusCode,
    required this.message,
  });
}

class NativePolygonIdCoreResult<T> {
  final T? value;
  final ErrorInfo? error;

  NativePolygonIdCoreResult.success(this.value) : error = null;

  NativePolygonIdCoreResult.error(
      {required PLGNStatusCode statusCode, required String message})
      : value = null,
        error = ErrorInfo(statusCode: statusCode, message: message);

  bool get isSuccess => error == null;
}
