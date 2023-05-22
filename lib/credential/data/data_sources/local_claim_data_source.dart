import 'dart:convert';

import '../../../constants.dart';
import 'lib_pidcore_credential_data_source.dart';

class LocalClaimDataSource {
  final LibPolygonIdCoreCredentialDataSource
      _libPolygonIdCoreCredentialDataSource;

  LocalClaimDataSource(this._libPolygonIdCoreCredentialDataSource);

  Future<List<String>> getAuthClaim({required List<String> publicKey}) {
    String authClaimSchema = AUTH_CLAIM_SCHEMA;
    String authClaimNonce = "15930428023331155902";
    String authClaim = _libPolygonIdCoreCredentialDataSource.issueClaim(
      schema: authClaimSchema,
      nonce: authClaimNonce,
      publicKey: publicKey,
    );
    List<String> children = List.from(jsonDecode(authClaim));
    return Future.value(children);
  }
}
