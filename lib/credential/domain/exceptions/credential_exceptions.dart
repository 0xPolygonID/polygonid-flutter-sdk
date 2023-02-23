import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import '../../../common/domain/error_exception.dart';

class ClaimNotFoundException implements Exception {
  final String id;

  ClaimNotFoundException(this.id);
}

class ClaimWrongIdentityException implements Exception {
  final String identifier;

  ClaimWrongIdentityException(this.identifier);
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

class NullRevocationStatusException implements Exception {
  final ClaimEntity claim;

  NullRevocationStatusException(this.claim);
}
