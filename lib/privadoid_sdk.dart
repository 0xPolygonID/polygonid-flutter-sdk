import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/http.dart';
import 'package:polygonid_flutter_sdk/jwz/jwz_preparer.dart';
import 'package:polygonid_flutter_sdk/model/revocation_status.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/utils/hex_utils.dart';

import 'jwz/jwz_prover.dart';
import 'jwz/jwz_token.dart';
import 'libs/iden3corelib.dart';
import 'model/credential_data.dart';
import 'model/jwz/jwz.dart';
import 'model/jwz/jwz_header.dart';

class PrivadoIdSdk {
  static Iden3CoreLib get _iden3coreLib {
    return Iden3CoreLib();
  }

  static Future<String?> prepareAuthInputs(
      String challenge, String privateKey, String authClaim) async {
    if (kDebugMode) {
      print("CHALLENGE  $challenge");
    }
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));
    String signatureString = wallet.signMessage(challenge);

    /*String? genesisId = await getIdentifier(privateKey);
    if (kDebugMode) {
      print("GENESIS ID :${genesisId!}");
    }*/

    var authInputs = _iden3coreLib.prepareAuthInputs(challenge, authClaim,
        wallet.publicKey[0], wallet.publicKey[1], signatureString);

    return authInputs;
  }

  static Future<String?> prepareAtomicQueryInputs(
      String challenge,
      String privateKey,
      CredentialData credential,
      String circuitId,
      String claimType,
      String key,
      List<int> values,
      int operator,
      String revStatusUrl) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String signatureString = wallet.signMessage(challenge);

    // schema
    var uri = Uri.parse(credential.credential!.credentialSchema!.id!);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    // revocation status
    res = await get(revStatusUrl, "");
    String revStatus = (res.body);
    final RevocationStatus claimRevocaitonStatus =
        RevocationStatus.fromJson(json.decode(revStatus));
    String? queryInputs;
    if (circuitId == "credentialAtomicQueryMTP") {
      queryInputs = _iden3coreLib.prepareAtomicQueryMTPInputs(
          challenge,
          wallet.publicKey[0],
          wallet.publicKey[1],
          signatureString,
          credential.credential!,
          json.encode(credential.credential!.toJson()),
          schema,
          claimType,
          key,
          values,
          operator,
          claimRevocaitonStatus);
    } else if (circuitId == "credentialAtomicQuerySig") {
      // Issuer auth claim revocation status
      // TODO: !!!! make sure that proof[0] is signature proof

      // revocation status
      final authRes = await get(
          credential.credential!.proof![0].issuer_data!.revocation_status!, "");
      String authRevStatus = (authRes.body);
      final RevocationStatus authRevocationStatus =
          RevocationStatus.fromJson(json.decode(authRevStatus));

      queryInputs = _iden3coreLib.prepareAtomicQuerySigInputs(
          challenge,
          wallet.publicKey[0],
          wallet.publicKey[1],
          signatureString,
          credential.credential!,
          json.encode(credential.credential!.toJson()),
          schema,
          claimType,
          key,
          values,
          operator,
          claimRevocaitonStatus,
          authRevocationStatus);
    }

    return queryInputs;
  }

  static Future<Uint8List?> calculateWitness(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return _iden3coreLib.calculateWitness(wasmBytes, inputsJsonBytes);
  }

  static Future<Uint8List?> calculateWitnessSig(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return _iden3coreLib.calculateWitnessSig(wasmBytes, inputsJsonBytes);
  }

  static Future<Uint8List?> calculateWitnessMtp(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return _iden3coreLib.calculateWitnessMtp(wasmBytes, inputsJsonBytes);
  }

  static Future<Map<String, dynamic>?> prover(
      Uint8List zKeyBytes, Uint8List wtnsBytes) async {
    return _iden3coreLib.prove(zKeyBytes, wtnsBytes);
  }

  static Future<JWZToken> generateJWZToken(String payload, String privateKey,
      String authClaim, Uint8List zKeyBytes, Uint8List datFile) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));
    var preparer = JWZPreparer(
        wallet: wallet, authClaim: authClaim, coreLib: _iden3coreLib);
    var prover = JWZProverImpl(
        alg: "groth16", circuitID: "auth", coreLib: _iden3coreLib);
    var jwztoken = JWZToken.withJWZ(
        jwz: JWZ(
            header: JWZHeader(
                circuitId: "auth",
                crit: const ["circuitId"],
                typ: "application/iden3-zkp-json",
                alg: "groth16"),
            payload: JWZPayload(payload: payload)),
        prover: prover,
        preparer: preparer);
    String encodedjwz = await jwztoken.prove(zKeyBytes, datFile);
    if (kDebugMode) {
      print(encodedjwz);
    }
    return jwztoken;
  }
}
