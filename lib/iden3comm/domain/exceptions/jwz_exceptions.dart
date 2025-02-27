import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class NullJWZHeaderException extends PolygonIdSDKException {
  NullJWZHeaderException({
    required super.errorMessage,
    super.error,
  });
}

class NullJWZProofException extends PolygonIdSDKException {
  NullJWZProofException({
    required super.errorMessage,
    super.error,
  });
}

class NullJWZPayloadException extends PolygonIdSDKException {
  NullJWZPayloadException({
    required super.errorMessage,
    super.error,
  });
}
