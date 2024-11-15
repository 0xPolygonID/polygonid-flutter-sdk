import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class SMTNotFoundException extends PolygonIdSDKException {
  final String storeName;

  SMTNotFoundException({
    required this.storeName,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SMTNodeKeyAlreadyExistsException extends PolygonIdSDKException {
  SMTNodeKeyAlreadyExistsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SMTEntryIndexAlreadyExistsException extends PolygonIdSDKException {
  SMTEntryIndexAlreadyExistsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SMTReachedMaxLevelException extends PolygonIdSDKException {
  SMTReachedMaxLevelException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SMTInvalidNodeFoundException extends PolygonIdSDKException {
  SMTInvalidNodeFoundException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SMTKeyNotFoundException extends PolygonIdSDKException {
  SMTKeyNotFoundException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
