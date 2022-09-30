import 'package:polygonid_flutter_sdk_example/src/data/identitity/data_sources/polygonid_sdk_identity_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final PolygonIdSdkIdentityDataSource _polygonIdSdkIdentityDataSource;

  IdentityRepositoryImpl(this._polygonIdSdkIdentityDataSource);

  @override
  Future<String> createIdentity() {
    return _polygonIdSdkIdentityDataSource.createIdentity();
  }

  @override
  Future<String?> getCurrentIdentifier() {
    return _polygonIdSdkIdentityDataSource.getIdentifier();
  }
}
