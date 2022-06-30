class InvalidSeedPhraseException implements Exception {
  final String seedPhrase;

  InvalidSeedPhraseException(this.seedPhrase);
}

class IdentityException implements Exception {
  final dynamic error;

  IdentityException(this.error);
}
