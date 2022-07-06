class IdentityException implements Exception {
  final dynamic error;

  IdentityException(this.error);
}

class TooLongPrivateKeyException implements Exception {}
