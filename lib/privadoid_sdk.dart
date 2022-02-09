import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import "package:hex/hex.dart";
import 'package:privadoid_sdk/eddsa_babyjub.dart';
import 'package:privadoid_sdk/http.dart';
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

  static Future<String?> prepareAuthInputs(
      String challenge, String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String signatureString = wallet.signMessage(challenge);

    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    var authInputs = iden3coreLib.prepareAuthInputs(
        challenge, wallet.publicKey[0], wallet.publicKey[1], signatureString);
    return authInputs;
  }

  static Future<String?> prepareAtomicQueryInputs(
      String challenge, String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String signatureString = wallet.signMessage(challenge);

    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    var queryInputs = iden3coreLib.prepareAtomicQueryInputs(
        challenge, wallet.publicKey[0], wallet.publicKey[1], signatureString);
    return queryInputs;
  }

  static Future<String?> parseClaim(
      String jsonLDDocument, String schema) async {
    Iden3CoreLib iden3coreLib = Iden3CoreLib();
    var uri = Uri.parse(
        "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/auth.json-ld");
    final res = await get(uri.authority, uri.path);
    schema = (res.body);
    jsonLDDocument =
        "{\"id\":\"c0f6ac87-603e-44cd-8d83-0caeb458d50d\",\"@context\":[\"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/iden3credential.json-ld\",\"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/auth.json-ld\"],\"@type\":[\"Iden3Credential\"],\"expiration\":\"2361-03-21T21:14:48+02:00\",\"updatable\":false,\"version\":0,\"rev_nonce\":2034832188220019200,\"credentialSubject\":{\"type\":\"AuthBJJCredential\",\"x\":\"12747559771369266961976321746772881814229091957322087014312756428846389160887\",\"y\":\"7732074634595480184356588475330446395691728690271550550016720788712795268212\"},\"credentialStatus\":{\"id\":\"http://localhost:8001/api/v1/identities/118VhAf6ng6J44FhNrGeYzSbJgGVmcpeXYFR2YTrZ6/claims/revocation/status/2034832188220019081\",\"type\":\"SparseMerkleTreeProof\"},\"credentialSchema\":{\"@id\":\"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/auth.json-ld\",\"type\":\"JsonSchemaValidator2018\"},\"proof\":[{\"@type\":\"BJJSignature2021\",\"issuer\":\"118VhAf6ng6J44FhNrGeYzSbJgGVmcpeXYFR2YTrZ6\",\"h_index\":\"c89cf5b95157f091f2d8bf49bc1a57cd7988da83bbcd982a74c5e8c70e566403\",\"h_value\":\"0262b2cd6b9ae44cd9a39045c9bb03ad4e1f056cb81d855f1fc4ef0cdf827912\",\"created\":1642518655,\"issuer_mtp\":{\"@type\":\"Iden3SparseMerkleProof\",\"issuer\":\"118VhAf6ng6J44FhNrGeYzSbJgGVmcpeXYFR2YTrZ6\",\"h_index\":\"201a02eb979be695702ea37d930309d2965d803541be5f7b3900459b2fad8726\",\"h_value\":\"0654da1d53ca201cb42b767a6f12265ff7a08720b88a82182e0f20702479d12d\",\"state\":{\"claims_tree_root\":\"a5087cfa6f2c7c565d831327091533f09999133df1df51104d2ce6f8e4d90529\",\"value\":\"dca344e95da517a301729d94b213298b9de96dfddaf7aad9423d918ea3208820\"},\"mtp\":{\"existence\":true,\"siblings\":[]}},\"verification_method\":\"2764e2d8241b18c217010ebf90bebb30240d32c33f3007f33e42d58680813123\",\"proof_value\":\"c354eb1006534c59766ed8398d49a9a614312e430c5373ea493395db6369d49485e9a0d63f3bfe9fd157294ffbf706b6b7df7a8662a58fae0056a046af1caa04\",\"proof_purpose\":\"Authentication\"},{\"@type\":\"Iden3SparseMerkleProof\",\"issuer\":\"118VhAf6ng6J44FhNrGeYzSbJgGVmcpeXYFR2YTrZ6\",\"h_index\":\"c89cf5b95157f091f2d8bf49bc1a57cd7988da83bbcd982a74c5e8c70e566403\",\"h_value\":\"0262b2cd6b9ae44cd9a39045c9bb03ad4e1f056cb81d855f1fc4ef0cdf827912\",\"state\":{\"tx_id\":\"0xf2e23524ab76cb4f371b921a214ff411d5d391962899a2afe20f356e3bdc0c71\",\"block_timestamp\":1642522496,\"block_number\":11837707,\"claims_tree_root\":\"bebcaee8444e93b6e32855f54e9f617d5fd654570badce7d6bc649304169681d\",\"revocation_tree_root\":\"0000000000000000000000000000000000000000000000000000000000000000\",\"value\":\"2806aa9a045b2a5503b12f2979b2d19933e803fd3dd73d8ad40dc138bc9a582e\"},\"mtp\":{\"existence\":true,\"siblings\":[\"0\",\"0\",\"0\",\"18555164879275043542501047154170418730098376961920428892719505858997411121317\"]}}]}";
    // https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/auth.json-ld
    schema =
        "{\"@context\": [{\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"AuthBJJCredential\": {\"@id\": \"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/auth.json-ld#AuthBJJCredential\", \"@context\": {\"@version\": 1.1, \"@protected\": true, \"id\": \"@id\", \"type\": \"@type\", \"auth-vocab\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/auth.md#\", \"serialization\": \"https://github.com/iden3/claim-schema-vocab/blob/main/credentials/serialization.md#\", \"x\": {\"@id\": \"auth-vocab:x\", \"@type\": \"serialization:IndexDataSlotA\"}, \"y\": {\"@id\": \"auth-vocab:y\", \"@type\": \"serialization:IndexDataSlotB\"}}}}]}";
    var a = iden3coreLib.parseClaim(jsonLDDocument, schema);

    return '';

    /*//var a = iden3coreLib.prepareAuthInputs();
    // return '';
    //var ss = await _channel.invokeMethod('parseClaim', [jsonLDDocument, schema]);

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
    // print(ss);*/
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
