class PolygonIdSDKException implements Exception {
  final dynamic error;
  final String errorMessage;

  PolygonIdSDKException({
    this.error,
    required this.errorMessage,
  });
}

class CoreLibraryException extends PolygonIdSDKException {
  final String coreLibraryName;
  final String methodName;

  CoreLibraryException({
    required this.coreLibraryName,
    required this.methodName,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
