import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/self_issuance/self_issued_credential_params.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_param.dart';

import '../../libs/polygonidcore/pidcore_credential.dart';

class LibPolygonIdCoreCredentialDataSource {
  final PolygonIdCoreCredential _polygonIdCoreCredential;

  LibPolygonIdCoreCredentialDataSource(this._polygonIdCoreCredential);

  /// - schema - schema hash hex string
  /// - nonce - nonce as big int string
  String issueClaim({
    required String schema,
    required String nonce,
    required List<String> publicKey,
    Map<String, dynamic> additionalInputParam = const {},
  }) {
    Map<String, dynamic> inputParam = {
      "schema": schema,
      "nonce": nonce,
      "indexSlotA": publicKey[0],
      "indexSlotB": publicKey[1],
    };

    //merge additionInputParam with inputParam removing duplicates
    Map<String, dynamic> inputMerged = {...inputParam, ...additionalInputParam};

    String input = jsonEncode(inputMerged);

    String output = _polygonIdCoreCredential.createClaim(input);

    logger().d("issueAuthClaim: $output");
    return output;
  }

  String getW3CCredentialFromOnchainHex({
    required String issuerDID,
    required String hexdata,
    required String version,
    String? config,
  }) {
    return _polygonIdCoreCredential.getW3CCredentialFromOnchainHex(
      jsonEncode({
        "issuerDID": issuerDID,
        "hexdata": hexdata,
        "version": version,
      }),
      config,
    );
  }

  String createW3CCredentialFromAnonAadhaar({
    required String qrData,
    required int timeNow,
    required String did,
    required SelfIssuedCredentialParams selfIssuedCredentialParams,
    String? config,
  }) {
    // This method accepts same inputs as the proof gen inputs calc
    final param = AnonAadhaarInputsParam.fromSelfIssuedCredentialParams(
      qrData: qrData,
      timeNow: timeNow,
      credentialSubjectID: did,
      params: selfIssuedCredentialParams,
    );

    return _polygonIdCoreCredential.createW3CCredentialFromAnonAadhaarInputs(
      jsonEncode(param.toJson()),
      config,
    );
  }

  String createW3CCredentialFromPassport({
    required String passportData,
    required String dg2Hash,
    required String did,
    required int revocationNonce,
    required String credentialStatusID,
    required String issuerDid,
    required int issuanceDate,
    required String linkNonce,
    required String circuitId,
    String? config,
  }) {
    // This method accepts same inputs as the proof gen inputs calc
    final param = PassportInputsParam(
      passportData: passportData,
      dg2Hash: dg2Hash,
      credentialSubjectID: did,
      revocationNonce: revocationNonce,
      credentialStatusID: credentialStatusID,
      issuerDid: issuerDid,
      issuanceDate: issuanceDate,
      linkNonce: linkNonce,
      circuitId: circuitId,
    );

    return _polygonIdCoreCredential.createW3CCredentialFromPassportInputs(
      jsonEncode(param.toJson()),
      config,
    );
  }

  String createCoreClaimFromCredential({
    required String credential,
    String? config,
  }) {
    return _polygonIdCoreCredential.createCoreClaimFromW3CCredential(
      credential,
      config,
    );
  }

  bool credentialStatusCheck({
    required String issuerDid,
    required String profileDid,
    required Map<String, dynamic> credentialStatus,
    String? config,
  }) {
    final input = jsonEncode({
      'issuer': issuerDid,
      'user': profileDid,
      'credentialStatus': credentialStatus,
    });

    return _polygonIdCoreCredential.credentialStatusCheck(input, config);
  }
}
