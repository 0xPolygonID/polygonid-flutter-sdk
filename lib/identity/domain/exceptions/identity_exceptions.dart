import '../../../../common/domain/error_exception.dart';

class IdentityException extends ErrorException {
  IdentityException(error) : super(error);
}

class TooLongPrivateKeyException implements Exception {}

class UnknownIdentityException implements Exception {
  final String identifier;

  UnknownIdentityException(this.identifier);
}
