import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class PolygonSdkCredentialDataSource {
  final PolygonIdSdk _polygonIdSdk;

  PolygonSdkCredentialDataSource(this._polygonIdSdk);

  ///
  Future<List<ClaimEntity>> fetchAndSaveClaims({required List<CredentialRequestEntity> credentialRequests}) {
    return _polygonIdSdk.credential.fetchAndSaveClaims(credentialRequests: credentialRequests);
  }
}
