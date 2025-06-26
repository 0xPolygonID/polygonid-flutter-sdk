import 'package:polygonid_flutter_sdk/credential/libs/polygonidcore/pidcore_credential.dart';

class CredentialCacheDataSource {
  final PolygonIdCoreCredential _polygonIdCoreCredential;

  CredentialCacheDataSource(this._polygonIdCoreCredential);

  Future<bool> cacheCredential({
    required String credential,
    String? config,
  }) async {
    return _polygonIdCoreCredential.cacheCredential(
      credential,
      config,
    );
  }

  void cleanCache(String? config) {
    return _polygonIdCoreCredential.cleanCache(config);
  }
}
