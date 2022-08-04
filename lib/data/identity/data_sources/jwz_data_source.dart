import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/libs/circomlib.dart';
import 'package:polygonid_flutter_sdk/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

import '../../../libs/iden3corelib.dart';
import '../jwz/jwz.dart';
import '../jwz/jwz_exceptions.dart';
import '../jwz/jwz_header.dart';
import '../jwz/jwz_proof.dart';
import '../jwz/jwz_token.dart';

class AuthInputsIsolateParam {
  final String challenge;
  final String authClaim;
  final String pubX;
  final String pubY;
  final String signature;

  AuthInputsIsolateParam(
      this.challenge, this.authClaim, this.pubX, this.pubY, this.signature);
}

class CalculateProofIsolateParam {
  final Uint8List inputs;
  final Uint8List provingKey;
  final Uint8List wasm;

  CalculateProofIsolateParam(this.inputs, this.provingKey, this.wasm);
}

/// For UT purpose, we wrap the isolate call into a separate class
@injectable
class JWZIsolatesWrapper {
  Future<String> computeAuthInputs(String challenge, String authClaim,
      String pubX, String pubY, String signature) {
    return compute(_computeAuthInputs,
        AuthInputsIsolateParam(challenge, authClaim, pubX, pubY, signature));
  }

  Future<Map<String, dynamic>?> computeCalculateProof(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm) {
    return compute(_computeCalculateProof,
        CalculateProofIsolateParam(inputs, provingKey, wasm));
  }
}

/// Isolates have to be top level methods or statics

/// As this is running is a separate thread, we cannot inject [Iden3CoreLib]
Future<String> _computeAuthInputs(AuthInputsIsolateParam param) {
  final iden3coreLib = Iden3CoreLib();

  return Future.value(iden3coreLib.prepareAuthInputs(param.challenge,
      param.authClaim, param.pubX, param.pubY, param.signature));
}

/// As this is running is a separate thread, we cannot inject [Iden3CoreLib]
Future<Map<String, dynamic>?> _computeCalculateProof(
    CalculateProofIsolateParam param) {
  final iden3coreLib = Iden3CoreLib();

  return Future.value(
      iden3coreLib.calculateProof(param.inputs, param.provingKey, param.wasm));
}

class JWZDataSource {
  final CircomLib _circomLib;
  final WalletDataSource _walletDataSource;
  final JWZIsolatesWrapper _jwzIsolateWrapper;

  JWZDataSource(
      this._circomLib, this._walletDataSource, this._jwzIsolateWrapper);

  Future<String> getAuthToken(
      {required Uint8List privateKey,
      required String authClaim,
      required String message,
      required String circuitId,
      required Uint8List datFile,
      required Uint8List zKeyFile}) async {
    JWZ jwz = JWZ(
        header: JWZHeader(
            circuitId: "auth",
            crit: const ["circuitId"],
            typ: "application/iden3-zkp-json",
            alg: "groth16"),
        payload: JWZPayload(payload: message));
    Uint8List prepared;
    try {
      prepared =
          await _prepare(privateKey, authClaim, _getHash(jwz), circuitId);
    } catch (e) {
      rethrow;
    }
    jwz.proof = await _prove(prepared, zKeyFile, datFile);

    var token = JWZToken.withJWZ(jwz: jwz);

    return token.encode();
  }

  /// Prepare inputs
  Future<Uint8List> _prepare(Uint8List privateKey, String authClaim,
      Uint8List hash, String circuitId) {
    return _walletDataSource
        .createWallet(privateKey: privateKey)
        .then((wallet) async {
      String queryInputs = "";
      String challenge = bytesToInt(hash).toString();
      String signature;
      try {
        signature = await _walletDataSource.signMessage(
            privateKey: privateKey, message: challenge);
      } catch (e) {
        rethrow;
      }

      if (circuitId == "auth") {
        queryInputs = await _jwzIsolateWrapper.computeAuthInputs(challenge,
            authClaim, wallet.publicKey[0], wallet.publicKey[1], signature);
      }

      return Uint8ArrayUtils.uint8ListfromString(queryInputs);
    });
  }

  Uint8List _getHash(JWZ jwz) {
    if (jwz.header == null) {
      throw NullJWZHeaderException();
    }

    if (jwz.payload == null) {
      throw NullJWZPayloadException();
    }

    // Sha256
    Uint8List sha = Uint8List.fromList(sha256
        .convert(Uint8ArrayUtils.uint8ListfromString(
            "${jwz.header!.encode()}.${jwz.payload!.encode()}"))
        .bytes);

    // Endianness
    BigInt endian = Uint8ArrayUtils.leBuff2int(sha);

    // Check Q
    BigInt q = endian.qNormalize();

    // Poseidon hash
    String hashed = _circomLib.poseidonHash(q.toString());

    return hexToBytes(hashed);
  }

  /// Calculate proof
  Future<JWZProof> _prove(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm) {
    return _jwzIsolateWrapper
        .computeCalculateProof(inputs, provingKey, wasm)
        .then((proof) => JWZProof(
            proof: JWZBaseProof.fromJson(proof!["proof"]),
            pubSignals: (proof["pub_signals"] as List<String>)));
  }
}
