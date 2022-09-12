/*
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'common/http.dart';
import 'common/utils/hex_utils.dart';
import 'credential/data/dtos/credential_credential.dart';
import 'credential/data/dtos/credential_credential_proof.dart';
import 'credential/data/dtos/credential_data.dart';
import 'credential/data/dtos/revocation_status.dart';
import 'identity/libs/bjj/privadoid_wallet.dart';
import 'identity/libs/iden3core/iden3core.dart';
import 'proof_generation/libs/prover/prover.dart';
import 'proof_generation/libs/witnesscalc/auth/witness_auth.dart';
import 'proof_generation/libs/witnesscalc/mtp/witness_mtp.dart';
import 'proof_generation/libs/witnesscalc/sig/witness_sig.dart';
import 'sdk/identity_wallet.dart';
import 'sdk/polygon_id_sdk.dart';

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
    String signatureString;
    try {
      signatureString = await _identityWallet.sign(
          identifier: identifier!, message: challenge);
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
      if (credential.credential!.proof != null &&
          credential.credential!.proof!.isNotEmpty) {
        for (var proof in credential.credential!.proof!) {
          if (proof.type ==
              CredentialCredentialProofType.BJJSignature2021.name) {
            // revocation status
            final authRes =
                await get(proof.issuer_data!.revocation_status!, "");
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
            break;
          }
        }
      }
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
    switch (param.type) {
      case WitnessType.def:
        WitnessAuthLib witnessAuthLib = WitnessAuthLib();
        return witnessAuthLib.calculateWitnessAuth(param.wasm, param.json);
      case WitnessType.sig:
        WitnessSigLib witnessSigLib = WitnessSigLib();
        return witnessSigLib.calculateWitnessSig(param.wasm, param.json);
      case WitnessType.mtp:
        WitnessMtpLib witnessMtpLib = WitnessMtpLib();
        return witnessMtpLib.calculateWitnessMtp(param.wasm, param.json);
    }
  }

  static Future<Map<String, dynamic>?> prover(
      Uint8List zKeyBytes, Uint8List wtnsBytes) async {
    return compute(_computeProve, ProveParam(zKeyBytes, wtnsBytes));
  }

  static Future<Map<String, dynamic>?> _computeProve(ProveParam param) {
    ProverLib proverLib = ProverLib();
    return proverLib.prove(param.zKey, param.wtns);
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
*/
