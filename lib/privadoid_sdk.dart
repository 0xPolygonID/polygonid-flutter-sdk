import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/http.dart';
import 'package:polygonid_flutter_sdk/model/revocation_status.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/sdk/identity_wallet.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/utils/hex_utils.dart';

import 'libs/iden3corelib.dart';
import 'model/credential_credential.dart';
import 'model/credential_data.dart';

enum AtomicQueryInputsType { mtp, sig }

class AtomicQueryInputsParam {
  final AtomicQueryInputsType type;
  final String challenge;
  final String pubX;
  final String pubY;
  final String signature;
  final CredentialCredential credential;
  final String jsonLDDocument;
  final String schema;
  final String claimType;
  final String key;
  final List<int> values;
  final int operator;
  final RevocationStatus revocationStatus;
  RevocationStatus? authRevocationStatus;

  AtomicQueryInputsParam(
      this.type,
      this.challenge,
      this.pubX,
      this.pubY,
      this.signature,
      this.credential,
      this.jsonLDDocument,
      this.schema,
      this.claimType,
      this.key,
      this.values,
      this.operator,
      this.revocationStatus,
      [this.authRevocationStatus]);
}

enum WitnessType { def, mtp, sig }

class WitnessParam {
  final WitnessType type;
  final Uint8List wasm;
  final Uint8List json;

  WitnessParam(this.type, this.wasm, this.json);
}

class ProveParam {
  final Uint8List zKey;
  final Uint8List wtns;

  ProveParam(this.zKey, this.wtns);
}

/// TODO: replace this class by CA little by little
/// The only entrypoint to the SDK should be [PolygonIdSdk]
class PrivadoIdSdk {
  static IdentityWallet get _identityWallet {
    return PolygonIdSdk.I.identity;
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
    final String? identifier = await _identityWallet.getCurrentIdentifier();

    String signatureString =
        await _identityWallet.sign(identifier: identifier!, message: challenge);

    // schema
    var uri = Uri.parse(credential.credential!.credentialSchema!.id!);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    // revocation status
    res = await get(revStatusUrl, "");
    String revStatus = (res.body);
    final RevocationStatus claimRevocationStatus =
        RevocationStatus.fromJson(json.decode(revStatus));
    String? queryInputs;
    if (circuitId == "credentialAtomicQueryMTP") {
      queryInputs = await compute(
          _computeAtomicQueryInputs,
          AtomicQueryInputsParam(
              AtomicQueryInputsType.mtp,
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
              claimRevocationStatus));
    } else if (circuitId == "credentialAtomicQuerySig") {
      // Issuer auth claim revocation status
      // TODO: !!!! make sure that proof[0] is signature proof

      // revocation status
      final authRes = await get(
          credential.credential!.proof![0].issuer_data!.revocation_status!, "");
      String authRevStatus = (authRes.body);
      final RevocationStatus authRevocationStatus =
          RevocationStatus.fromJson(json.decode(authRevStatus));

      queryInputs = await compute(
          _computeAtomicQueryInputs,
          AtomicQueryInputsParam(
              AtomicQueryInputsType.sig,
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
              claimRevocationStatus,
              authRevocationStatus));
    }

    return queryInputs;
  }

  static Future<String> _computeAtomicQueryInputs(
      AtomicQueryInputsParam param) {
    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    String result;

    switch (param.type) {
      case AtomicQueryInputsType.mtp:
        result = iden3coreLib.prepareAtomicQueryMTPInputs(
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
        result = iden3coreLib.prepareAtomicQuerySigInputs(
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

  static Future<Uint8List?> calculateWitness(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return compute(_computeWitness,
        WitnessParam(WitnessType.def, wasmBytes, inputsJsonBytes));
  }

  static Future<Uint8List?> calculateWitnessSig(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return compute(_computeWitness,
        WitnessParam(WitnessType.sig, wasmBytes, inputsJsonBytes));
  }

  static Future<Uint8List?> calculateWitnessMtp(
      Uint8List wasmBytes, Uint8List inputsJsonBytes) {
    return compute(_computeWitness,
        WitnessParam(WitnessType.mtp, wasmBytes, inputsJsonBytes));
  }

  static Future<Uint8List?> _computeWitness(WitnessParam param) {
    Iden3CoreLib iden3coreLib = Iden3CoreLib();

    switch (param.type) {
      case WitnessType.def:
        return iden3coreLib.calculateWitness(param.wasm, param.json);
      case WitnessType.mtp:
        return iden3coreLib.calculateWitnessMtp(param.wasm, param.json);
      case WitnessType.sig:
        return iden3coreLib.calculateWitnessSig(param.wasm, param.json);
    }
  }

  static Future<Map<String, dynamic>?> prover(
      Uint8List zKeyBytes, Uint8List wtnsBytes) async {
    return compute(_computeProve, ProveParam(zKeyBytes, wtnsBytes));
  }

  static Future<Map<String, dynamic>?> _computeProve(ProveParam param) {
    Iden3CoreLib iden3coreLib = Iden3CoreLib();

    return iden3coreLib.prove(param.zKey, param.wtns);
  }
//
// static Future<JWZToken> generateJWZToken(String payload, String identifier, Uint8List zKeyBytes, Uint8List datFile) async {
//   var preparer = JWZPreparer(
//       identifier: identifier);
//   var prover = JWZProverImpl(alg: "groth16", circuitID: "auth");
//   var jwztoken = JWZToken.withJWZ(
//       jwz: JWZ(
//           header: JWZHeader(
//               circuitId: "auth",
//               crit: const ["circuitId"],
//               typ: "application/iden3-zkp-json",
//               alg: "groth16"),
//           payload: JWZPayload(payload: payload)),
//       prover: prover,
//       preparer: preparer);
//   String encodedjwz = await jwztoken.prove(zKeyBytes, datFile);
//   if (kDebugMode) {
//     print(encodedjwz);
//   }
//   return jwztoken;
// }
}
