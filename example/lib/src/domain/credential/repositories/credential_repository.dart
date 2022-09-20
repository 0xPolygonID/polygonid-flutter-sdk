import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';

abstract class CredentialRepository {
  Future<List<ClaimEntity>> fetchAndSavesClaims({required List<CredentialRequestEntity> credentialRequests});
}
