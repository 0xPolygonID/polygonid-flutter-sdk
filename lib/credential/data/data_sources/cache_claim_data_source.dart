import 'dart:convert';

import '../../../constants.dart';
import 'lib_pidcore_credential_data_source.dart';

class CacheCredentialDataSource {
  LibPolygonIdCoreCredentialDataSource _libPolygonIdCoreCredentialDataSource;

  CacheCredentialDataSource(this._libPolygonIdCoreCredentialDataSource);

  Future<String?> cacheCredential({
    required String credential,
    String? config,
  }) async {
    return _libPolygonIdCoreCredentialDataSource.cacheCredentials(
      credential,
      config,
    );
  }
}
