import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import "package:hex/hex.dart";
import 'package:privadoid_sdk/eddsa_babyjub.dart';
import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/hex_utils.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

import 'libs/iden3corelib.dart';

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

  static Future<String?> parseClaim(
      String jsonLDDocument, String schema) async {
    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    //var a = iden3coreLib.getFieldSlotIndex();
    var a = iden3coreLib.prepareAuthInputs();
    // return '';
    //var ss = await _channel.invokeMethod('parseClaim', [jsonLDDocument, schema]);
    return '';

    List<String>? authClaimTree = [];

    var entryRes =
        await _channel.invokeMethod('parseClaim', [jsonLDDocument, schema]);
    print('object: $entryRes');

    /*final List<Object?> oldEntryRes = await _channel.invokeMethod(
        'getAuthClaimTreeEntry', [wallet.publicKey[0], wallet.publicKey[1]]);*/

    print("newAuthClaimTreeEntry111: " + entryRes.toString());
    //print("oldAuthClaimTreeEntry: " + oldEntryRes.toString());
    //print("OldMtRoot: " + mtOldRoot!);

    for (var i = 0; i < entryRes.length; i++) {
      Uint8List bufEntry = Uint8List.fromList(HEX.decode(entryRes[i]));
      BigInt entryBigInt = Uint8ArrayUtils.beBuff2int(
          Uint8List.fromList(bufEntry.reversed.toList()));
      authClaimTree.add(entryBigInt.toString());
    }
    print('ss-------');
    print(authClaimTree);
    // print(ss);
  }

  static Future<String?> getIdentifier(String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    Iden3CoreLib iden3coreLib = Iden3CoreLib();

    final String? mtRoot = iden3coreLib.getMerkleTreeRoot(
        wallet.publicKey[0], wallet.publicKey[1]);

    /*final String? mtOldRoot = await _channel.invokeMethod(
        'getMerkleTreeRoot', [wallet.publicKey[0], wallet.publicKey[1]]);*/

    print("NewMtRoot: " + mtRoot!);
    //print("OldMtRoot: " + mtOldRoot!);

    Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot));
    BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));

    print("mtRootBigInt: " +
        mtRootBigInt
            .toString()); // 290650974844617975035577804953618192787930000597803545869756570371061099582

    String state = wallet.hashMessage(mtRootBigInt.toString(),
        BigInt.zero.toString(), BigInt.zero.toString());
    Uint8List bufState = Uint8List.fromList(HEX.decode(state));
    BigInt stateBigInt = Uint8ArrayUtils.beBuff2int(bufState);

    final String? genesisId = iden3coreLib.getGenesisId(state);

    /*final String? oldGenesisId =
        await _channel.invokeMethod('getGenesisId', [state]);*/

    print("NewGenesisId: " + genesisId!);
    //print("OldGenesisId: " + oldGenesisId!);

    return genesisId;
  }

  static Future<Map<String, dynamic>> generateProof(
      String challenge, String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    final String? mtRoot = iden3coreLib.getMerkleTreeRoot(
        wallet.publicKey[0], wallet.publicKey[1]);

    /*final String? mtRoot = await _channel.invokeMethod(
        'getMerkleTreeRoot', [wallet.publicKey[0], wallet.publicKey[1]]);*/

    Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot!));
    BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));

    List<String>? authClaimTree = [];

    final List<String> entryRes = iden3coreLib.getAuthClaimTreeEntry(
        wallet.publicKey[0], wallet.publicKey[1]);

    /*final List<Object?> oldEntryRes = await _channel.invokeMethod(
        'getAuthClaimTreeEntry', [wallet.publicKey[0], wallet.publicKey[1]]);*/

    print("newAuthClaimTreeEntry: " + entryRes.toString());
    //print("oldAuthClaimTreeEntry: " + oldEntryRes.toString());
    //print("OldMtRoot: " + mtOldRoot!);

    for (var i = 0; i < entryRes.length; i++) {
      Uint8List bufEntry = Uint8List.fromList(HEX.decode(entryRes[i]));
      BigInt entryBigInt = Uint8ArrayUtils.beBuff2int(
          Uint8List.fromList(bufEntry.reversed.toList()));
      authClaimTree.add(entryBigInt.toString());
    }
    print("pubKeyX");
    print(wallet.publicKey[0]);
    print("pubKeyY");
    print(wallet.publicKey[1]);
    //Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot!));
    /*BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));*/

    String state = wallet.hashMessage(mtRootBigInt.toString(),
        BigInt.zero.toString(), BigInt.zero.toString());
    Uint8List bufState = Uint8List.fromList(HEX.decode(state));
    BigInt stateBigInt = Uint8ArrayUtils.beBuff2int(bufState);

    final String? genesisId = iden3coreLib.getGenesisId(state);

    /*final String? genesisId =
        await _channel.invokeMethod('getGenesisId', [state]);*/
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

    json['authClaim'] =
        authClaimTree; /*[
      "164867201768971999401702181843803888060",
      "0",
      //wallet.publicKey[0],
      //wallet.publicKey[1],
      "17640206035128972995519606214765283372613874593503528180869261482403155458945",
      "20634138280259599560273310290025659992320584624461316485434108770067472477956",
      "15930428023331155902",
      "0",
      "0",
      "0"
    ];*/
    json['authClaimMtp'] = [
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0"
    ];
    json['authClaimNonRevMtp'] = [
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0",
      "0"
    ];
    json['authClaimNonRevMtpAuxHi'] = "0";
    json['authClaimNonRevMtpAuxHv'] = "0";
    json['authClaimNonRevMtpNoAux'] = "1";
    json["challenge"] = challenge; //"1";
    json["challengeSignatureR8x"] = signature.r8[0].toString();
    // "8553678144208642175027223770335048072652078621216414881653012537434846327449";
    json["challengeSignatureR8y"] = signature.r8[1].toString();
    // "5507837342589329113352496188906367161790372084365285966741761856353367255709";
    json["challengeSignatureS"] = signature.s
        .toString(); //"2093461910575977345603199789919760192811763972089699387324401771367839603655";
    json['claimsTreeRoot'] = mtRootBigInt
        .toString(); // "209113798174833776229979813091844404331713644587766182643501254985715193770";
    json["id"] = genesisIdBigInt
        .toString(); //"293373448908678327289599234275657468666604586273320428510206058753616052224";
    json['revTreeRoot'] = "0";
    json['rootsTreeRoot'] = "0";
    json["state"] = stateBigInt
        .toString(); //"15383795261052586569047113011994713909892315748410703061728793744343300034754";

    //json["BBJAx"] = wallet.publicKey[0];
    //json["BBJAy"] = wallet.publicKey[1];

    return json;

    //ProofRequest proofRequest = ProofRequest.fromJson(json);
    //return proofRequest.toJson(); //jsonEncode(proofRequest.toJson());
  }
}
