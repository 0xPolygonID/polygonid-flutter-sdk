import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/data/credential/data_sources/polygonid_sdk_credential_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/repositories/credential_repository.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final PolygonSdkCredentialDataSource _polygonSdkCredentialDataSource;

  CredentialRepositoryImpl(this._polygonSdkCredentialDataSource);



  @override
  Future<List<ClaimEntity>> fetchAndSavesClaims({required List<CredentialRequestEntity> credentialRequests}) {
    return _polygonSdkCredentialDataSource.fetchAndSaveClaims(credentialRequests: credentialRequests);
  }
}
