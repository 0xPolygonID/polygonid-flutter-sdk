class NetworkException implements Exception {
  final dynamic error;

  NetworkException(this.error);
}

class UnknownApiException implements Exception {
  int httpCode;

  UnknownApiException(this.httpCode);
}

class ItemNotFoundException implements Exception {
  String message;

  ItemNotFoundException(this.message);
}

class InternalServerErrorException implements Exception {
  String message;

  InternalServerErrorException(this.message);
}

class ConflictErrorException implements Exception {
  String message;

  ConflictErrorException(this.message);
}

class BadRequestException implements Exception {
  String message;

  BadRequestException(this.message);
}
