import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import '../../libs/polygonidcore/pidcore_credential.dart';

class LibPolygonIdCoreCredentialDataSource {
  final PolygonIdCoreCredential _polygonIdCoreCredential;

  LibPolygonIdCoreCredentialDataSource(
    this._polygonIdCoreCredential,
  );

  /// - schema - schema hash hex string
  /// - nonce - nonce as big int string
  String issueClaim({
    required String schema,
    required String nonce,
    required List<String> publicKey,
  }) {
    String input = jsonEncode({
      "schema": schema, //"ca938857241db9451ea329256b9c06e5",
      "nonce": nonce, //"15930428023331155902",
      "indexSlotA": publicKey[0],
      "indexSlotB": publicKey[1],
    });

    String output = _polygonIdCoreCredential.createClaim(input);

    logger().d("issueAuthClaim: $output");
    return output;
  }

  String? cacheCredentials(String input, String? config) {
    return _polygonIdCoreCredential.cacheCredentials(input, config);
  }

  String? w3cCredentialsFromOnchainHex({
    required String issuerDID,
    required String hexdata,
    required String version,
    String? config,
  }) {
    return _polygonIdCoreCredential.w3cCredentialsFromOnchainHex(
      jsonEncode({
        "issuerDID": issuerDID,
        "hexdata": hexdata,
        "version": version,
      }),
      config,
    );
  }
}
