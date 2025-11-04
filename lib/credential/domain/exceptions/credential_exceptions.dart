import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';

typedef ClaimNotFoundException = CredentialNotFoundException;

class CredentialNotFoundException extends PolygonIdSDKException {
  final String id;

  CredentialNotFoundException({
    required this.id,
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
  final CredentialDTO credential;

  NullRevocationStatusException({
    required this.credential,
    required super.errorMessage,
    super.error,
  });
}

class RefreshCredentialException extends PolygonIdSDKException {
  RefreshCredentialException({required super.errorMessage, super.error});
}
