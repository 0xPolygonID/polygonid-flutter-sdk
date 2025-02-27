import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class SMTNotFoundException extends PolygonIdSDKException {
  final String storeName;

  SMTNotFoundException({
    required this.storeName,
    required super.errorMessage,
    super.error,
  });
}

class SMTNodeKeyAlreadyExistsException extends PolygonIdSDKException {
  SMTNodeKeyAlreadyExistsException({
    required super.errorMessage,
    super.error,
  });
}

class SMTEntryIndexAlreadyExistsException extends PolygonIdSDKException {
  SMTEntryIndexAlreadyExistsException({
    required super.errorMessage,
    super.error,
  });
}

class SMTReachedMaxLevelException extends PolygonIdSDKException {
  SMTReachedMaxLevelException({
    required super.errorMessage,
    super.error,
  });
}

class SMTInvalidNodeFoundException extends PolygonIdSDKException {
  SMTInvalidNodeFoundException({
    required super.errorMessage,
    super.error,
  });
}

class SMTKeyNotFoundException extends PolygonIdSDKException {
  SMTKeyNotFoundException({
    required super.errorMessage,
    super.error,
  });
}
