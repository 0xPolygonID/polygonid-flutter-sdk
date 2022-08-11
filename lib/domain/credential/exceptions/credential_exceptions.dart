class FetchClaimException implements Exception {
  final dynamic error;

  FetchClaimException(this.error);
}

class UnsupportedFetchClaimTypeException implements Exception {
  final dynamic error;

  UnsupportedFetchClaimTypeException(this.error);
}

class SaveClaimException implements Exception {
  final dynamic error;

  SaveClaimException(this.error);
}
