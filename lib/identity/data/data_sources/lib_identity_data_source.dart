import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_credential_proof.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/revocation_status.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/atomic_query_inputs_param.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/common/http.dart';

import '../../../common/utils/hex_utils.dart';
import '../../libs/iden3core/iden3core.dart';

class LibIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;
  final WalletDataSource _walletDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;

  LibIdentityDataSource(
    this._iden3coreLib,
    this._walletDataSource,
    this._storageIdentityDataSource,
  );

  Future<String> getIdentifier({required String pubX, required String pubY}) {
    try {
      Map<String, String> map = _iden3coreLib.generateIdentity(pubX, pubY);
      Uint8List hex = HexUtils.hexToBytes(map['id']!);

      return Future.value(Base58Encode(hex));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> getAuthClaim({required String pubX, required String pubY}) {
    try {
      String authClaim = _iden3coreLib.getAuthClaim(pubX, pubY);

      return Future.value(authClaim);
    } catch (e) {
      return Future.error(e);
    }
  }

  ///
  Future<String?> prepareAtomicQueryInputs(
    String challenge,
    String privateKey,
    CredentialData credential,
    String circuitId,
    String claimType,
    String key,
    List<int> values,
    int operator,
    String revStatusUrl,
  ) async {
    PrivadoIdWallet wallet = await _walletDataSource.createWallet(privateKey: HexUtils.hexToBytes(privateKey));

    String signatureString;
    try {
      signatureString = await _walletDataSource.signMessage(privateKey: HexUtils.hexToBytes(privateKey), message: challenge);
    } catch (e) {
      return null;
    }

    // schema
    var uri = Uri.parse(credential.credential!.credentialSchema!.id!);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    // revocation status
    res = await get(revStatusUrl, "");
    String revStatus = (res.body);
    final RevocationStatus claimRevocationStatus = RevocationStatus.fromJson(json.decode(revStatus));
    String? queryInputs;
    if (circuitId == "credentialAtomicQueryMTP") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(AtomicQueryInputsType.mtp, challenge, wallet.publicKey[0], wallet.publicKey[1], signatureString, credential.credential!, json.encode(credential.credential!.toJson()), schema, claimType, key, values, operator, claimRevocationStatus);
      queryInputs = await _queryInputsFromMTP(atomicQueryInputsParam);
    } else if (circuitId == "credentialAtomicQuerySig") {
      var atomicQueryInputsParam = AtomicQueryInputsParam(AtomicQueryInputsType.sig, challenge, wallet.publicKey[0], wallet.publicKey[1], signatureString, credential.credential!, json.encode(credential.credential!.toJson()), schema, claimType, key, values, operator, claimRevocationStatus);
      // Issuer auth claim revocation status
      queryInputs = await _queryInputsFromSIG(atomicQueryInputsParam: atomicQueryInputsParam, credential: credential);
    }

    return queryInputs;
  }

  ///
  Future<String?> _queryInputsFromMTP(AtomicQueryInputsParam atomicQueryInputsParam) async {
    return await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
  }

  ///
  Future<String?> _queryInputsFromSIG({required AtomicQueryInputsParam atomicQueryInputsParam, required CredentialData credential}) async {
    String? queryInputs;
    if (credential.credential!.proof != null && credential.credential!.proof!.isNotEmpty) {
      for (var proof in credential.credential!.proof!) {
        if (proof.type == CredentialCredentialProofType.BJJSignature2021.name) {
          // revocation status
          final authRes = await get(proof.issuer_data!.revocation_status!, "");
          String authRevStatus = (authRes.body);
          final RevocationStatus authRevocationStatus = RevocationStatus.fromJson(json.decode(authRevStatus));
          atomicQueryInputsParam.authRevocationStatus = authRevocationStatus;
          queryInputs = await compute(_computeAtomicQueryInputs, atomicQueryInputsParam);
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
        result = _iden3coreLib.prepareAtomicQueryMTPInputs(param.challenge, param.pubX, param.pubY, param.signature, param.credential, param.jsonLDDocument, param.schema, param.claimType, param.key, param.values, param.operator, param.revocationStatus);
        break;

      case AtomicQueryInputsType.sig:
        result = _iden3coreLib.prepareAtomicQuerySigInputs(param.challenge, param.pubX, param.pubY, param.signature, param.credential, param.jsonLDDocument, param.schema, param.claimType, param.key, param.values, param.operator, param.revocationStatus, param.authRevocationStatus!);
        break;
    }

    return Future.value(result);
  }
}
