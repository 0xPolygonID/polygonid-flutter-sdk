class PolygonIdSDKException implements Exception {
  final dynamic error;
  final String errorMessage;

  PolygonIdSDKException({
    this.error,
    required this.errorMessage,
  });

  @override
  String toString() {
    return errorMessage;
  }
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

  @override
  String toString() {
    return "[$coreLibraryName] [$methodName] $errorMessage";
  }
}
