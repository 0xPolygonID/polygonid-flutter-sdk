import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk_example/src/data/identitity/data_sources/polygonid_sdk_identity_data_source.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final PolygonIdSdkIdentityDataSource _polygonIdSdkIdentityDataSource;

  IdentityRepositoryImpl(this._polygonIdSdkIdentityDataSource);

  @override
  Future<String> createIdentity({String? privateKey}) async {
    try {
      String identifier = await _polygonIdSdkIdentityDataSource.createIdentity(privateKey: privateKey);
      return identifier;
    } catch (error) {
      throw IdentityException(error);
    }
  }

  @override
  Future<String?> getCurrentIdentifier({String? privateKey}) async {
    String? identifier = await _polygonIdSdkIdentityDataSource.getIdentifier();
    return identifier;
  }
}
