class SMTNotFoundException implements Exception {
  final String storeName;

  SMTNotFoundException(this.storeName);
}

class SMTNodeKeyAlreadyExistsException implements Exception {}

class SMTEntryIndexAlreadyExistsException implements Exception {}

class SMTReachedMaxLevelException implements Exception {}

class SMTInvalidNodeFoundException implements Exception {}

class SMTKeyNotFoundException implements Exception {}
