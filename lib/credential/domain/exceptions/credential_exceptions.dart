import '../../../common/domain/error_exception.dart';

class ClaimNotFoundException implements Exception {
  final String id;

  ClaimNotFoundException(this.id);
}

class FetchClaimException extends ErrorException {
  FetchClaimException(error) : super(error);
}

class UnsupportedFetchClaimTypeException extends ErrorException {
  UnsupportedFetchClaimTypeException(error) : super(error);
}

class SaveClaimException extends ErrorException {
  SaveClaimException(error) : super(error);
}

class GetClaimsException extends ErrorException {
  GetClaimsException(error) : super(error);
}

class RemoveClaimsException extends ErrorException {
  RemoveClaimsException(error) : super(error);
}

class UpdateClaimException extends ErrorException {
  UpdateClaimException(error) : super(error);
}

class FetchSchemaException extends ErrorException {
  FetchSchemaException(error) : super(error);
}

class FetchVocabException extends ErrorException {
  FetchVocabException(error) : super(error);
}

class FetchIdentityStateException extends ErrorException {
  FetchIdentityStateException(error) : super(error);
}

class FetchStateRootsException extends ErrorException {
  FetchStateRootsException(error) : super(error);
}

class UnsupportedSchemaFetchVocabException extends ErrorException {
  UnsupportedSchemaFetchVocabException(error) : super(error);
}
