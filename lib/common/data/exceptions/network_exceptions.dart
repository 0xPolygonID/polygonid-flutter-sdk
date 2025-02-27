import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class NetworkException extends PolygonIdSDKException {
  final int statusCode;

  NetworkException({
    required this.statusCode,
    required super.errorMessage,
    super.error,
  });
}

class UnknownApiException extends PolygonIdSDKException {
  final int httpCode;

  UnknownApiException({
    required this.httpCode,
    required super.errorMessage,
    super.error,
  });
}

class ItemNotFoundException extends PolygonIdSDKException {
  ItemNotFoundException({
    required super.errorMessage,
    super.error,
  });
}

class InternalServerErrorException extends PolygonIdSDKException {
  InternalServerErrorException({
    required super.errorMessage,
    super.error,
  });
}

class ConflictErrorException extends PolygonIdSDKException {
  ConflictErrorException({
    required super.errorMessage,
    super.error,
  });
}

class BadRequestException extends PolygonIdSDKException {
  BadRequestException({
    required super.errorMessage,
    super.error,
  });
}
