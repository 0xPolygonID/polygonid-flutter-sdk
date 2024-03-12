class ErrorException implements Exception {
  final dynamic error;

  ErrorException(this.error);
}

class PolygonIdSDKException implements Exception {
  final dynamic error;
  final String errorMessage;

  PolygonIdSDKException({
    this.error,
    required this.errorMessage,
  });
}
