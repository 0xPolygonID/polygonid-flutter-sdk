import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import "package:hex/hex.dart";
import 'package:privadoid_sdk/eddsa_babyjub.dart';
import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/hex_utils.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

class PrivadoIdSdk {
  static const MethodChannel _channel = MethodChannel('privadoid_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> createNewIdentity() async {
    final PrivadoIdWallet wallet =
        await PrivadoIdWallet.createPrivadoIdWallet();

    /*Uint8List bytes = HexUtils.hexToBytes(wallet.publicKeyHex[0]);

    final String? version = await _channel.invokeMethod(
        'createNewIdentity', [wallet.publicKeyHex[0], wallet.publicKeyHex[1]]);*/

    return HexUtils.bytesToHex(wallet.privateKey);
  }

  static Future<Map<String, dynamic>> generateProof(String challenge,
      {String privateKey =
          "21a5e7321d0e2f3ca1cc6504396e6594a2211544b08c206847cdee96f832421a"}) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    final String? mtRoot = await _channel.invokeMethod(
        'getMerkleTreeRoot', [wallet.publicKeyHex[0], wallet.publicKeyHex[1]]);
    Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot!));
    BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));

    String state = wallet.hashMessage(mtRootBigInt.toString(),
        BigInt.zero.toString(), BigInt.zero.toString());
    Uint8List bufState = Uint8List.fromList(HEX.decode(state));
    BigInt stateBigInt = Uint8ArrayUtils.beBuff2int(bufState);

    final String? genesisId =
        await _channel.invokeMethod('getGenesisId', [state]);
    Uint8List bufGenesisId = Uint8List.fromList(HEX.decode(genesisId!));
    BigInt genesisIdBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufGenesisId.reversed.toList()));

    //Babyjubjub signature packed and encoded as an hex string
    String signatureString = wallet.signMessage(challenge);
    print("signature");
    print(signatureString);
    Uint8List buf = Uint8List.fromList(HEX.decode(signatureString));
    Signature signature = Signature.newFromCompressed(buf);
    print(signature.s.toString());
    print(signature.r8[0].toString());
    print(signature.r8[1].toString());

    Map<String, dynamic> json = <String, dynamic>{};
    json["BBJAx"] = wallet.publicKey[0];
    json["BBJAy"] = wallet.publicKey[1];
    json["BBJClaimClaimsTreeRoot"] = mtRootBigInt.toString();
    json["BBJClaimMtp"] = ["0", "0", "0", "0"];
    json["BBJClaimRevTreeRoot"] = "0";
    json["BBJClaimRootsTreeRoot"] = "0";
    json["challenge"] = challenge;
    json["challengeSignatureR8x"] = signature.r8[0].toString();
    json["challengeSignatureR8y"] = signature.r8[1].toString();
    json["challengeSignatureS"] = signature.s.toString();
    json["id"] = genesisIdBigInt.toString();
    json["state"] = stateBigInt.toString();

    return json;

    //ProofRequest proofRequest = ProofRequest.fromJson(json);
    //return proofRequest.toJson(); //jsonEncode(proofRequest.toJson());
  }
}
