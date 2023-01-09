import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/utils/big_int_extension.dart';
import 'package:polygonid_flutter_sdk/identity/libs/bjj/bjj.dart';
import 'package:polygonid_flutter_sdk/proof/libs/witnesscalc/auth_v2/witness_auth.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/utils/base_64.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../../../proof/data/dtos/gist_proof_dto.dart';
import '../../../proof/data/dtos/proof_dto.dart';
import '../../../proof/domain/entities/jwz/jwz.dart';
import '../../../proof/domain/entities/jwz/jwz_exceptions.dart';
import '../../../proof/domain/entities/jwz/jwz_header.dart';
import '../../../proof/domain/entities/jwz/jwz_proof.dart';
import '../../../proof/libs/prover/prover.dart';
import '../../../proof/libs/witnesscalc/auth/witness_auth.dart';
import 'prepare_inputs_data_source.dart';
import 'wallet_data_source.dart';

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
  /*Future<String> computeAuthInputs(String challenge, String authClaim,
      String pubX, String pubY, String signature) {
    return compute(_computeAuthInputs,
        AuthInputsIsolateParam(challenge, authClaim, pubX, pubY, signature));
  }*/

  Future<Map<String, dynamic>?> computeCalculateProof(
      Uint8List inputs, Uint8List provingKey, Uint8List wasm) {
    return compute(_computeCalculateProof,
        CalculateProofIsolateParam(inputs, provingKey, wasm));
  }
}

/// Isolates have to be top level methods or statics

/// As this is running is a separate thread, we cannot inject [Iden3CoreLib]
/*Future<String> _computeAuthInputs(AuthInputsIsolateParam param) {
  final prepare = PrepareInputsDataSource();

  return Future.value(polygonIdCoreProof.prepareAuthInputs(param.challenge,
      param.authClaim, param.pubX, param.pubY, param.signature));
}*/

/// As this is running is a separate thread, we cannot inject [Iden3CoreLib]
Future<Map<String, dynamic>?> _computeCalculateProof(
    CalculateProofIsolateParam param) async {
  final witnessAuthLib = WitnessAuthV2Lib();
  final proverLib = ProverLib();

  final Uint8List? wtnsBytes =
      await witnessAuthLib.calculateWitnessAuth(param.wasm, param.inputs);

  return Future.value(proverLib.prove(param.provingKey, wtnsBytes!));
}

class JWZDataSource {
  final BabyjubjubLib _babyjubjubLib;
  final WalletDataSource _walletDataSource;
  final PrepareInputsDataSource _prepareInputsDataSource;
  final JWZIsolatesWrapper _jwzIsolateWrapper;

  JWZDataSource(this._babyjubjubLib, this._walletDataSource,
      this._prepareInputsDataSource, this._jwzIsolateWrapper);

  Future<String> getAuthToken(
      {required Uint8List privateKey,
      required String did,
      required int profileNonce,
      required List<String> authClaim,
      required ProofDTO incProof,
      required ProofDTO nonRevProof,
      required GistProofDTO gistProof,
      required Map<String, dynamic> treeState,
      required String message,
      required String circuitId,
      required Uint8List datFile,
      required Uint8List zKeyFile}) async {
    JWZEntity jwz = JWZEntity(
        header: JWZHeader(
            circuitId: "authV2",
            crit: const ["circuitId"],
            typ: "application/iden3-zkp-json",
            alg: "groth16"),
        payload: JWZPayload(payload: message));

    String challenge = bytesToInt(_getHash(jwz)).toString();
    String signature = await _walletDataSource.signMessage(
        privateKey: privateKey, message: challenge);

    Uint8List prepared = await _prepare(did, profileNonce, authClaim, incProof,
        nonRevProof, gistProof, treeState, challenge, signature, circuitId);

    jwz.proof = await _prove(prepared, zKeyFile, datFile);

    var token = JWZToken.withJWZ(jwz: jwz);

    return token.encode();
  }

  /// Prepare inputs
  Future<Uint8List> _prepare(
      /*Uint8List privateKey,*/ String did,
      int profileNonce,
      List<String> authClaim,
      ProofDTO incProof,
      ProofDTO nonRevProof,
      GistProofDTO gistProof,
      Map<String, dynamic> treeState,
      String challenge,
      String signature,
      /*Uint8List hash,*/ String circuitId) async {
    String? inputs = "";
    if (circuitId == "authV2") {
      inputs = await _prepareInputsDataSource.prepareAuthInputs(
          did: did,
          profileNonce: profileNonce,
          authClaim: authClaim,
          incProof: incProof,
          nonRevProof: nonRevProof,
          gistProof: gistProof,
          treeState: treeState,
          challenge: challenge,
          signature: signature);
      //queryInputs = await _jwzIsolateWrapper.computeAuthInputs(challenge,
      //    authClaim, wallet.publicKey[0], wallet.publicKey[1], signature);
    }

    return Uint8ArrayUtils.uint8ListfromString(inputs!);
  }

  Uint8List _getHash(JWZEntity jwz) {
    if (jwz.header == null) {
      throw NullJWZHeaderException();
    }

    if (jwz.payload == null) {
      throw NullJWZPayloadException();
    }

    // Sha256
    Uint8List sha = Uint8List.fromList(sha256
        .convert(Uint8ArrayUtils.uint8ListfromString(
            "${Base64Util.encode64(jsonEncode(jwz.header!))}.${Base64Util.encode64(jsonEncode(jwz.payload!))}"))
        .bytes);

    // Endianness
    BigInt endian = Uint8ArrayUtils.leBuff2int(sha);

    // Check Q
    BigInt q = endian.qNormalize();

    // Poseidon hash
    String hashed = _babyjubjubLib.poseidonHash(q.toString());

    return intToBytes(BigInt.parse(hashed));
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
