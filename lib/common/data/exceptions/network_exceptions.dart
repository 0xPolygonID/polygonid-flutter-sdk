import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class NetworkException extends PolygonIdSDKException {
  final int statusCode;

  NetworkException({
    required this.statusCode,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class UnknownApiException extends PolygonIdSDKException {
  final int httpCode;

  UnknownApiException({
    required this.httpCode,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class ItemNotFoundException extends PolygonIdSDKException {
  ItemNotFoundException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class InternalServerErrorException extends PolygonIdSDKException {
  InternalServerErrorException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class ConflictErrorException extends PolygonIdSDKException {
  ConflictErrorException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class BadRequestException extends PolygonIdSDKException {
  BadRequestException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
