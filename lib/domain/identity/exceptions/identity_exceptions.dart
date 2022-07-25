class IdentityException implements Exception {
  final dynamic error;

  IdentityException(this.error);
}

class TooLongPrivateKeyException implements Exception {}

class UnknownIdentityException implements Exception {
  final String identifier;

  UnknownIdentityException(this.identifier);
}
