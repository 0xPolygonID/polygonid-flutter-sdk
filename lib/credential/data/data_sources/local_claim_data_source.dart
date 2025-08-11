import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../constants.dart';
import 'lib_pidcore_credential_data_source.dart';

@singleton
class LocalClaimDataSource {
  final LibPolygonIdCoreCredentialDataSource
      _libPolygonIdCoreCredentialDataSource;

  final _memCache = <String, List<String>>{};

  LocalClaimDataSource(this._libPolygonIdCoreCredentialDataSource);

  Future<List<String>> getAuthClaim({
    required List<String> publicKey,
    String? authClaimNonce,
  }) async {
    // TODO Might be sync
    final nonce = authClaimNonce ?? DEFAULT_AUTH_CLAIM_NONCE;

    final cacheKey = _cacheKey(publicKey.toString(), nonce);
    final cacheValue = _memCache[cacheKey];
    if (cacheValue != null) {
      return cacheValue;
    }

    String authClaimSchema = AUTH_CLAIM_SCHEMA;
    String authClaim = _libPolygonIdCoreCredentialDataSource.issueClaim(
      schema: authClaimSchema,
      nonce: nonce,
      publicKey: publicKey,
    );
    List<String> children = List.from(jsonDecode(authClaim));

    _memCache[cacheKey] = children;

    return children;
  }

  Future<String> coreClaimFromCredential({
    required String credential,
    String? config,
  }) async {
    String coreClaim =
        _libPolygonIdCoreCredentialDataSource.createCoreClaimFromCredential(
      credential: credential,
      config: config,
    );
    return Future.value(coreClaim);
  }
}

String _cacheKey(String publicKey, String nonce) => publicKey + "_" + nonce;
