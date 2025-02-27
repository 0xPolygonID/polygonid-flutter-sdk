import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ClaimNotFoundException extends PolygonIdSDKException {
  final String id;

  ClaimNotFoundException({
    required this.id,
    required super.errorMessage,
    super.error,
  });
}

class ClaimWrongIdentityException extends PolygonIdSDKException {
  final String identifier;

  ClaimWrongIdentityException({
    required this.identifier,
    required super.errorMessage,
    super.error,
  });
}

class SaveClaimException extends PolygonIdSDKException {
  SaveClaimException({required super.errorMessage, super.error});
}

class GetClaimsException extends PolygonIdSDKException {
  GetClaimsException({required super.errorMessage, super.error});
}

class RemoveClaimsException extends PolygonIdSDKException {
  RemoveClaimsException({required super.errorMessage, super.error});
}

class UpdateClaimException extends PolygonIdSDKException {
  UpdateClaimException({required super.errorMessage, super.error});
}

class NullRevocationStatusException extends PolygonIdSDKException {
  final ClaimEntity claim;

  NullRevocationStatusException({
    required this.claim,
    required super.errorMessage,
    super.error,
  });
}

class RefreshCredentialException extends PolygonIdSDKException {
  RefreshCredentialException({
    required super.errorMessage,
    super.error,
  });
}
