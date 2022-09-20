import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/http.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_proofs/credential_proof_bjj_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_proofs/credential_proof_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/revocation_status.dart';
import 'package:polygonid_flutter_sdk/identity/libs/iden3core/iden3core.dart';
import 'package:polygonid_flutter_sdk/proof_generation/data/dtos/atomic_query_inputs_param.dart';

@injectable
class AtomicQueryInputsWrapper {
  final Iden3CoreLib _iden3coreLib;

  AtomicQueryInputsWrapper(this._iden3coreLib);

  ///
  Future<String?> queryInputsFromMTP(
      AtomicQueryInputsParam atomicQueryInputsParam) async {
    return await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
  }

  ///
  Future<String?> queryInputsFromSIG(
      {required AtomicQueryInputsParam atomicQueryInputsParam,
      required CredentialDTO credential}) async {
    String? queryInputs;
    if (credential.proofs.isNotEmpty) {
      for (var proof in credential.proofs) {
        if (proof.type == CredentialProofType.bjj) {

          CredentialProofBJJDTO proofBJJ = proof as CredentialProofBJJDTO;

          CredentialProofIssuerBJJDTO issuerBJJ =
              proofBJJ.issuer as CredentialProofIssuerBJJDTO;

          // revocation status
          final authRes = await get(issuerBJJ.revocationStatus, "");
          String authRevStatus = (authRes.body);
          final RevocationStatus authRevocationStatus =
              RevocationStatus.fromJson(json.decode(authRevStatus));
          atomicQueryInputsParam.authRevocationStatus = authRevocationStatus;
          queryInputs =
              await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
          break;
        }
      }
    }
    return queryInputs;
  }

  ///
  Future<String> _computeAtomicQueryInputs(AtomicQueryInputsParam param) {
    String result;

    switch (param.type) {
      case AtomicQueryInputsType.mtp:
        result = _iden3coreLib.prepareAtomicQueryMTPInputs(
            param.challenge,
            param.pubX,
            param.pubY,
            param.signature,
            param.credential,
            param.jsonLDDocument,
            param.schema,
            param.claimType,
            param.key,
            param.values,
            param.operator,
            param.revocationStatus);
        break;

      case AtomicQueryInputsType.sig:
        result = _iden3coreLib.prepareAtomicQuerySigInputs(
            param.challenge,
            param.pubX,
            param.pubY,
            param.signature,
            param.credential,
            param.jsonLDDocument,
            param.schema,
            param.claimType,
            param.key,
            param.values,
            param.operator,
            param.revocationStatus,
            param.authRevocationStatus!);
        break;
    }

    return Future.value(result);
  }
}

///
class AtomicQueryInputsDataSource {
  final AtomicQueryInputsWrapper _atomicQueryInputsWrapper;

  AtomicQueryInputsDataSource(this._atomicQueryInputsWrapper);

  ///
  Future<String?> prepareAtomicQueryInputs(
    String challenge,
    String privateKey,
    CredentialDTO credential,
    String circuitId,
    String claimType,
    String key,
    List<int> values,
    int operator,
    String revStatusUrl,
    String pubX,
    String pubY,
    String? signature,
  ) async {
    if (signature == null) return null;

    // schema
    String schemaId = credential.credentialSchema.id;
    String schemaUrl = schemaId;
    if (schemaId.toLowerCase().startsWith("ipfs://")) {
      String fileHash = schemaId.toLowerCase().replaceFirst("ipfs://", "");
      schemaUrl = "https://ipfs.io/ipfs/$fileHash";
    }
    var uri = Uri.parse(schemaUrl);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    // revocation status
    res = await get(revStatusUrl, "");
    String revStatus = (res.body);
    final RevocationStatus claimRevocationStatus =
        RevocationStatus.fromJson(json.decode(revStatus));
    String? queryInputs;
    if (circuitId == "credentialAtomicQueryMTP") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(
          AtomicQueryInputsType.mtp,
          challenge,
          pubX,
          pubY,
          signature,
          credential,
          json.encode(credential.toJson()),
          schema,
          claimType,
          key,
          values,
          operator,
          claimRevocationStatus);
      queryInputs = await _atomicQueryInputsWrapper
          .queryInputsFromMTP(atomicQueryInputsParam);
    } else if (circuitId == "credentialAtomicQuerySig") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(
          AtomicQueryInputsType.sig,
          challenge,
          pubX,
          pubY,
          signature,
          credential,
          json.encode(credential.toJson()),
          schema,
          claimType,
          key,
          values,
          operator,
          claimRevocationStatus);
      // Issuer auth claim revocation status
      queryInputs = await _atomicQueryInputsWrapper.queryInputsFromSIG(
          atomicQueryInputsParam: atomicQueryInputsParam,
          credential: credential);
    }

    return queryInputs;
  }
}
