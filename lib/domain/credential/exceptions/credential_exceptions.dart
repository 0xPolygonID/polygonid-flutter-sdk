import '../../common/error_exception.dart';

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
