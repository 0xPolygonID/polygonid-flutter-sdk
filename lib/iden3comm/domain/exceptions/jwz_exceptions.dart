import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class NullJWZHeaderException extends PolygonIdSDKException {
  NullJWZHeaderException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullJWZProofException extends PolygonIdSDKException {
  NullJWZProofException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullJWZPayloadException extends PolygonIdSDKException {
  NullJWZPayloadException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
