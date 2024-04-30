import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ClaimNotFoundException implements PolygonIdSDKException {
  final String id;
  dynamic error;
  final String errorMessage;

  ClaimNotFoundException({
    required this.id,
    this.error,
    required this.errorMessage,
  });
}

class ClaimWrongIdentityException implements PolygonIdSDKException {
  final String identifier;
  dynamic error;
  final String errorMessage;

  ClaimWrongIdentityException({
    required this.identifier,
    this.error,
    required this.errorMessage,
  });
}

class SaveClaimException extends PolygonIdSDKException {
  SaveClaimException(String errorMessage, [dynamic error])
      : super(errorMessage: errorMessage, error: error);
}

class GetClaimsException extends PolygonIdSDKException {
  GetClaimsException(String errorMessage, [dynamic error])
      : super(errorMessage: errorMessage, error: error);
}

class RemoveClaimsException extends PolygonIdSDKException {
  RemoveClaimsException(String errorMessage, [dynamic error])
      : super(errorMessage: errorMessage, error: error);
}

class UpdateClaimException extends PolygonIdSDKException {
  UpdateClaimException(String errorMessage, [dynamic error])
      : super(errorMessage: errorMessage, error: error);
}

class NullRevocationStatusException implements PolygonIdSDKException {
  final ClaimEntity claim;
  dynamic error;
  final String errorMessage;

  NullRevocationStatusException({
    required this.claim,
    this.error,
    required this.errorMessage,
  });
}

class RefreshCredentialException extends PolygonIdSDKException {
  RefreshCredentialException(String errorMessage, [dynamic error])
      : super(errorMessage: errorMessage, error: error);
}
