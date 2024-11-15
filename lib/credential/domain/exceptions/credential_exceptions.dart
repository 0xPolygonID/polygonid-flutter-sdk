import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ClaimNotFoundException extends PolygonIdSDKException {
  final String id;

  ClaimNotFoundException({
    required this.id,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class ClaimWrongIdentityException extends PolygonIdSDKException {
  final String identifier;

  ClaimWrongIdentityException({
    required this.identifier,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class SaveClaimException extends PolygonIdSDKException {
  SaveClaimException({required String errorMessage, dynamic error})
      : super(errorMessage: errorMessage, error: error);
}

class GetClaimsException extends PolygonIdSDKException {
  GetClaimsException({required String errorMessage, dynamic error})
      : super(errorMessage: errorMessage, error: error);
}

class RemoveClaimsException extends PolygonIdSDKException {
  RemoveClaimsException({required String errorMessage, dynamic error})
      : super(errorMessage: errorMessage, error: error);
}

class UpdateClaimException extends PolygonIdSDKException {
  UpdateClaimException({required String errorMessage, dynamic error})
      : super(errorMessage: errorMessage, error: error);
}

class NullRevocationStatusException extends PolygonIdSDKException {
  final ClaimEntity claim;

  NullRevocationStatusException({
    required this.claim,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class RefreshCredentialException extends PolygonIdSDKException {
  RefreshCredentialException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
