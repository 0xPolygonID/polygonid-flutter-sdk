import 'dart:convert';

import '../../../constants.dart';
import 'lib_pidcore_credential_data_source.dart';

class LocalClaimDataSource {
  LibPolygonIdCoreCredentialDataSource _libPolygonIdCoreCredentialDataSource;

  LocalClaimDataSource(this._libPolygonIdCoreCredentialDataSource);

  Future<List<String>> getAuthClaim({
    required List<String> publicKey,
    String? authClaimNonce,
  }) {
    final nonce = authClaimNonce ?? DEFAULT_AUTH_CLAIM_NONCE;

    String authClaimSchema = AUTH_CLAIM_SCHEMA;
    String authClaim = _libPolygonIdCoreCredentialDataSource.issueClaim(
      schema: authClaimSchema,
      nonce: nonce,
      publicKey: publicKey,
    );
    List<String> children = List.from(jsonDecode(authClaim));
    return Future.value(children);
  }
}
